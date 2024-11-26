resource "aws_db_instance" "textract_db" {
  identifier = "textract-db"
  instance_class = "db.t3.micro"
  engine = "postgres"
  username = "admin"
  password = "password"
  db_name = "textract_db"
  allocated_storage = 20
  multi_az = false
  publicly_accessible = false
}

resource "aws_security_group" "db_sg" {
  name_prefix = "db-sg"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust based on your security needs
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "rds_instance" {
  db_subnet_group_name = aws_db_subnet_group.textract_db_subnet_group.name
  db_instance_class    = "db.t3.micro"
  engine               = "postgres"
  allocated_storage    = 20
  username             = "admin"
  password             = "adminpassword"
  db_name              = "textractdb"
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
