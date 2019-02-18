resource "aws_ec2_transit_gateway" "lab" {
  description                     = "Transit Gateway between Lab VPC A and B"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags {
    Name = "lab-tgw"
    Lab  = "aws-route-lab"
  }
}

resource "aws_ec2_transit_gateway_route_table" "lab" {
  transit_gateway_id = "${aws_ec2_transit_gateway.lab.id}"

  tags {
    Name = "lab-tgw-rtb"
    Lab  = "aws-route-lab"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "a" {
  subnet_ids                                      = ["${aws_subnet.a.id}"]
  transit_gateway_id                              = "${aws_ec2_transit_gateway.lab.id}"
  vpc_id                                          = "${aws_vpc.a.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags {
    Name = "lab-tgw-attach-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "b" {
  subnet_ids                                      = ["${aws_subnet.b.id}"]
  transit_gateway_id                              = "${aws_ec2_transit_gateway.lab.id}"
  vpc_id                                          = "${aws_vpc.b.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags {
    Name = "lab-tgw-attach-b"
    Lab  = "aws-route-lab"
  }
}

resource "aws_ec2_transit_gateway_route" "to-vpc-a" {
  destination_cidr_block         = "${var.subnets["a"]}"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.a.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.lab.id}"
}

resource "aws_ec2_transit_gateway_route" "to-vpc-b" {
  destination_cidr_block         = "${var.subnets["b"]}"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.b.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.lab.id}"
}

resource "aws_ec2_transit_gateway_route" "to-vpc-b-inside" {
  destination_cidr_block         = "192.168.129.0/24"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.b.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.lab.id}"
}

resource "aws_ec2_transit_gateway_route" "to-vpc-b-outside" {
  destination_cidr_block         = "10.0.0.0/8"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.b.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.lab.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "a" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.a.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.lab.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "b" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.b.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.lab.id}"
}
