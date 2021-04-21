variable "lb_arn" {
  type        = string
  default     = ""
  description = "Loadbalancer ARN"
}

variable "listener_port" {
  type        = string
  default     = "80"
  description = "Listener Port"
}


variable "listener_protocol" {
  type        = string
  default     = "HTTP"
  description = "Please specify HTTPS / HTTP "
}


variable "listener_path" {
  type        = string
  default     = "/"
  description = "Please specify the path pattern"
}



variable "tg_arn" {
  type        = string
  default     = ""
  description = "Enter the target_group ARN"
}





