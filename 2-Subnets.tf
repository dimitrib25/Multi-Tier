#These are public

resource "aws_subnet" "public-eu-central-1a" { #Change to your subnet
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.18.1.0/24" #Change to your CIDR
  availability_zone       = "eu-central-1a"#Change to your AZ
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-central-1a" #Change to your AZ
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}

resource "aws_subnet" "public-eu-central-1b" { #Change to your subnet
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.18.5.0/24" #Change to your CIDR
  availability_zone       = "eu-central-1b" #Change to your AZ
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-central-1b" #Change to your AZ
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}


resource "aws_subnet" "public-eu-central-1c" { #Change to your AZ
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.18.7.0/24" #Change to your CIDR
  availability_zone       = "eu-central-1c" #Change to your AZ
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-central-1c" #Change to your AZ
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}

#These are private
resource "aws_subnet" "private-eu-central-1a" { #Change to your AZ
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.18.10.0/24" #Change to your CIDR
  availability_zone = "eu-central-1a" #Change to your AZ

  tags = {
    Name    = "private-eu-central-1a" #Change to your AZ
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}

resource "aws_subnet" "private-eu-central-1b" { #Change to your AZ
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.18.14.0/24" #Change to your CIDR
  availability_zone = "eu-central-1b" #Change to your AZ

  tags = {
    Name    = "private-eu-central-1b" #Change to your AZ
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}


resource "aws_subnet" "private-eu-central-1c" { #Change to your AZ
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.18.18.0/24" #Change to your CIDR
  availability_zone = "eu-central-1c" #Change to your AZ

  tags = {
    Name    = "private-eu-central-1c" #Change to your AZ
    Service = "application1"
    Owner   = "Thee_Architect"
    Planet  = "Nibiru"
  }
}
