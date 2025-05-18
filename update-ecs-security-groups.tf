# update-ecs-security-groups.tf
# If need to remove SGs, remove this file first
# variables
variable "ecs_cluster_name" {
  description = "Nome do cluster ECS"
  type        = string
  default     = "idsecure-cluster"
}

# Current security groups and subnet
locals {
  services = {
    idsecure-online = {
      subnets         = ["subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925"]
      assign_public   = true
    }
    idsecure-main = {
      subnets         = ["subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925"]
      assign_public   = true
    }
    idsecure-report = {
      subnets         = ["subnet-0b01d3fc855844180", "subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925"]
      assign_public   = true
    }
    idsecure-hangfire2 = {
      subnets         = ["subnet-0b01d3fc855844180", "subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925"]
      assign_public   = true
    }
    idsecure-notify = {
      subnets         = ["subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925"]
      assign_public   = true
    }
    idsecure-admin = {
      subnets         = ["subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925", "sg-06138591ffee47dc6"]
      assign_public   = true
    }
    idsecure-push-new = {
      subnets         = ["subnet-0b01d3fc855844180", "subnet-0981b2247b0496d7d"]
      current_sgs     = ["sg-00730a0f3d047f925"]
      assign_public   = true
    }
  }
}

resource "null_resource" "attach_new_sg" {
  for_each = local.services

  depends_on = [aws_security_group.idsecure_ecs_security_group]

  triggers = {
    # If new sg change id
    new_sg_id = aws_security_group.idsecure_ecs_security_group.id
  }

  provisioner "local-exec" {
    command = <<-EOT
      set -euo pipefail
      aws ecs update-service \
        --region sa-east-1 \
        --cluster ${var.ecs_cluster_name} \
        --service ${each.key} \
        --network-configuration 'awsvpcConfiguration={
          subnets=[${join(",", each.value.subnets)}],
          securityGroups=[${join(",", concat(each.value.current_sgs, [aws_security_group.idsecure_ecs_security_group.id]))}],
          assignPublicIp=ENABLED
        }'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
