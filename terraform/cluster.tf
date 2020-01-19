module "ecs-cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "2.0.0"

  name = "${var.project}-${var.environment}-${var.application}"
}
