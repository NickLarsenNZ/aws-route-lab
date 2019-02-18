resource "aws_route_table" "a" {
  vpc_id = "${aws_vpc.a.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.a.id}"
  }

  route {
    cidr_block = "${var.subnets["b"]}"
    gateway_id = "${aws_ec2_transit_gateway.lab.id}"
  }

  route {
    cidr_block = "10.0.0.0/8"
    gateway_id = "${aws_ec2_transit_gateway.lab.id}"
  }

  tags {
    Name = "lab-rtb-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_route_table" "b" {
  vpc_id = "${aws_vpc.b.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.b.id}"
  }

  route {
    cidr_block = "10.0.0.0/8"
    network_interface_id  = "${aws_instance.b.network_interface_id}"
  }

  route {
    cidr_block = "${var.subnets["a"]}"
    gateway_id = "${aws_ec2_transit_gateway.lab.id}"
  }

  tags {
    Name = "lab-rtb-b"
    Lab  = "aws-route-lab"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.a.id}"
  route_table_id = "${aws_route_table.a.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.b.id}"
  route_table_id = "${aws_route_table.b.id}"
}
