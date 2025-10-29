# ECS Cluster + ALB with HTTPS support
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
  tags = var.tags
}

resource "aws_lb" "app" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.alb.id]
  tags               = var.tags
}

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  vpc_id      = var.vpc_id
  description = "Allow inbound HTTP/HTTPS"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}
