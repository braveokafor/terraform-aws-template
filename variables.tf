#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
variable "region" {
  type        = string
  description = "Default AWS region."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Current Environment"
  default     = "dev"
}

variable "prefix" {
  type        = string
  description = "Prefix to prepend to resources (for easy identification)."
  default     = "main"
}


variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}

#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
variable "assume_role_arn" {
  type        = string
  description = "AWS role to assume when provisioning resources"
  default     = ""
}

#------------------------------------------------------------------------------
# IAM
#------------------------------------------------------------------------------
variable "admin_users" {
  type        = list(string)
  description = "IAM users (username) to add to the `Admins` group."
  default     = []
}

variable "admin_user_iam_policies" {
  type        = list(string)
  description = "Admin user IAM policies"
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "dev_users" {
  type        = list(string)
  description = "IAM users (username) to add to the `Developers` group."
  default     = []
}

variable "dev_user_iam_policies" {
  type        = list(string)
  description = "Dev user IAM policies"
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
  ]
}

variable "basic_users" {
  type        = list(string)
  description = "IAM users (username) to add to the `Viewers` group."
  default     = []
}

variable "basic_user_iam_policies" {
  type        = list(string)
  description = "Basic user IAM policies"
  default     = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
}

#------------------------------------------------------------------------------
# Budget
#------------------------------------------------------------------------------
variable "monthly_budget" {
  type        = string
  description = "Monthly budget"
  default     = "100"
}

variable "budget_currency" {
  type        = string
  description = "The 3-letter currency code as defined in ISO 4217"
  default     = "USD"
}

variable "budget_alert_thresholds" {
  type        = list(number)
  default     = [50, 75, 90, 100]
  description = "What points (percentage) should billing alerts be sent"
}

variable "budget_alert_emails" {
  type    = list(string)
  default = []
}