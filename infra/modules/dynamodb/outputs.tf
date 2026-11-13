# Outputs del módulo DynamoDB

output "table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.arn
}

output "table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.name
}

output "table_id" {
  description = "ID de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.id
}

output "table_stream_arn" {
  description = "ARN del stream de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.stream_arn
}

output "table_stream_label" {
  description = "Etiqueta del stream de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.stream_label
}

output "access_policy_arn" {
  description = "ARN de la política de acceso a la tabla DynamoDB"
  value       = aws_iam_policy.dynamodb_access_policy.arn
}

output "global_secondary_indexes" {
  description = "Información de los índices secundarios globales"
  value = [
    for gsi in aws_dynamodb_table.orders_table.global_secondary_index :
    {
      name               = gsi.name
      arn                = "${aws_dynamodb_table.orders_table.arn}/index/${gsi.name}"
      projection_type    = gsi.projection_type
      non_key_attributes = gsi.non_key_attributes
    }
  ]
}

output "table_tags" {
  description = "Etiquetas aplicadas a la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.tags
}

output "replica_regions" {
  description = "Regiones de réplica configuradas"
  value       = aws_dynamodb_table.orders_table.replica[*].region_name
}