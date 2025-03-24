output "vpc_id" {
  value = aws_vpc.VPC_AT.id
}

output "subnet_ids" {
  value = [
    aws_subnet.public_subnet_AT.id,
    aws_subnet.private_subnet_AT.id
  ]
}