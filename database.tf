// Amazon RDS deployment 

resource "aws_db_instance" "database" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro" // instance type
  db_name              = "lamp"
  username             = "akshay" // username
  password             = "akshay12345" // password
  db_subnet_group_name = aws_db_subnet_group.databasegroup.name
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.dbsg.id] // Pulls the security group id from the database security group file
  skip_final_snapshot    = true
  identifier             = "lampdb"
  multi_az               = var.multi_az_db

  tags = {
    Name = "Database"
  }
}

// Create output once Database is created for access purposes
output "databaseurl" { 
  value = aws_db_instance.database.address
}