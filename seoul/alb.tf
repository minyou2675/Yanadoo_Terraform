resource "aws_security_group" "alb_sg" {
  name        = "sg"
  description = "allow 22, 80"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "alb_sg_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
  description       = "ssh"
}


resource "aws_security_group_rule" "alb_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
  description       = "outbound"
}




resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2.id]

  enable_deletion_protection = true


  tags = {
    Environment = "production"
  }
}