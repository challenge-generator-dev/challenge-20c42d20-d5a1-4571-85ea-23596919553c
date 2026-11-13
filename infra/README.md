# Infraestructura Terraform - CRUD de Órdenes DynamoDB

Este componente contiene la definición de infraestructura como código para el sistema de gestión de órdenes sobre DynamoDB.

## Propósito

Provisiona los recursos de AWS necesarios para soportar el CRUD de órdenes en un sistema de e-commerce, incluyendo:
- Tabla DynamoDB para almacenamiento de órdenes
- Políticas IAM para acceso a la tabla
- Recursos auxiliares según necesidad del entorno

## Estructura de Directorios

```
infra/
├── environments/
│   └── dev/
│       ├── main.tf          # Configuración del entorno de desarrollo
│       ├── variables.tf     # Variables específicas del entorno
│       └── outputs.tf       # Outputs del entorno
├── modules/
│   └── dynamodb/
│       ├── main.tf          # Recurso principal de DynamoDB
│       ├── variables.tf     # Variables del módulo
│       └── outputs.tf       # Outputs del módulo
├── versions.tf              # Versiones de Terraform y providers
├── providers.tf             # Configuración de providers
└── README.md                # Este archivo
```

## Requisitos Previos

- Terraform >= 1.9.0
- AWS CLI configurado con credenciales válidas
- Permisos para crear recursos en la cuenta de AWS objetivo

## Configuración Inicial

### 1. Configurar credenciales AWS

```bash
export AWS_ACCESS_KEY_ID="tu_access_key"
export AWS_SECRET_ACCESS_KEY="tu_secret_key"
export AWS_REGION="us-east-1"
```

### 2. Inicializar Terraform

```bash
cd infra
terraform init
```

### 3. Validar la configuración

```bash
terraform validate
terraform plan
```

## Uso del Módulo DynamoDB

### Ejemplo Básico

Para crear una tabla de órdenes con la configuración por defecto:

```hcl
module "orders_table" {
  source = "../modules/dynamodb"
  
  table_name = "orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "order_id"
  
  attributes = [
    { name = "order_id", type = "S" },
    { name = "customer_id", type = "S" },
    { name = "status", type = "S" },
    { name = "created_at", type = "S" }
  ]
  
  tags = {
    Environment = "dev"
    Project     = "ecommerce-orders"
  }
}
```

### Ejemplo con GSI

Para crear una tabla con índices secundarios globales:

```hcl
module "orders_table_with_gsi" {
  source = "../modules/dynamodb"
  
  table_name = "orders"
  billing_mode = "PROVISIONED"
  hash_key = "order_id"
  
  attributes = [
    { name = "order_id", type = "S" },
    { name = "customer_id", type = "S" },
    { name = "status", type = "S" },
    { name = "created_at", type = "S" }
  ]
  
  global_secondary_indexes = [
    {
      name               = "customer_status_index"
      hash_key           = "customer_id"
      range_key          = "status"
      projection_type    = "ALL"
      non_key_attributes = ["order_id", "created_at", "total_amount"]
      read_capacity      = 5
      write_capacity     = 5
    }
  ]
  
  tags = {
    Environment = "dev"
    Project     = "ecommerce-orders"
  }
}
```

### Ejemplo con Cifrado y TTL

Para habilitar cifrado del lado del servidor y Time To Live:

```hcl
module "orders_table_secure" {
  source = "../modules/dynamodb"
  
  table_name = "orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "order_id"
  
  attributes = [
    { name = "order_id", type = "S" },
    { name = "created_at", type = "S" }
  ]
  
  # Habilitar cifrado con KMS
  server_side_encryption_enabled = true
  kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/your-key-id"
  
  # Habilitar TTL
  ttl_attribute    = "expires_at"
  ttl_enabled      = true
  
  # Habilitar streams para captura de cambios
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  
  tags = {
    Environment = "prod"
    Project     = "ecommerce-orders"
    Compliance  = "PII"
  }
}
```

## Variables del Módulo DynamoDB

| Variable | Tipo | Default | Descripción |
|----------|------|---------|-------------|
| `table_name` | string | - | Nombre de la tabla (requerido, 4-255 caracteres) |
| `billing_mode` | string | "PAY_PER_REQUEST" | Modo de facturación |
| `hash_key` | string | - | Clave hash de la tabla |
| `range_key` | string | null | Clave de rango de la tabla |
| `attributes` | list(object) | - | Lista de atributos de la tabla |
| `global_secondary_indexes` | list(object) | [] | Índices secundarios globales |
| `ttl_attribute` | string | null | Atributo para TTL |
| `ttl_enabled` | bool | false | Habilitar TTL |
| `stream_enabled` | bool | false | Habilitar streams |
| `stream_view_type` | string | null | Tipo de vista del stream |
| `server_side_encryption_enabled` | bool | false | Habilitar cifrado SSE |
| `kms_key_arn` | string | null | ARN de clave KMS |
| `point_in_time_recovery_enabled` | bool | false | Habilitar PITR |
| `replica_regions` | list(object) | [] | Regiones para réplicas globales |
| `tags` | map(string) | {} | Etiquetas para recursos |

## Outputs del Módulo

| Output | Descripción |
|--------|-------------|
| `table_arn` | ARN de la tabla DynamoDB |
| `table_name` | Nombre de la tabla |
| `table_id` | ID de la tabla |
| `table_stream_arn` | ARN del stream |
| `table_stream_label` | Etiqueta del stream |
| `access_policy_arn` | ARN de la política de acceso |
| `global_secondary_indexes` | Información de GSI |
| `table_tags` | Etiquetas aplicadas |
| `replica_regions` | Regiones de réplica |

## Aplicar Infraestructura

### Entorno de Desarrollo

```bash
cd environments/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Destruir Recursos

```bash
terraform destroy -var-file="terraform.tfvars"
```

## Consideraciones de Seguridad

1. **Cifrado**: Habilita `server_side_encryption_enabled` para datos en reposo
2. **KMS**: Usa claves KMS gestionadas o propias según requisitos de compliance
3. **TTL**: Configura TTL para datos que expiren automáticamente
4. **Streams**: Habilita streams solo si necesitas capturar cambios para otros procesos
5. **Réplicas**: Considera réplicas globales para alta disponibilidad

## Mejores Prácticas

- Usa estado remoto (S3) para colaboración en equipo
- Implementa workspaces para separación de entornos
- Versiona tu código de infraestructura
- Documenta variables y outputs
- Usa etiquetas consistentes en todos los recursos
- Implementa pipelines de CI/CD para cambios de infraestructura

## Recursos Adicionales

- [Documentación de Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Documentación de DynamoDB](https://docs.aws.amazon.com/dynamodb/)
- [Mejores prácticas de DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)