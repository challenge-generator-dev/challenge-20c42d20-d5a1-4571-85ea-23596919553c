# Definición de variables específicas para el entorno de desarrollo
# Estas variables permiten configurar los recursos de forma flexible

variable "dev_variables" {
  description = "Variables de configuración del entorno de desarrollo definidas en terraform.tfvars"
  type = object({
    # Configuración de la tabla DynamoDB
    table_name               = string
    hash_key                 = string
    range_key                = optional(string)
    billing_mode             = string
    attributes               = list(object({
      name = string
      type = string
    }))
    global_secondary_indexes = list(object({
      name               = string
      hash_key           = string
      range_key          = optional(string)
      projection_type    = string
      non_key_attributes = list(string)
      read_capacity      = number
      write_capacity     = number
    }))

    # Configuración de TTL
    ttl_attribute = optional(string)
    ttl_enabled   = optional(bool, false)

    # Configuración de streams
    stream_enabled   = optional(bool, false)
    stream_view_type = optional(string)

    # Configuración de cifrado
    server_side_encryption_enabled = optional(bool, false)
    kms_key_arn                    = optional(string)

    # Configuración de recuperación
    point_in_time_recovery_enabled = optional(bool, false)

    # Réplicas globales
    replica_regions = optional(list(object({
      region_name = string
    })), [])

    # Etiquetas comunes
    common_tags = map(string)

    # Metadatos del proyecto
    project_name  = string
    environment   = string
    owner_team    = optional(string, "platform-team")
    cost_center   = optional(string, "engineering")
  })

  validation {
    condition     = var.dev_variables.billing_mode != ""
    error_message = "El modo de facturación no puede estar vacío."
  }

  validation {
    condition     = length(var.dev_variables.table_name) > 0
    error_message = "El nombre de la tabla no puede estar vacío."
  }

  validation {
    condition     = length(var.dev_variables.attributes) > 0
    error_message = "Debe proporcionar al menos un atributo para la tabla."
  }
}

variable "environment" {
  description = "Nombre del entorno de despliegue"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser dev, staging o prod."
  }
}

variable "aws_region" {
  description = "Región AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "enable_monitoring" {
  description = "Habilitar métricas y alertas de CloudWatch para el entorno"
  type        = bool
  default     = false
}

variable "retention_days" {
  description = "Días de retención de logs en S3"
  type        = number
  default     = 90
  validation {
    condition     = var.retention_days >= 7 && var.retention_days <= 365
    error_message = "La retención de logs debe estar entre 7 y 365 días."
  }
}