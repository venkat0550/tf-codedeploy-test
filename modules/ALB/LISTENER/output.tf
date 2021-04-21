output "aws_lb_listener_id" {
  value       = aws_lb_listener.listener_this.id

  description = "Listener Id"

}

output "aws_lb_listener_arn" {
  value       = aws_lb_listener.listener_this.arn

  description = "Listener ARN"

}

output "aws_lb_listener_rule_arn" {
  value       = aws_lb_listener_rule.lb_listener_rule_this.arn

  description = "Listener Rule ARN"

}

output "aws_lb_listener_rule_id" {
  value       = aws_lb_listener_rule.lb_listener_rule_this.id

  description = "Listener Rule id"

}




