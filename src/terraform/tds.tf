provider aws {
    profile="default"
    region= "eu-west-1"
}

resource "aws_db_instance" "complexk8s" {
  allocated_storage    = 100
#   db_subnet_group_name = "db-subnetgrp"
  engine               = "postgres"
  engine_version       = "11.5"
  identifier           = "complexk8s"
  instance_class       = "db.t3.micro"
  password             = "password"
  skip_final_snapshot  = true
  storage_encrypted    = true
  username             = "postgres"
}