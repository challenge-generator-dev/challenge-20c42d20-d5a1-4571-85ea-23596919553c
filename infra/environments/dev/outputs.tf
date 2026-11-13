# Definición de outputs para el entorno de desarrollo
# Expone la información de los recursos creados para consumo externo

# Output principal: información de la tabla DynamoDB creada
output "dynamodb_table" {
  description = "Información de la tabla DynamoDB creada para el entorno de desarrollo"
  value = {
    arn      = module.dynamodb.table_arn
    name     = module.dynamodb.table_name
    id       = module.dynamodb.table_id
    stream_arn = module.dynamodb.table_stream_arn
    stream_label = module.dynamodb.table_stream_label
  }
}

# Output: nombre de la tabla DynamoDB
output "table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes"
  value       = module.dynamodb.table_name
  sensitive   = false
}

# Output: ARN de la tabla DynamoDB
output "table_arn" {
  description = "ARN completo de la tabla DynamoDB"
  value       = module.dynamodb.table_arn
  sensitive   = false
}

# Output: política de acceso creada
output "dynamodb_access_policy" {
  description = "Política IAM de acceso a la tabla DynamoDB"
  value = {
    arn  = aws_iam_policy.dynamodb_dev_access.arn
    name = aws_iam_policy.dynamodb_dev_access.name
    id   = aws_iam_policy.dynamodb_dev_access.id
  }
  sensitive = false
}

# Output: bucket de logs del entorno
output "logs_bucket" {
  description = "Bucket S3 para almacenamiento de logs del entorno"
  value = {
    name                 = aws_s3_bucket.dev_logs.id
    arn                  = aws_s3_bucket.dev_logs.arn
    versioning_status    = aws_s3_bucket_versioning.dev_logs.versioning_configuration[0].status
    lifecycle_rule_id    = aws_s3_bucket_lifecycle_configuration.dev_logs.rule[0].id
    retention_days       = var.retention_days
  }
  sensitive = false
}

# Output: configuración del entorno
output "environment_config" {
  description = "Configuración general del entorno de desarrollo"
  value = {
    environment         = var.environment
    aws_region          = var.aws_region
    enable_monitoring   = var.enable_monitoring
    retention_days      = var.retention_days
    project_name        = var.dev_variables.project_name
    owner_team          = var.dev_variables.owner_team
    cost_center         = var.dev_variables.cost_center
  }
  sensitive = false
}

# Output: índices secundarios globales configurados
output "global_secondary_indexes" {
  description = "Índices secundarios globales configurados en la tabla"
  value       = module.dynamodb.global_secondary_indexes
  sensitive   = false
}

# Output: regiones de réplica (si aplica)
output "replica_regions" {
  description = "Regiones de réplica configuradas para la tabla"
  value       = module.dynamodb.replica_regions
  sensitive   = false
}

# Output: etiquetas aplicadas a los recursos
output "resource_tags" {
  description = "Etiquetas aplicadas a los recursos del entorno"
  value       = module.dynamodb.table_tags
  sensitive   = false
}

# Output: URL del bucket de logs (para configuración de aplicaciones)
output "logs_bucket_url" {
  description = "URL del bucket S3 de logs para configuración en aplicaciones"
  value       = "s3://${aws_s3_bucket.dev_logs.id}"
  sensitive   = false
}

# Output: endpoint de DynamoDB (útil para desarrollo local con LocalStack)
output "dynamodb_endpoint" {
  description = "Endpoint de DynamoDB para el entorno (usar en desarrollo local)"
  value       = "https://dynamodb.${var.aws_region}.amazonaws.com"
  sensitive   = false
}