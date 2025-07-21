resource "aws_lb" "vod_alb" {
  name               = "vod-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id]
  security_groups    = [aws_security_group.ecs_sg.id]
}

resource "aws_lb_target_group" "vod_tg" {
  name     = "vod-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_listener" "vod_listener" {
  load_balancer_arn = aws_lb.vod_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vod_tg.arn
  }
}