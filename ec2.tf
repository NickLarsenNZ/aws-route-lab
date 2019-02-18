data "aws_ami" "amazon_linux" {
  most_recent      = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "a" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.a.id}"]
  subnet_id = "${aws_subnet.a.id}"

  # Do I need these?
  source_dest_check = false # might be required for the gateway to receive traffic that doesn't match its IP.
  associate_public_ip_address = true

  tags {
    Name = "lab-instance-a"
    Lab = "aws-route-lab"
  }
}

resource "aws_instance" "b" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.b.id}"]
  subnet_id = "${aws_subnet.b.id}"

  # Do I need these?
  source_dest_check = false # might be required for the gateway to receive traffic that doesn't match its IP.
  associate_public_ip_address = true

  tags {
    Name = "lab-instance-b"
    Lab = "aws-route-lab"
  }
}
