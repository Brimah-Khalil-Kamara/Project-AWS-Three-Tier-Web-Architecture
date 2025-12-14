# -----------------------
# Public Route Table
# -----------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.architecture_vpc.id

  tags = {
    Name = "${var.env_prefix}-Public-Web-rt"
  }
}

resource "aws_route" "public_default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myapp_igw.id
}

resource "aws_route_table_association" "public_assoc" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

# -----------------------
# Private Route Tables
# -----------------------

resource "aws_route_table" "private_app" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.architecture_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    # NAT gateway selected purely by AZ
    nat_gateway_id = aws_nat_gateway.nat[each.value.az].id
  }

  tags = {
    Name = "${var.env_prefix}-Private-${each.key}-rt"
  }
}

resource "aws_route_table_association" "private_app_assoc" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_app[each.key].id
}
