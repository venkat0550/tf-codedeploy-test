variable vpc_id {
  type        = string
  default     = ""
  description = "Enter the VPC ID on which SG needs to be created"
}

variable sg_name {
  type        = string
  default     = ""
  description = "Enter the SG Name"
}

variable sg_description {
  type        = string
  default     = ""
  description = "Enter the SG Description - Purpose of the SG"
}

# variable sg_tcp_port_ {
#   type        = string
#   default     = ""
#   description = "description"
# }

variable sg_tag_name {
  type        = string
  default     = ""
  description = "SG tag name"
}

variable "sg_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http"
    },
    {
      from_port   = 81
      to_port     = 81
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http"
    }
  ]
}



