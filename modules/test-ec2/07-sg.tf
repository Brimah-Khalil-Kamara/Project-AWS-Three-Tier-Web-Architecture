# -----------------------
# SECURITY GROUP
# -----------------------



///////////////////////////////////////////////////////////////////////////

# ---------------------------------------------
# INTERNET FACING LOAD BALANCER SECURITY GROUP
# ---------------------------------------------

resource "aws_security_group" "internet_facing_lb" {
  name        = "internet-facing-lb-sg"
  description = "External load balancer security group"
  vpc_id      = var.vpc_id   # <-- use the input variable, not the module resource

  # Inbound rules
  ingress {
    description      = "Allow HTTP from my IP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.my_public_ip] 
  }

  # Outbound rules (allow all by default)
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "internet-facing-lb-sg"
  }
}
///////////////////////////////////////////////////////////////////////////

# -----------------------
# WEB TIER SECURITY GROUP
# -----------------------
resource "aws_security_group" "web_tier" {
  name        = "WebTierSG"
  description = "SG for the Web Tier"
  vpc_id      = var.vpc_id

  # Allow HTTP from the internet-facing load balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.internet_facing_lb.id]
    description     = "Allow HTTP from the internet-facing LB"
  }

  # Allow HTTP from your IP (for testing)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]  # e.g., "203.0.113.25/32"
    description = "Allow HTTP from my IP for testing"
  }

  # Outbound traffic (allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebTierSG"
  }
}
//////////////////////////////////////////////////////////////////////

# -------------------------------------
# INTERNAL LOAD BALANCER SECURITY GROUP
# -------------------------------------

resource "aws_security_group" "internal_lb" {
  name        = "Internal-lb-sg"
  description = "SG for the internal load balancer"
  vpc_id      = var.vpc_id   # <-- use the input variable, not the module resource

  # Allow HTTP from the Web Tier SG
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
    description     = "Allow HTTP from Web Tier instances"
  }

  # Outbound traffic (allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Internal-lb-sg"
  }
}
///////////////////////////////////////////////////////////////////////////

# -------------------------------
# PRIVATE INSTANCE SECURITY GROUP
# -------------------------------

resource "aws_security_group" "private_app" {
  name        = "PrivateInstanceSG"
  description = "SG for our private app tier sg"
  vpc_id      = var.vpc_id

  # Allow TCP 4000 from Internal LB
  ingress {
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_lb.id]
    description     = "Allow app traffic from Internal LB"
  }

  # Allow TCP 4000 from your IP for testing
  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]  
    description = "Allow app traffic from my IP for testing"
  }

  # Outbound traffic (allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PrivateInstanceSG"
  }
}
//////////////////////////////////////////////////////////////////////////

# ------------------------
# DATABASE SECURITY GROUP
# ------------------------

resource "aws_security_group" "db" {
  name        = "DBSG"
  description = "SG for our databases"
  vpc_id      = var.vpc_id   # <-- use the input variable, not the module resource


  # Allow MySQL/Aurora (3306) from Private App tier SG
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_app.id]
    description     = "Allow MySQL traffic from Private App tier instances"
  }

  # Outbound traffic (allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DBSG"
  }
}
