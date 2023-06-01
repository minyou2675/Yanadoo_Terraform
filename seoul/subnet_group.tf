resource "aws_db_subnet_group" "default" {
  name       = "default"
  subnet_ids = [aws_subnet.private-subnet-1.id,aws_subnet.private-subnet-2.id]

  tags = {
    Name = "subnet-group-default"
  }
}