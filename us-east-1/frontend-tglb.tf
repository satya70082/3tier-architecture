resource "aws_lb_target_group" "frontend_tg" {
  name     = "${local.project}-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  depends_on = [ aws_vpc.my_vpc ]
  
}
resource "aws_lb" "frontend_lb" {
  name = "${local.project}-frontend-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  tags = {
    Name = "${local.project}-frontend-lb"
  }
  depends_on = [ aws_lb_target_group.frontend_tg ]
}
resource "aws_lb_listener" "frontend_listner" {
  load_balancer_arn = aws_lb.frontend_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}
