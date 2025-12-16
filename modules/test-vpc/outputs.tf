# modules/test-vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.this.id   # assuming your VPC resource inside module is called "this"
}


output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_subnet_names" {
  value = [for s in aws_subnet.public : s.tags["Name"]]
}

output "private_subnet_names" {
  value = [for s in aws_subnet.private : s.tags["Name"]]
}

output "all_subnets" {
  value = {
    public  = { for k, s in aws_subnet.public : k => { id = s.id, name = s.tags["Name"] } }
    private = { for k, s in aws_subnet.private : k => { id = s.id, name = s.tags["Name"] } }
  }
}
