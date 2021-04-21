variable "target_group_name" {
  type        = string
  default     = ""
  description = "Taget Group Name"
}

variable "target_group_port" {
  type        = number
  default     = 80
  description = "Port number for the target group"
}


variable "target_type" {
  type        = string
  default     = ""
  description = "Please specify ip/instance "
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "Enter the VPC ID"
}

variable "target_group_protocol" {
  type        = string
  default     = "HTTP"
  description = "Specify the protocol HTTP/TCP/TLS/TCP_UDP/UDP"
}




