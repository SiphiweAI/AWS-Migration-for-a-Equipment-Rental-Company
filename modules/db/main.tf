resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  vpc_id      = var.vpc_id
  description = "Allow DB traffic from ECS only"

  ingress {
    description = "Allow MySQL from ECS"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.ecs_sg_id] # optional if ECS module exports SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "main" {
  identifier              = "${var.project_name}-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "admin"
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = false
  deletion_protection     = true
  publicly_accessible     = false
  backup_retention_period = 7
  tags                    = var.tags
}
