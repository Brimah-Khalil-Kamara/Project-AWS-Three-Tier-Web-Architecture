//INTERNET GATEWAY RESOURCE

resource "aws_internet_gateway" "myapp_igw" {                       
    vpc_id = aws_vpc.architecture_vpc.id                                        
    tags = {                                                                                                          
      Name: "${var.env_prefix}-igw"                                  
    }
}
