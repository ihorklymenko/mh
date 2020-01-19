data "template_file" "this" {
  template = file("${path.module}/task_definition.json.tpl")

  vars = {
    AWS_REGION  = var.region
    LOGS_GROUP  = aws_cloudwatch_log_group.this.name
    APPLICATION = var.application
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project}-${var.environment}-${var.application}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.this.arn
  cpu                      = 256
  memory                   = 512
  container_definitions    = data.template_file.this.rendered
}

resource "aws_ecs_service" "this" {
  name            = "${var.project}-${var.environment}-${var.application}"
  cluster         = module.ecs-cluster.this_ecs_cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = var.replicas_count

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
    container_name   = var.application
    container_port   = 80
  }

  depends_on = [aws_alb_listener.this]
}

resource "aws_security_group" "ecs" {
  name   = "${var.project}-${var.environment}-${var.application}-ecs"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.project}-${var.environment}-${var.application}"
  retention_in_days = 1
}
