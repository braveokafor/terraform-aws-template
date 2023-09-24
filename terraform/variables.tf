variable "region" {
  type        = string
  description = "Default AWS region."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Current Environment"
}

variable "prefix" {
  type        = string
  description = "Prefix to prepend to resources (for easy identification)."
}



variable "assume_role_arn" {
  type        = string
  description = "AWS role to assume when provisioning resources"
  default     = ""
}

variable "assume_role_external_id" {
  type        = string
  description = "Extenal ID associated with the \"assume_role_arn\"."
  default     = ""
}
