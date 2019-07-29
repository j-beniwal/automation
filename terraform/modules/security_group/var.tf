
variable "vpc_id" {
}

variable "type" {
  type        = list(string)
}

variable "source_sg_id" {
  type        = list(string)
}

variable "cidr_blocks" {
  type        = list(list(string))
}

variable "from_port" {
  type        = list(number)
}

variable "to_port" {
  type        = list(number)
}

variable "protocol" {
  type        = list(string)
}
