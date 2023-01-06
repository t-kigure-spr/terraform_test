# -------------------------------------------
# VPC
# -------------------------------------------
resource "aws_vpc" "kigure-vpc-test" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "kigure-vpc-test"
  }
}

# -------------------------------------------
# Subnet
# -------------------------------------------
resource "aws_subnet" "kigure-sb-pub-test" {
  vpc_id = aws_vpc.kigure-vpc-test.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.1.1.0/24"
  tags = {
    Name = "kigure-sb-pub-test"
  }
}

# -------------------------------------------
# Internet Gateway
# -------------------------------------------
resource "aws_internet_gateway" "kigure-igw-test" {
  vpc_id = aws_vpc.kigure-vpc-test.id
  tags = {
    Name = "kigure-igw-test"
  }
}

# -------------------------------------------
# Route Table
# -------------------------------------------
resource "aws_route_table" "kigure-rtb-pub-test" {
  vpc_id = aws_vpc.kigure-vpc-test.id
  tags = {
    Name = "kigure-rtb-pub-test"
  }
}

resource "aws_route_table_association" "kigure-rtb_asc-pub-test" {
  route_table_id = aws_route_table.kigure-rtb-pub-test.id
  subnet_id = aws_subnet.kigure-sb-pub-test.id
}

resource "aws_route" "dfgw" {
  route_table_id = aws_route_table.kigure-rtb-pub-test.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.kigure-igw-test.id
}
