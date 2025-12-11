# -----------------------
# NAT Gateway
# -----------------------

resource "aws_eip" "nat" {
  for_each = {
    az1 = "AZ-1"
    az2 = "AZ-2"
  }

  domain = "vpc"

  tags = {
    Name = "NAT-EIP-${each.key}"
  }
}


resource "aws_nat_gateway" "nat" {
  for_each = {
    az1 = aws_subnet.tiered["Public-Web-AZ-1"].id
    az2 = aws_subnet.tiered["Public-Web-AZ-2"].id
  }

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value

  tags = {
    Name = "NAT-GW-${upper(each.key)}"
  }
}

