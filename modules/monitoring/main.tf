resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/${var.project_name}"
  retention_in_days = 14
}

resource "aws_backup_vault" "main" {
  name = "${var.project_name}-backup"
}
