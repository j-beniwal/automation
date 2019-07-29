
provider "aws" {
  region = "us-east-1"
}

# module vpc 
module "my_vpc" {
  source = "../modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  dns_host = "true"
  vpc_id = "${module.my_vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"

}

# Make all 3 subnets
module "subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  az_id      = [var.public_subnet_az_id, var.private_subnet_1_az_id, var.private_subnet_2_az_id]
  cidr       = [var.public_subnet_cidr, var.private_subnet_1_cidr, var.private_subnet_2_cidr]
  map_pub_ip = [true, false, false]
}

# module gateway
module "gateways" {
  source        = "./modules/inter_net_gtw"
  vpc_id        = module.vpc.vpc_id            
  subnet_id     = module.subnet.subnet_id[0]   
  allocation_id = var.elastic_ip_allocation_id
}

# route table with internet gateway 
module "rt_1" {
  source     = "./modules/route_table"
  subnet_id  = [module.subnet.subnet_id[0]] 
  vpc_id     = module.vpc.vpc_id
  igw_id     = module.gateways.igw_id
}

# route table for NAT gateway
module "rt_2" {
  source     = "./modules/route_table"
  subnet_id  = [module.subnet.subnet_id[1], module.subnet.subnet_id[2]]
  vpc_id = module.vpc.vpc_id
  nat_id = module.gateways.nat_id
}

# module public ec2 instance security group
module "pub_ec2_sg" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  type         = var.pub_ec2_sg_type
  cidr_blocks  = var.pub_ec2_sg_cidr_blocks
  from_port    = var.pub_ec2_sg_from_port
  to_port      = var.pub_ec2_sg_to_port
  protocol     = var.pub_ec2_sg_protocol
  source_sg_id = [null, null, null, module.private_ec2_sg.sg_id]
}

# moduel private ec2 isntance security group
module "pvt_ec2_sg" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  type         = var.pvt_ec2_sg_type
  cidr_blocks  = var.pvt_ec2_sg_cidr_blocks
  from_port    = var.pvt_ec2_sg_from_port
  to_port      = var.pvt_ec2_sg_to_port
  protocol     = var.pvt_ec2_sg_protocol
  source_sg_id = [module.pub_ec2_sg.sg_id, null, null, module.pvt_rds_sg.sg_id]
}

# module private rds security group
module "pvt_rds_sg" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  type         = var.pvt_rds_sg_type
  cidr_blocks  = var.pvt_rds_sg_cidr_blocks
  from_port    = var.pvt_rds_sg_from_port
  to_port      = var.pvt_rds_sg_to_port
  protocol     = var.pvt_rds_sg_protocol
  source_sg_id = [module.pvt_ec2_sg.sg_id, null, null]
}

# module public EC2 instance
module "pub_ec2" {
  source    = "./modules/ec2"
  ami       = var.inst_ami
  key_name  = var.key_name
  sg_id     = module.pub_ec2_sg.sg_id
  subnet_id = module.subnet.subnet_id[0]
}

# module Private RDS instance
module "pvt_rds" {
  source      = "./modules/rds_inst"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  vpc_sg_ids        = [module.pvt_rds_sg.sg_id]
  subnet_group_name = var.db_subnet_group_name
  subnet_ids        = [module.subnet.subnet_id[1], module.subnet.subnet_id[2]]
}

# User data file
data "template_file" "user_data" {
  template = "${file("${path.module}/startup.tpl")}"
  vars = {
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    endpoint    = "${element(split(":", module.private_rds.rds_endpoint), 0)}"
  }
}

# module Private EC2 instance
module "private_ec2" {
  source    = "./modules/ec2"
  ami       = default
  key_name  = var.pvt_ec2_key_name
  sg_id     = module.pvt_ec2_sg.sg_id
  subnet_id = module.subnet.subnet_id[1]
  user_data = "${data.template_file.user_data.rendered}"
}
