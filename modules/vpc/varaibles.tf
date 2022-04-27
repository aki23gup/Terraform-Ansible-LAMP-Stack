
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "az_count" {
  type    = number
  default = 2
}

variable "default_tags" {
  type = map(any)
  default = {
    "company_name" : "AKSHIT INC"
    "business_unit" : "Cloud Computing"
    "support_email" : "akshit.vineet@xyz.com"
  }
}





