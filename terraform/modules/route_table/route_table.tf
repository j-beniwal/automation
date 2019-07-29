# route table resource for internet gateway

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.default.id}"
  count  = var.igw_source ? 1 : 0

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${var.gateway_id}"
  }

  tags = {
    Name = "main"
    email = "jeevan.beniwal@quantiphi.com"
  }
}

# route table association

resource "aws_route_table_association" "a" {
  subnet_id      = "${var.subnet_id}"
  count          = var.igw_source ? length(var.subnet_id) : 0
  route_table_id = aws_route_table.r[0].id
}

# route table for the nat gateway

resource "aws_route_table" "nat_rt" {
  count  = var.igw_source ? 0 : 1
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.gateway_id
  }
}

# nat gateway route table association

resource "aws_route_table_association" "nat_rt" {
  count          = var.igw_source ? 0 : length(var.subnet_id)
  subnet_id      = var.subnet_id[count.index]
  route_table_id = aws_route_table.nat_rt[0].id
}

# outputs

output "igw_route_table_id" {
  value       = aws_route_table.r[0].id
}

output "nat_route_table_id" {
  value       = aws_route_table.nat_rt[0].id
}
