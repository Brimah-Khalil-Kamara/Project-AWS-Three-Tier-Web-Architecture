output "vpc_id" {
  value = aws_vpc.architecture_vpc.id
}

/*
output "subnet_ids" {
  value = [for s in values(aws_subnet.tiered) : s.id]
}

output "subnet_names" {
  value = [for s in values(aws_subnet.tiered) : s.tags["Name"]]
}

*/

#################################################
# outputs.tf
# Terraform outputs for subnet IDs and Names
#################################################

# --------------------------
# Public Subnets
# --------------------------
output "public_subnet_ids" {
  description = "IDs of all public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "public_subnet_names" {
  description = "Names of all public subnets"
  value       = [for s in aws_subnet.public : s.tags["Name"]]
}

# --------------------------
# Private Subnets
# --------------------------
output "private_subnet_ids" {
  description = "IDs of all private subnets (app + db tiers)"
  value       = [for s in aws_subnet.private : s.id]
}

output "private_subnet_names" {
  description = "Names of all private subnets (app + db tiers)"
  value       = [for s in aws_subnet.private : s.tags["Name"]]
}

# --------------------------
# Combined map of all subnets
# --------------------------
output "all_subnets" {
  description = "All subnets with their IDs and Names"
  value = {
    public  = { for k, s in aws_subnet.public : k => { id = s.id, name = s.tags["Name"] } }
    private = { for k, s in aws_subnet.private : k => { id = s.id, name = s.tags["Name"] } }
  }
}
