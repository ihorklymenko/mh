module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"
  name    = "${var.project}-${var.environment}-${var.application}"
  cidr    = var.vpc_cidr

  azs             = local.availability_zone_list
  private_subnets = local.private_subnet_cidr_list
  public_subnets  = local.public_subnet_cidr_list

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_dns_hostnames   = true
  enable_s3_endpoint     = true

  tags = local.tags
}
