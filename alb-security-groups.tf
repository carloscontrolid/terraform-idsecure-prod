# alb-security-groups.tf
# ALB – idsecure-loadbalancer-security-group-public
resource "aws_security_group" "idsecure_loadbalancer_security_group_public" {
  name        = "idsecure-loadbalancer-security-group-public"
  description = "iD Secure Public ALB"
  vpc_id      = var.idsecure_vpc_id

  ingress {
    description = "Port 443 (HTTPS) (idsecure-push)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 5000 (clients) (idsecure-report main)"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 5001 (idsecure-admin)"
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = local.sorted_allowed_ips_port_5001
  }

  ingress {
    description = "Port 5003 (devices) (idsecure-online)"
    from_port   = 5003
    to_port     = 5003
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 5004 (Notify)"
    from_port   = 5004
    to_port     = 5004
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description     = "All - iD Secure ECS Security Group"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
  }

  tags = {
    Name        = "idsecure-loadbalancer-security-group-public"
    Terraformed = var.terraform_tag
    CostCenter  = var.costcenter
  }
}

