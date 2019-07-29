# variable route table association

variable "subnet_id" {
  default = ""
}


# variables route table resource

variable "vpc_id" {}

variable "igw_source" {
  default = true
}

variable "gateway_id" {
  default = ""
}

