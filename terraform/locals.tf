locals {
  availability_zone_list   = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  public_subnet_cidr_list  = [cidrsubnet(var.vpc_cidr, 3, 0), cidrsubnet(var.vpc_cidr, 3, 1), cidrsubnet(var.vpc_cidr, 3, 2)]
  private_subnet_cidr_list = [cidrsubnet(var.vpc_cidr, 3, 3), cidrsubnet(var.vpc_cidr, 3, 4), cidrsubnet(var.vpc_cidr, 3, 5)]

  tags = {
    application = var.application
    project     = var.project
    environment = var.environment
    terraform   = "True"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
