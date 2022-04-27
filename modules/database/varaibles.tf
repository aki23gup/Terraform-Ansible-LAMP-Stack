
variable "default_tags" {
  type = map(any)
  default = {
    "company_name" : "AKSHIT INC"
    "business_unit" : "Cloud Computing"
    "support_email" : "akshit.vineet@xyz.com"
  }
}

variable "multi_az_db" {
  type    = bool
  default = true
}

variable "dbsgid" {
  description = "ID of the Database Security Group"
  type    = string
}
variable "db_name" {
  description = "Database Subnet Group Name"
  type    = string
}
