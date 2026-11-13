# Variables para el entorno de desarrollo
# Configuración específica para la tabla DynamoDB de órdenes

table_name = "orders-dev"
billing_mode = "PAY_PER_REQUEST"
hash_key = "order_id"
range_key = "created_at"

# Definición de atributos de la tabla
attributes = [
  {
    name = "order_id"
    type = "S"
  },
  {
    name = "created_at"
    type = "S"
  },
  {
    name = "customer_id"
    type = "S"
  },
  {
    name = "status"
    type = "S"
  }
]

# Índices secundarios globales (GSI)
global_secondary_indexes = [
  {
    name               = "CustomerIndex"
    hash_key           = "customer_id"
    range_key          = "created_at"
    projection_type    = "INCLUDE"
    non_key_attributes = ["order_id", "status", "items"]
    read_capacity      = 0
    write_capacity     = 0
  },
  {
    name               = "StatusIndex"
    hash_key           = "status"
    range_key          = "created_at"
    projection_type    = "KEYS_ONLY"
    read_capacity      = 0
    write_capacity     = 0
  }
]

# Etiquetas para los recursos
tags = {
  Environment = "dev"
  Application = "ecommerce-orders"
  Terraform   = "true"
}

# Configuración de TTL (Time To Live)
ttl_attribute = "expiration_time"
ttl_enabled   = true

# Configuración de streams para eventos
stream_enabled   = true
stream_view_type = "NEW_AND_OLD_IMAGES"

# Configuración de cifrado
server_side_encryption_enabled = true
kms_key_arn                    = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-5678-90ef-ghij-klmnopqrstuv"

# Configuración de backups
point_in_time_recovery_enabled = true

# Configuración de capacidad para pruebas de carga
replica_regions = [
  {
    region_name = "us-west-2"
  }
]

# Validaciones de esquema
schema_validation = {
  required_attributes = ["order_id", "created_at", "customer_id", "status", "items"]
  attribute_constraints = {
    order_id = {
      regex = "^ORD-[A-Za-z0-9]{8}$"
    }
    status = {
      allowed_values = ["PENDING", "PROCESSING", "SHIPPED", "DELIVERED", "CANCELLED"]
    }
  }
}