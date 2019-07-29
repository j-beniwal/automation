#========== internet gateway ===============

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "terra-igtw"
    email = "jeevan.beniwal@quantiphi.com"
  }
}

#============== nat gateway =================

resource "aws_nat_gateway" "gw" {
  allocation_id = "${var.allocation_eip_id}"
  subnet_id     = "${var.subnet_id}"

  tags = {
    Name = "NAT gw"
    email = "jeevan.beniwal@quantiphi.com"
  }
}

#======== internet gateway outputs ============

output "internet_gw_id" {
    value = "${aws_internet_gateway.id}"
}

#=========== nat gateway outputs ============

output "nat_id" {
    value = "${aws_nat_gateway.id}"

output "allocation_id" {
    value = "${aws_nat_gateway.allocation_id}"
}

output "net_interface_id" {
    value = "${aws_nat_gateway.network_interface_id}"
}

output "nat_privatie_ip" {
    value = "${aws_nat_gateway.private_ip}"
}

output "nat_public_ip" {
    value = "${aws_nat_gateway.public_ip}"
}

