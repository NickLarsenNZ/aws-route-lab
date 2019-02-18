resource "aws_eip" "a" {
  instance = "${aws_instance.a.id}"
  vpc      = true

  tags {
    Name = "lab-eip-a"
    Lab = "aws-route-lab"
  }
}

resource "aws_eip" "b" {
  instance = "${aws_instance.b.id}"
  vpc      = true

  tags {
    Name = "lab-eip-b"
    Lab = "aws-route-lab"
  }
}

output "instance_a_ip" {
  value = "${aws_eip.a.public_ip}"
}

output "instance_b_ip" {
  value = "${aws_eip.b.public_ip}"
}
