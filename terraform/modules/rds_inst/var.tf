#db subnet group variables

variable "subnet_ids" {
  # default = ["${aws_subnet.frontend.id}", "${aws_subnet.backend.id}"]
}

# rds variables

variable "allocated_storage" {
  default = 20
}

variable "storage_type" {
  default = "gp2"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "parameter_group_name" {
 default = "default.mysql5.7"
}

variable "username" {
 default = "foo"
}

variable "password" {
  default = "foo123"
}

variable "vpc_sg_ids"{
}

