resource "aws_alb" "this" {
  name = "${var.project}-${var.environment}-${var.application}-alb"

  security_groups = [
    aws_security_group.alb.id,
  ]

  subnets = module.vpc.public_subnets
}

resource "aws_alb_target_group" "this" {
  name        = "${var.project}-${var.environment}-${var.application}-tg"
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  port        = 80
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.this.arn
    type             = "forward"
  }

  depends_on = [aws_alb_target_group.this]
}

resource "aws_security_group" "alb" {
  name   = "${var.project}-${var.environment}-${var.application}-alb"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
