resource "aws_security_group" "app1-80-sg01-servers" {
  name        = "app1-80-sg01-servers"
  description = "app1-80-sg01-servers"
  vpc_id      = aws_vpc.app1.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Outchere"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    description = "RDS"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-80-sg01-servers"
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
    Author  = "ArchAndrew"
  }

}



resource "aws_security_group" "app1-443-sg02-LB01" {
  name        = "app1-443-sg02-LB01"
  description = "app1-443-sg02-LB01"
  vpc_id      = aws_vpc.app1.id

  ingress {
    description = "MyHomePage"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-443-sg02-LB01"
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }

}
