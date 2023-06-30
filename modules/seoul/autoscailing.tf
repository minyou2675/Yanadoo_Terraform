resource "aws_placement_group" "apg" {
  name     = "apg"
  strategy = "cluster"
}



resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-asg-example-"
  image_id      = "ami-081511b9e3af53902"
  instance_type = "t3.micro"
  spot_price    = "0.001"

  lifecycle {
    create_before_destroy = true
  }
}//aws 인스턴스와 거의 동일한 매개변수 사용. ASG에서 각 EC2인스턴스를 어떻게 구성할 지 결정


resource "aws_autoscaling_group" "asg" {
  name                      = "terraform-test"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ALB"
  desired_capacity          = 1
  force_delete              = true
  placement_group           = aws_placement_group.apg.id
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]

  initial_lifecycle_hook {
    name                 = "lifecycle"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = jsonencode({
      foo = "bar"
    })

    notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  }

  tag {
    key                 = "as"
    value               = "ccl tf"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  }
}