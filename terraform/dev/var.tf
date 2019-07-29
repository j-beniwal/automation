# For VPC
variable "pub_subnet_az_id" {
  type        = "string"
}

variable "pub_subnet_cidr" {
  type        = "string"
}

variable "pvt_subnet_1_az_id" {
  type        = "string"
}
variable "pvt_subnet_1_cidr" {
  type        = "string"
}

variable "pvt_subnet_2_az_id" {
  type        = "string"
}
variable "pvt_subnet_2_cidr" {
  type        = "string"
}

variable "elastic_ip_allocation_id" {
  type        = "string"
}

variable "public_ec2_sg_description" {
  type        = "string"
}
variable "public_ec2_sg_type" {
  type        = list(string)
}
variable "public_ec2_sg_cidr_blocks" {
  type        = list(list(string))
}
variable "public_ec2_sg_from_port" {
  type        = list(number)
}
variable "public_ec2_sg_to_port" {
  type        = list(number)
}
variable "public_ec2_sg_protocol" {
  type        = list(string)
}

variable "private_ec2_sg_description" {
  type        = "string"
}
variable "private_ec2_sg_type" {
  type        = list(string)
}
variable "private_ec2_sg_cidr_blocks" {
  type        = list(list(string))
}
variable "private_ec2_sg_from_port" {
  type        = list(number)
}
variable "private_ec2_sg_to_port" {
  type        = list(number)
}
variable "private_ec2_sg_protocol" {
  type        = list(string)
}

# For private RDS security group
variable "private_rds_sg_description" {
  type        = "string"
}
variable "private_rds_sg_type" {
  type        = list(string)
}
variable "private_rds_sg_cidr_blocks" {
  type        = list(list(string))
}
variable "private_rds_sg_from_port" {
  type        = list(number)
}
variable "private_rds_sg_to_port" {
  type        = list(number)
}
variable "private_rds_sg_protocol" {
  type        = list(string)
}

variable "public_ec2_key_name" {
  type        = string
}
variable "public_ec2_ami_id" {
  type        = string
}

variable "db_name" {
  type        = string
}
variable "db_username" {
  type        = string
}
variable "db_subnet_group_name" {
  type        = string
}
variable "db_password" {
  type        = string
}

variable "private_ec2_key_name" {
  type        = string
}
variable "private_ec2_ami_id" {
  type        = string
}
