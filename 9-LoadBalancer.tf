resource "aws_lb" "app1_alb" {
  name               = "app1-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app1-443-sg02-LB01.id]
  subnets            = [
    aws_subnet.public-eu-central-1a.id, #Choose your AZ's
    aws_subnet.public-eu-central-1b.id,
    aws_subnet.public-eu-central-1c.id
  ]
  enable_deletion_protection = false #Deletion protection is usu. set to true for security. 
                                    #However I have disabled it as it makes the tear down process easier

  tags = {
    Name    = "App1LoadBalancer"
    Service = "App1"
    Owner   = "Thee_Architect"
    Project = "Web Service"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app1_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }
}

data "aws_acm_certificate" "cert" {
  domain   = "go-2-cloud.net" #Insert your domain here
  statuses = ["ISSUED"]
  most_recent = true
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app1_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"  # policy
  certificate_arn   = data.aws_acm_certificate.cert.arn



  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }
}
