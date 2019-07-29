# variables vpc

variable "dns_host" {
  default = "true"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


# variables subnet

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "vpc_id" { }

