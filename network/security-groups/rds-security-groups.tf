# rds-security-groups.tf
# RDS – idsecure-rds-security-group
resource "aws_security_group" "idsecure_rds_security_group" {
  name        = "idsecure-rds-security-group"
  description = "Secure RDS Security Group (idsecure & push)"
  vpc_id      = var.idsecure_vpc_id

  ingress {
    description     = "MySQL 3306 iD Secure RDS Security Group"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = local.sorted_allowed_ips_port_3306
  }

  egress {
    description = "Outbound irrestrito"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
  }

  tags = {
    Name        = "idsecure-rds-security-group"
    Terraformed = var.terraform_tag
    CostCenter  = var.costcenter
  }
}
