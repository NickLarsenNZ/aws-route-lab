data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "tls_private_key" "lab" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_file" "key" {
  content  = "${tls_private_key.lab.private_key_pem}"
  filename = "${path.module}/instance.pem"
}

resource "aws_key_pair" "lab" {
  key_name   = "aws-route-lab"
  public_key = "${tls_private_key.lab.public_key_openssh}"
}

resource "aws_instance" "a" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.a.id}"]
  subnet_id              = "${aws_subnet.a.id}"
  key_name               = "${aws_key_pair.lab.key_name}"

  # Do I need these?
  source_dest_check           = false # might be required for the gateway to receive traffic that doesn't match its IP.
  associate_public_ip_address = true

  tags {
    Name = "lab-instance-a"
    Lab  = "aws-route-lab"
  }
}

resource "aws_instance" "b" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.b.id}"]
  subnet_id              = "${aws_subnet.b.id}"
  key_name               = "${aws_key_pair.lab.key_name}"

  #network_interface {
  #
  #}

  # Do I need these?
  source_dest_check           = false # might be required for the gateway to receive traffic that doesn't match its IP.
  associate_public_ip_address = true

  tags {
    Name = "lab-instance-b"
    Lab  = "aws-route-lab"
  }
}
