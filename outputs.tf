# outputs.tf

output "lb_security_group_id" {
  description = "Load Balancer SG ID"
  value       = aws_security_group.idsecure_loadbalancer_security_group_public.id
}

output "app_security_group_id" {
  description = "ECS SG ID"
  value       = aws_security_group.idsecure_ecs_security_group.id
}

output "db_security_group_id" {
  description = "RDS SG ID"
  value       = aws_security_group.idsecure_rds_security_group.id
}
