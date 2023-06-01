
# public Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "public-subnet-1"
  }
}
# public Subnets
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-2b"

  tags = {
    Name = "public-subnet-2"
  }
}
# private Subnets
resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "private-subnet-1"
  }
}
# private Subnets
resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.21.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-northeast-2b"

  tags = {
    Name = "private-subnet-2"
  }
}