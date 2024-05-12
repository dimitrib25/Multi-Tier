#This makes vpc.id which is aws_vpc.app1.id
resource "aws_vpc" "app1" {
  cidr_block = "10.18.0.0/16" #Choose corresponding CIDR

  tags = {
    Name = "app1"
    Service = "application1"
    Owner = "Thee_Architect"
    Planet = "Nibiru"
  }
}
