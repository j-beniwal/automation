# instance variables

variable "inst_ami"{
  default = "ami-026c8acd92718196b"
}

variable "inst_type" {
  default = "t2.micro"
}

variable "subnet_id" {}

variable "inst_count" {
  default = "1"
}

