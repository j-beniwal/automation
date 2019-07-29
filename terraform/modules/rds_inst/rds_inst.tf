# rds instance 

resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = "mydb"
  username             = var.username
  password             = var.pasword
  parameter_group_name = var.parameter_group_name
  vpc_security_group_ids = var.vpc_sg_ids
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

# db subnet group

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
    email = "jeevan.beniwal@quantiphi.com"
  }
}

#outputs


output "rds_id" {
  value       = aws_db_instance.default.id
}

output "rds_arn" {
  value       = aws_db_instance.default.arn
}

output "rds_endpoint" {
  value       = aws_db_instance.default.endpoint
}
