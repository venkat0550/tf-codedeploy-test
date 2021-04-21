variable "container_cpu" {
  type    = number
  default = 128
}

variable "container_image" {
  type    = string
  default = "483519012114.dkr.ecr.us-east-1.amazonaws.com/testecrrepo:webserver_v1"
}

variable "container_name" {
  type    = string
  default = "nginx-basic"
}

variable "alb_name" {
  type    = string
  default = "webservice-alb"
}


variable "alb_name_prefix" {
  type    = string
  default = "prefix"
}

variable "vpc_id" {
  type    = string
  default = "vpc-6264ab1f"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-25cb7943", "subnet-cd3f7d80"]
}


variable "create_lb_tg" {
  description = "If set to true, create lb and tg"
  type        = bool
  default     = false
}

variable "cloudwatch_log_name" {
  type        = string
  default     = "td-demo-webservice"
  description = "Cloudwatch log group name"
}
