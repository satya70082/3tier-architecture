resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
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
        Name = "${local.project}-bastion-sg"
    }
}
#alb frontend security group
resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    description = "Allow HTTP inbound traffic"
    depends_on = [ aws_vpc.my_vpc ]
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
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
        Name = "${local.project}-alb-sg"
    }
}
#frontend security group
resource "aws_security_group" "frontend_sg" {
  name = "frontend_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [ aws_vpc.my_vpc, aws_security_group.alb_sg ]
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
            from_port = 22
            to_port     = 22
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
            Name = "${local.project}-frontend-sg"
        }

}
#backend alb security group
resource "aws_security_group" "backend_alb_sg" {
    name = "backend_alb_sg"
    description = "Allow HTTP inbound traffic"
    depends_on = [ aws_vpc.my_vpc ]
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
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
        Name = "${local.project}-backend-alb-sg"
    }
}
#backend security group
resource "aws_security_group" "backend_sg" {
  name = "backend_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [ aws_vpc.my_vpc, aws_security_group.backend_alb_sg ]
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
            from_port = 22
            to_port     = 22
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
            Name = "${local.project}-backend-sg"
        }
  
}
#db security group
resource "aws_security_group" "db_sg" {
  name = "db_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [ aws_vpc.my_vpc ]
    ingress {
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
            Name = "${local.project}-db-sg"
        }
  
}