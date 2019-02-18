resource "aws_vpc" "a" {
  cidr_block = "192.168.0.0/17"

  tags {
    Name = "lab-vpc-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_vpc" "b" {
  cidr_block = "192.168.128.0/17"

  tags {
    Name = "lab-vpc-a"
    Lab  = "aws-route-lab"
  }
}
