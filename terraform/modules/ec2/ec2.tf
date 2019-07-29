# ec2 instance

resource "aws_instance" "web" {
	count					=	"${var.inst_count}"
  ami           = "${var.inst_ami}"
  instance_type = "${var.inst_type}"
	subnet_id			=	"${var.subnet_id}"
	# file("${path.module}/hello.txt")

  tags = {
    Name = "j-terra-instance"
		email = "jeevan.beniwal@quaantiphi.com"
  }
}

