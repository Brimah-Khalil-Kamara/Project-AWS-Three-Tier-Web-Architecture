# -----------------------
# Route
# -----------------------



# -----------------------
# Route Public
# -----------------------

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.architecture_vpc.id

  tags = {
    Name = "${var.env_prefix}-PublicRouteTable"
  }
}

# Default route to the existing Internet Gateway
resource "aws_route" "public_default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myapp-igw.id
}

# Associate both Public-Web subnets with the PublicRouteTable
resource "aws_route_table_association" "public_assoc" {
  for_each = {
    az1 = aws_subnet.tiered["Public-Web-AZ-1"].id
    az2 = aws_subnet.tiered["Public-Web-AZ-2"].id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}


# -----------------------
# Route Private
# -----------------------


# Private App Route Tables
resource "aws_route_table" "private_app" {
  for_each = {
    az1 = {
      subnet_id = aws_subnet.tiered["Private-App-AZ-1"].id
      nat_id    = aws_nat_gateway.nat["az1"].id
      name      = "Private-App-RT-AZ1"
    }
    az2 = {
      subnet_id = aws_subnet.tiered["Private-App-AZ-2"].id
      nat_id    = aws_nat_gateway.nat["az2"].id
      name      = "Private-App-RT-AZ2"
    }
  }

  vpc_id = aws_vpc.architecture_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.nat_id
  }

  tags = {
    Name = each.value.name
  }
}


resource "aws_route_table_association" "private_app_assoc" {
  for_each = aws_route_table.private_app

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.id
}
