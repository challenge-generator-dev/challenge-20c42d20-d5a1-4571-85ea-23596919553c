# Variables de entrada para el módulo DynamoDB

variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
  validation {
    condition     = length(var.table_name) > 3 && length(var.table_name) <= 255
    error_message = "El nombre de la tabla debe tener entre 4 y 255 caracteres."
  }
}

variable "billing_mode" {
  description = "Modo de facturación de la tabla (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "El modo de facturación debe ser PROVISIONED o PAY_PER_REQUEST."
  }
}

variable "hash_key" {
  description = "Clave hash (partition key) de la tabla"
  type        = string
  validation {
    condition     = length(var.hash_key) > 0
    error_message = "La clave hash no puede estar vacía."
  }
}

variable "range_key" {
  description = "Clave de rango (sort key) de la tabla"
  type        = string
  default     = null
}

variable "attributes" {
  description = "Lista de atributos de la tabla"
  type = list(object({
    name = string
    type = string
  }))
  validation {
    condition     = length(var.attributes) > 0
    error_message = "Debe proporcionar al menos un atributo para la tabla."
  }
  validation {
    condition = alltrue([
      for attr in var.attributes : contains(["S", "N", "B"], attr.type)
    ])
    error_message = "Los tipos de atributos válidos son S (string), N (number) y B (binary)."
  }
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales (GSI)"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = string
    projection_type    = string
    non_key_attributes = list(string)
    read_capacity      = number
    write_capacity     = number
  }))
  default = []
  validation {
    condition = alltrue([
      for gsi in var.global_secondary_indexes : contains(["KEYS_ONLY", "INCLUDE", "ALL"], gsi.projection_type)
    ])
    error_message = "Los tipos de proyección válidos son KEYS_ONLY, INCLUDE y ALL."
  }
}

variable "ttl_attribute" {
  description = "Atributo para Time To Live (TTL)"
  type        = string
  default     = null
}

variable "ttl_enabled" {
  description = "Habilitar Time To Live (TTL)"
  type        = bool
  default     = false
}

variable "stream_enabled" {
  description = "Habilitar streams de DynamoDB"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = null
  validation {
    condition     = var.stream_view_type == null ? true : contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "El tipo de vista del stream debe ser KEYS_ONLY, NEW_IMAGE, OLD_IMAGE o NEW_AND_OLD_IMAGES."
  }
}

variable "server_side_encryption_enabled" {
  description = "Habilitar cifrado del lado del servidor"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado"
  type        = string
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Habilitar recuperación a un punto en el tiempo"
  type        = bool
  default     = false
}

variable "replica_regions" {
  description = "Regiones para réplicas globales"
  type = list(object({
    region_name = string
  }))
  default = []
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}