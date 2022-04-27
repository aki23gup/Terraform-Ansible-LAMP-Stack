output "lampserverid" {
  description = "Lamp Server Instance ID"
  value = aws_instance.lampsetup[count.index].id
}