resource "aws_subnet" "a" {
  vpc_id     = "${aws_vpc.a.id}"
  cidr_block = "192.168.0.0/24"

  tags {
    Name = "lab-subnet-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_subnet" "b" {
  vpc_id     = "${aws_vpc.b.id}"
  cidr_block = "192.168.128.0/24"

  tags {
    Name = "lab-subnet-b"
    Lab  = "aws-route-lab"
  }
}
