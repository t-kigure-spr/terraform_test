# -------------------------------
# security Group
# -------------------------------
# --DB security group
resource "aws_security_group" "kigure-sg-test" {
  name = "kigure-sg-test"
  description = "terraform test"
  vpc_id = aws_vpc.kigure-vpc-test.id
  tags = {
    Name    = "kigure-sg-test"
  }  
}

resource "aws_security_group_rule" "sg_rule_ssh" {
  security_group_id = aws_security_group.kigure-sg-test.id
  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "sg_rule_dfgw" {
  security_group_id = aws_security_group.kigure-sg-test.id
  type = "egress"
  protocol = "-1"
  from_port = 0
  to_port = 0
  cidr_blocks = [ "0.0.0.0/0" ]
}