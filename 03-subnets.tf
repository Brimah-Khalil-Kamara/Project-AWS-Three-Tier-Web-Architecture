//SUBNET RESOURCE


/*
resource "aws_subnet" "Public-Web-Subnet-AZ-1"{                
    vpc_id = aws_vpc.architecture_vpc.id                      
    cidr_block = var.subnet_cidr_block                
    availability_zone = var.availability_zones                 
    tags = {                                           
    Name: "${var.env_prefix}-subnet-1"                
    }
}
*/

resource "aws_subnet" "tiered" {
  for_each = { for idx, subnet in local.all_subnets : "${subnet.name}-AZ-${subnet.az_index + 1}" => subnet }

  vpc_id                  = aws_vpc.architecture_vpc.id
  availability_zone       = var.availability_zones[each.value.az_index]
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.map_public

  tags = {
    Name = "${var.env_prefix}-${each.value.name}-Subnet-AZ-${each.value.az_index + 1}"

  }
}
