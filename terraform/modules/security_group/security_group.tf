# security group resource

resource "aws_security_group" "security_group" {
  name        = "security_group"
  vpc_id      = "${var.vpc_id}"
}

# security group rule

resource "aws_security_group_rule" "sg_assn" {
  count                    = length(var.type)
  security_group_id        = aws_security_group.security_group.id
  type                     = var.type[count.index]
  source_security_group_id = var.source_sg_id[count.index]
  cidr_blocks              = var.cidr_blocks[count.index]
  from_port                = var.from_port[count.index]
  to_port                  = var.to_port[count.index]
  protocol                 = var.protocol[count.index]
}

# outputs


output "sg_id" {
  value       = aws_security_group.security_group.id
}

output "sg_arn" {
  value       = aws_security_group.security:_group.arn
}
