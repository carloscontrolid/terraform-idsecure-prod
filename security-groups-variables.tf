# variables.tf
# VPC
variable "idsecure_vpc_id" {
  type        = string
  description = "Targer VPC ID"
  default     = "vpc-0aca5c50e2d8785ba"
}

locals {
  sorted_allowed_ips_port_5001 = sort(var.allowed_ips_port_5001)
  sorted_allowed_ips_port_3306 = sort(var.allowed_ips_port_3306)
}

# Ips Allowed
variable "allowed_ips_port_5001" {
  default = [
    "54.232.185.215/32", # RHIDPUSH-01
    "54.232.121.66/32",  # RHIDPUSH-02 (reserva)
    "54.233.146.134/32", # RHIDV2-relatorios
    "52.67.94.10/32",    # RHIDV2-principal
    "54.232.146.40/32",  # RHIDV2-1-WWW
    "54.233.161.78/32",  # RHIDV2-2-WWW
    "18.229.44.112/32",  # RHIDV2-3-WWW
    "18.229.237.196/32", # RHIDV2-4-WWW
    "18.230.83.232/32",  # RHIDV2-5-WWW
    "54.94.38.185/32",   # RHIDV2-6-MOBILE
    "15.229.57.119/32",  # RHIDV2-7-MOBILE
    "54.94.181.184/32",  # RHIDV2-8-WWW-RESERVA
    "54.207.124.43/32"   # Site
  ]
}

variable "allowed_ips_port_3306" {
  default = [
    "54.232.185.215/32", # RHIDPUSH-01
    "54.232.121.66/32",  # RHIDPUSH-02 (reserva)
    "54.233.146.134/32", # RHIDV2-relatorios
    "52.67.94.10/32",    # RHIDV2-principal
    "54.232.146.40/32",  # RHIDV2-1-WWW
    "54.233.161.78/32",  # RHIDV2-2-WWW
    "18.229.44.112/32",  # RHIDV2-3-WWW
    "18.229.237.196/32", # RHIDV2-4-WWW
    "18.230.83.232/32",  # RHIDV2-5-WWW
    "54.94.38.185/32",   # RHIDV2-6-MOBILE
    "15.229.57.119/32",  # RHIDV2-7-MOBILE
    "54.94.181.184/32",  # RHIDV2-8-WWW-RESERVA
    "52.67.200.88/32",   # Engenharia
    "52.67.138.147/32"   # Servidor Senior
  ]
}

# Tags and metadada
variable "terraform_tag" {
  description = "Terraform managed resources"
  type        = string
  default     = "true"
}

variable "costcenter" {
  description = "Cost Center"
  type        = string
  default     = "idsecure-prod"
}