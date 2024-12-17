resource "aws_lb_target_group" "backend_tg" {
  name = "${local.project}-backend-tg"
  port = 80
  protocol = "HTTP"
    vpc_id = aws_vpc.my_vpc.id
    depends_on = [ aws_vpc.my_vpc ]
}
resource "aws_lb" "backend_lb" {
  name = "${local.project}-backend-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.backend_alb_sg.id]
    subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
    tags = {
      Name = "${local.project}-backend-lb"
    }
    depends_on = [ aws_lb_target_group.backend_tg ]
}