# This file installs our LAMP instances 

// Data Block to retrieve latest AMI Ubuntu Image
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

// Deploy EC2 Instance
resource "aws_instance" "lampsetup" {
  count                       = var.az_count //Deploy in 2 Availability Zones
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.websubnets[count.index % var.az_count].id //Deploy in 2 Subnets
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.websg.id]
  associate_public_ip_address = true


  root_block_device {
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
    volume_type           = "gp2"

    tags = {
      Name = "rootVolume"
    }
  }
  // Use the shell file called "ansibleInstall" as a bootstrap in the instance
  user_data = file("ansibleInstall.sh") 

  tags = {
    Name = "LampInstance"
  }
}
 