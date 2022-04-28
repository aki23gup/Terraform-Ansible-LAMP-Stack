//Variables file

variable "aws_region" { //Region to deploy resources in
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" { // CIDR Block for VPC
  type = string
}

variable "az_count" { // Number of Availability Zones
  type    = number
  default = 2
}

variable "instance_type" { //Instance type for EC2
  type    = string
  default = "t2.micro"
}

variable "key_name" { //Key Name for Private .PEM File
  type    = string
  default = "lamp"
}

variable "root_volume_size" { //Root volume size for Instance
  type    = string
  default = "30"
}

variable "multi_az_db" { // Make deployments in multiple availability zones
  type    = bool
  default = true
}

variable "personal_laptop_ip" { //Personal IP for Security Groups and SSH
  type = string
  default = "99.235.109.84"
}


