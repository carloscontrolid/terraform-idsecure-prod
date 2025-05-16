# provider-variables.tf
# Credentials
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

# Region
variable "AWS_region" {
  description = "AWS Region"
  default     = "sa-east-1"
  type        = string
}
