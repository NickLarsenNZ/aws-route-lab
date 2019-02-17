data "external" "my_ip" {
  program = ["curl", "https://api.ipify.org?format=json"]
}

resource "aws_security_group" "a" {
  name        = "lab-sg-a"
  description = "Allow all outbound traffic, allow in from any private, and SSH in from my current public IP"
  vpc_id      = "${aws_vpc.a.id}"

  ingress {
    description = "Allow any from VPC subnets"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    description = "Allow SSH from my current public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.my_ip.result.ip}/32"]
  }

  egress {
    description     = "Allow any outbound"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "lab-sg-a"
    Lab = "aws-route-lab"
  }
}

resource "aws_security_group" "b" {
  name        = "lab-sg-b"
  description = "Allow all outbound traffic, allow in from any private, and SSH in from my current public IP"
  vpc_id      = "${aws_vpc.b.id}"

  ingress {
    description = "Allow any from VPC subnets"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    description = "Allow SSH from my current public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.my_ip.result.ip}/32"]
  }

  egress {
    description     = "Allow any outbound"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "lab-sg-b"
    Lab = "aws-route-lab"
  }
}
