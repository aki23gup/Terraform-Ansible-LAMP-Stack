
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

variable "vpc_id" {
  description = "VPC ID"
  type    = string
}

variable "lbsgid" {
  description = "Load Balancer Security Group ID"
  type    = string
}

variable "websubidlb" {
  description = "Web Server Subnets ID"
  type    = string
}

variable "lampserverid" {
  description = "Lamp Server Instance ID"
  type    = string
}