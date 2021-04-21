resource "aws_lb_target_group" "tg_this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  tags = {
    Name = var.target_group_name
  }

}