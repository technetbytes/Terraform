#### RDS ####
resource "aws_db_subnet_group" "three-tier-db-sub-grp" {
  name       = "three-tier-db-sub-grp"
  subnet_ids = ["${aws_subnet.three-tier-pvt-sub-3.id}","${aws_subnet.three-tier-pvt-sub-4.id}"]
}



resource "aws_db_instance" "three-tier-db" {
  allocated_storage           = 100
  storage_type                = "gp3"
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = "db.t2.micro"
  identifier                  = "three-tier-db"
  username                    = "admin"
  password                    = "23vS5TdDW8*o"
  parameter_group_name        = "default.mysql8.0"
  db_subnet_group_name        = aws_db_subnet_group.three-tier-db-sub-grp.name
  vpc_security_group_ids      = ["${aws_security_group.three-tier-db-sg.id}"]
  multi_az                    = true
  skip_final_snapshot         = true
  publicly_accessible          = false

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}