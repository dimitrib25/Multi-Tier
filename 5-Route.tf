resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app1.id
  tags = {
    Name = "private"
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app1.id
  tags = {
    Name = "public"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "private-eu-central-1a" { #Change to your AZ
  subnet_id      = aws_subnet.private-eu-central-1a.id #Change to your AZ
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-eu-central-1b" { #Change to your AZ
  subnet_id      = aws_subnet.private-eu-central-1b.id #Change to your AZ
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-eu-central-1c" { #Change to your AZ
  subnet_id      = aws_subnet.private-eu-central-1c.id #Change to your AZ
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-eu-central-1a" { #Change to your AZ
  subnet_id      = aws_subnet.public-eu-central-1a.id #Change to your AZ
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-eu-central-1b" { #Change to your AZ
  subnet_id      = aws_subnet.public-eu-central-1b.id #Change to your AZ
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-eu-central-1c" { #Change to your AZ
  subnet_id      = aws_subnet.public-eu-central-1c.id #Change to your AZ
  route_table_id = aws_route_table.public.id
}
