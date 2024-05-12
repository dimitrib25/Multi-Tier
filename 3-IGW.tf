resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app1.id #vpc i.d. must match name from vpc.tf

  tags = {
    Name    = "app1_IG"
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}
