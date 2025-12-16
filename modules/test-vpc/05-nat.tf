# -----------------------
# NAT Gateway
# -----------------------

# Create Elastic IPs for NAT Gateways (one per AZ)
resource "aws_eip" "nat" {
  for_each = { for k, s in var.public_subnets : s.az => k }

  domain = "vpc"

  tags = {
    Name = "NAT-EIP-${each.key}"
  }
}

# Create NAT Gateway in each public subnet (one per AZ)
resource "aws_nat_gateway" "nat" {
  for_each = { for k, s in var.public_subnets : s.az => k }

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.value].id

  tags = {
    Name = "NAT-GW-${each.key}"
  }
}
