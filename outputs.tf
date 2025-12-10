output "vpc_id" {
  value = aws_vpc.architecture_vpc.id
}

output "subnet_ids" {
  value = [for s in values(aws_subnet.tiered) : s.id]
}

output "subnet_names" {
  value = [for s in values(aws_subnet.tiered) : s.tags["Name"]]
}
