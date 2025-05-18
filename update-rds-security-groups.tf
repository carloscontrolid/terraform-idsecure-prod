# update-rds-security-groups.tf
# If need to remove SGs, remove this file first
# locals
locals {
  rds_instances = [
    "idsecure-aurora-0-instance-1",
    "idsecure-aurora-0-readonly-instance-1",
    "push"
  ]
}

# add new rds sg
resource "null_resource" "attach_rds_sg" {
  for_each = toset(local.rds_instances)

  depends_on = [aws_security_group.idsecure_rds_security_group]

  # If new sg change id
  triggers = {
    sg_id = aws_security_group.idsecure_rds_security_group.id
  }

  provisioner "local-exec" {
    # executado no apply
    command = <<-EOT
      set -euo pipefail

      DB_ID=${each.key}
      NEW_SG=${aws_security_group.idsecure_rds_security_group.id}

      echo "🔄 Atualizando $DB_ID ..."

      # 1) Coleta SGs atuais da instância
      CURR_SGS=$(aws rds describe-db-instances \
        --region sa-east-1 \
        --db-instance-identifier "$DB_ID" \
        --query 'DBInstances[0].VpcSecurityGroups[].VpcSecurityGroupId' \
        --output text)

      # 2) Gera lista final (SGs atuais + SG novo), sem duplicar
      FINAL_SGS=$(printf "%s\n" $CURR_SGS $NEW_SG | sort -u | tr '\n' ' ')

      echo "    SGs finais: $FINAL_SGS"

      # 3) Aplica alteração (imediata)
      aws rds modify-db-instance \
        --region sa-east-1 \
        --db-instance-identifier "$DB_ID" \
        --vpc-security-group-ids $FINAL_SGS \
        --apply-immediately \

      echo "    ✅ $DB_ID atualizado."
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
