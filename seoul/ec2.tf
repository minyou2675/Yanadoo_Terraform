resource "aws_key_pair" "terraform-key-pair" {
  # 등록할 key pair의 name
  key_name   = "tf-key-pair"
  
  # public_key = "{.pub 파일 내용}"
  public_key             = file("/home/ubuntu/.ssh/tf-key-pair.pub")
  
  tags = {
  	description = "terraform key pair import"
  }
}

resource "aws_instance" "ec2-1" {
  ami                    = "ami-081511b9e3af53902"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.terraform-key-pair.key_name
  subnet_id              = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  tags = {
    Name = "webserver"
  }

  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_instance" "ec2-2" {
  ami                    = "ami-081511b9e3af53902"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.terraform-key-pair.key_name
  subnet_id              = aws_subnet.public-subnet-2.id
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  tags = {
    Name = "webserver"
  }

  depends_on = ["aws_internet_gateway.igw"]
}





resource "aws_security_group" "sg" {
  name        = "sg"
  description = "allow 22, 80"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "sg_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
  description       = "ssh"
}


resource "aws_security_group_rule" "sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
  description       = "outbound"
}