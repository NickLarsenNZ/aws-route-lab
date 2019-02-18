# aws-route-lab

## Purpose
To test inter-VPC routing via Transit Gateway, validating a third party router/firewall in a VPC that is accessible from another without the need for a Transit VPC.

## Resources
- 2x [`aws_vpc`](https://www.terraform.io/docs/providers/aws/r/vpc.html) - For testing routing across the Transit Gateway
- 2x [`aws_internet_gateway`](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html) - To give internet access to and from the EC2 instances
- 2x [`aws_eip`](https://www.terraform.io/docs/providers/aws/r/eip.html) - Public IPs for SSH
- 2x [`aws_subnet`](https://www.terraform.io/docs/providers/aws/r/subnet.html) - One public subnet per VPC for the EC2 instances and VPC attachments
- 2x [`aws_security_group`](https://www.terraform.io/docs/providers/aws/r/security_group.html) - Allow SSH in from my IP, and anything out to the internet or other VPCs, and allow any traffic between the subnets.
- 1x [`tls_private_key`](https://www.terraform.io/docs/providers/tls/r/private_key.html) - To generate a key pair for the EC2 instances
- 1x [`local_file`](https://www.terraform.io/docs/providers/local/r/file.html) - For saving the generated SSH private key
- 2x [`aws_instance`](https://www.terraform.io/docs/providers/aws/r/instance.html) - EC2 instances for generating traffic and capturing.
- 2x [`aws_route_table`](https://www.terraform.io/docs/providers/aws/r/route_table.html) - To direct traffic out the IGW, or over the TGW
- 2x [`aws_route_table_association`](https://www.terraform.io/docs/providers/aws/r/route_table_association.html) - Bind the subnets to predefined route tables
- 1x [`aws_ec2_transit_gateway`](https://www.terraform.io/docs/providers/aws/r/ec2_transit_gateway.html) - For transit between VPCs
- 2x [`aws_ec2_transit_gateway_vpc_attachment`](https://www.terraform.io/docs/providers/aws/r/ec2_transit_gateway_vpc_attachment.html) - To bind the TGW with the VPCs
- 1x [`aws_ec2_transit_gateway_route_table`](https://www.terraform.io/docs/providers/aws/r/ec2_transit_gateway_route_table.html) - To direct traffic between the VPCs

## Test
Assuming correct routes between each VPC via the Transit Gateway:
- Ping from one host to the other, and see the traffic using TCPdump
- Ping some other address (subnet outside of VPC ranges, that are added to the routing table), and ping to that, and seeing the traffic reach the other EC2 instance (pretending to be the gateway for that subnet)

## SSH
- `ssh -i instance.pem ec2-user@$(terraform output instance_a_ip)`
- `ssh -i instance.pem ec2-user@$(terraform output instance_b_ip)`
