# vpc

resource "aws_vpc" "main" {
  enable_dns_hostnames = "${var.dns_host}"
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "terraform-aws-vpc"
    email = "jeevan.beniwal@quantiphi.com"
  }
}

# subnet

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "Main "
		email = "jeevan.beniwal@quantiphi.com"
  }
}

output "vpc_id" {
	value = "${aws_vpc.main.id}"
}

output "subnet_id" {
	value = "${aws_subnet.main.id}"
}

