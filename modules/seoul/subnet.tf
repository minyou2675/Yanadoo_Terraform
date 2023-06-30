variable "public_subnet_cidr_blocks" {
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.11.0/24", "10.0.21.0/24"]
}

variable "availability_zones" {
  default = ["ap-northeast-2a", "ap-northeast-2b"]
}

# Create public and private subnets using count
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}