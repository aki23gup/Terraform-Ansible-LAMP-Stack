#The Region you want to deploy the infra
aws_region         = "us-east-1"

# Replace the VPC cidr from your account. Range of CIDR max(22)
vpc_cidr           = "10.0.0.0/16"

# Key pair name create in same region
key_name           = "lamp"

# personal laptop public ip for debugging and SSH purpose
personal_laptop_ip = "99.235.109.84"