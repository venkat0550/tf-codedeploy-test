resource "aws_cloudwatch_log_group" "cw_this" {
  name = var.cw_log_group_name

#   tags = {
#     Environment = "demo"
#     Application = "webservice"
#   }
}