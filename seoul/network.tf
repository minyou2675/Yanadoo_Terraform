# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id #어느 VPC와 연결할 것인지 지정
    tags = { Name = "igw"}  #태그 설정
}


# NAT 게이트웨이가 사용할 Elastic IP생성
resource "aws_eip" "nat-1" {
  vpc      = true  #생성 범위 지정
}

resource "aws_eip" "nat-2" {
  vpc      = true  #생성 범위 지정
}


# NAT 게이트웨이 생성
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.nat-1.id #EIP 연결
  subnet_id     = aws_subnet.public-subnet-1.id #NAT가 사용될 서브넷 지정

  tags = {
    Name = "terra-NAT"
  }
}
# NAT 게이트웨이 생성
resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.nat-2.id #EIP 연결
  subnet_id     = aws_subnet.public-subnet-2.id #NAT가 사용될 서브넷 지정

  tags = {
    Name = "terra-NAT"
  }
}