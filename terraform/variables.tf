variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.209.40.0/22"
}

variable "project" {
  type    = string
  default = "mh"
}

variable "application" {
  type    = string
  default = "hello-world"
}

variable "replicas_count" {
  type    = number
  default = 1
}
