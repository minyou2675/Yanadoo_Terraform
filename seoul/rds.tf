resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "${vars.name}"
  password             = "${vars.password}"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  aws_db_subnet_group = aws_db_subnet_group.default
}