# ecs-security-groups.tf
# ECS – idsecure-ecs-security-group
resource "aws_security_group" "idsecure_ecs_security_group" {
  name        = "idsecure-ecs-security-group"
  description = "iD Secure ECS Security Group"
  vpc_id      = var.idsecure_vpc_id

  # Tráfego originado do ALB
  ingress {
    description     = "Port 443 (HTTPS)"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.idsecure_loadbalancer_security_group_public.id]
  }

  # Port 5000
  ingress {
    description     = "Port 5000 (clients)"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.idsecure_loadbalancer_security_group_public.id]
  }

  # Port 5001
  ingress {
    description     = "Port 5001 (idsecure-admin)"
    from_port       = 5001
    to_port         = 5001
    protocol        = "tcp"
    security_groups = [aws_security_group.idsecure_loadbalancer_security_group_public.id]
  }

  # Port 5003
  ingress {
    description     = "Port 5003 (devices)"
    from_port       = 5003
    to_port         = 5003
    protocol        = "tcp"
    security_groups = [aws_security_group.idsecure_loadbalancer_security_group_public.id]
  }

  # Port 5004
  ingress {
    description     = "Port 5004 (idsecure-notify)"
    from_port       = 5004
    to_port         = 5004
    protocol        = "tcp"
    security_groups = [aws_security_group.idsecure_loadbalancer_security_group_public.id]
  }

  # Internal traffic
  ingress {
    description = "Internal traffic (self)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Egress Outbound all
  egress {
    description = "Outbound all"
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
    Name        = "idsecure-ecs-security-group"
    Terraformed = var.terraform_tag
    CostCenter  = var.costcenter
  }
}