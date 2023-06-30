resource "aws_db_subnet_group" "db_subnet" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet[0].id,aws_subnet.private_subnet[1].id]

  tags = {
    Name = "subnet-group-db_subnet"
  }
}