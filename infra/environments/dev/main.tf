# Configuración principal de Terraform para el entorno de desarrollo
# Este archivo orquesta la creación de recursos AWS específicos del entorno dev

terraform {
  backend "s3" {
    bucket         = "ecommerce-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

# Instanciación del módulo DynamoDB para almacenar órdenes del e-commerce
# El módulo se configura con los valores definidos en terraform.tfvars
module "dynamodb" {
  source = "../../modules/dynamodb"

  # Nombre de la tabla - consumido de dev_variables
  table_name = var.dev_variables.table_name

  # Clave de partición - consumed de dev_variables
  hash_key = var.dev_variables.hash_key

  # Clave de ordenamiento (opcional) - consumido de dev_variables
  range_key = var.dev_variables.range_key

  # Modo de facturación - consumido de dev_variables
  billing_mode = var.dev_variables.billing_mode

  # Atributos de la tabla - consumido de dev_variables
  attributes = var.dev_variables.attributes

  # Índices secundarios globales - consumido de dev_variables
  global_secondary_indexes = var.dev_variables.global_secondary_indexes

  # Configuración de TTL - consumido de dev_variables
  ttl_attribute = var.dev_variables.ttl_attribute
  ttl_enabled   = var.dev_variables.ttl_enabled

  # Configuración de streams - consumido de dev_variables
  stream_enabled   = var.dev_variables.stream_enabled
  stream_view_type = var.dev_variables.stream_view_type

  # Cifrado del lado del servidor - consumido de dev_variables
  server_side_encryption_enabled = var.dev_variables.server_side_encryption_enabled
  kms_key_arn                    = var.dev_variables.kms_key_arn

  # Recuperación a punto en el tiempo - consumido de dev_variables
  point_in_time_recovery_enabled = var.dev_variables.point_in_time_recovery_enabled

  # Réplicas globales - consumido de dev_variables
  replica_regions = var.dev_variables.replica_regions

  # Etiquetas estándar del entorno
  tags = merge(
    var.dev_variables.common_tags,
    {
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  )
}

# Recurso adicional: Política de acceso específica para el entorno de desarrollo
# Esta política permite a las funciones Lambda del entorno dev acceder a la tabla
resource "aws_iam_policy" "dynamodb_dev_access" {
  name        = "${var.dev_variables.table_name}-dev-access"
  description = "Política de acceso para operaciones CRUD en entorno de desarrollo"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DescribeTable"
        ]
        Resource = [
          module.dynamodb.table_arn,
          "${module.dynamodb.table_arn}/index/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:ListTables"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(
    var.dev_variables.common_tags,
    {
      Environment = "dev"
      Component   = "dynamodb-access"
    }
  )
}

# Recurso adicional: Bucket S3 para logs del entorno de desarrollo
resource "aws_s3_bucket" "dev_logs" {
  bucket = "${var.dev_variables.project_name}-${var.dev_variables.environment}-logs"

  tags = merge(
    var.dev_variables.common_tags,
    {
      Environment = "dev"
      Component   = "logging"
    }
  )
}

# Configuración de versionado del bucket de logs
resource "aws_s3_bucket_versioning" "dev_logs" {
  bucket = aws_s3_bucket.dev_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configuración de lifecycle para logs (eliminación después de 90 días en dev)
resource "aws_s3_bucket_lifecycle_configuration" "dev_logs" {
  bucket = aws_s3_bucket.dev_logs.id

  rule {
    id     = "delete-old-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}