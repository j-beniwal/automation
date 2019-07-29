output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "ec2_pub_ip" {
  value       = module.public_ec2.ec2_public_ip
}

output "ec2_pvt_ip" {
  value       = module.private_ec2.ec2_private_ip
}

output "pvt_rds_id" {
  value       = module.private_rds.rds_id
}

output "pvt_rds_endpoint" {
  value       = module.private_rds.rds_endpoint
}
