# -------------------------------------------
# Network Interface
# -------------------------------------------
resource "aws_network_interface" "kigure-test-linux" {
  subnet_id = aws_subnet.kigure-sb-pub-test.id
  private_ips = ["10.1.1.100"]
  tags = {
    Name = "kigure-test-linux"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.kigure-sg-test.id
  network_interface_id = aws_instance.kigure-test-linux.primary_network_interface_id
}

# -------------------------------------------
# EC2 Instances
# -------------------------------------------
resource "aws_instance" "kigure-test-linux" {
  ami = "ami-0bba69335379e17f8"
  instance_type = "t3.micro"
  network_interface {
    network_interface_id = aws_network_interface.kigure-test-linux.id
    device_index = 0
  }
  key_name = "t-kigure"
  tags = {
    Name = "kigure-test-linux"
  }
}

resource "aws_eip" "kigure-test-linux" {
  vpc = true
  instance                  = aws_instance.kigure-test-linux.id
  depends_on                = [aws_internet_gateway.kigure-igw-test]
}