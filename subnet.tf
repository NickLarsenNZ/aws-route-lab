variable "subnets" {
  type = "map"

  default = {
    a = "192.168.0.0/24"
    b = "192.168.128.0/24"
  }
}

resource "aws_subnet" "a" {
  vpc_id     = "${aws_vpc.a.id}"
  cidr_block = "${var.subnets["a"]}"

  tags {
    Name = "lab-subnet-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_subnet" "b" {
  vpc_id     = "${aws_vpc.b.id}"
  cidr_block = "${var.subnets["b"]}"

  tags {
    Name = "lab-subnet-b"
    Lab  = "aws-route-lab"
  }
}
