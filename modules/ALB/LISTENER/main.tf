resource "aws_lb_listener" "listener_this" {
  load_balancer_arn = var.lb_arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      default_action
    ]
  }
}

resource "aws_lb_listener_rule" "lb_listener_rule_this" {
  listener_arn = aws_lb_listener.listener_this.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }

  condition {
    path_pattern {
      values = [var.listener_path]
    }
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      action
    ]
  }
}