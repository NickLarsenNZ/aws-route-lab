resource "aws_internet_gateway" "a" {
  vpc_id = "${aws_vpc.a.id}"

  tags {
    Name = "lab-igw-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_internet_gateway" "b" {
  vpc_id = "${aws_vpc.b.id}"

  tags {
    Name = "lab-igw-b"
    Lab  = "aws-route-lab"
  }
}
