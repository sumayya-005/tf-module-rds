

resource "aws_rds_cluster" "default" {
  for_each            = var.rds
  cluster_identifier  = "${var.env}-${each.}-roboshop-rds"
  engine              = each.value.engine
  engine_version      = each.value.engine_version
  database_name       = "mydb"
  master_username     = "foo"
  master_password     = "cjnsdfnjn"
  skip_final_snapshot = true
  db_cluster_parameter_group_name = "${var.env}-${each.key}-roboshop-rds"
  db_subnet_group_name = "${var.env}-${each.key}-roboshop-rds"
}

resource "aws_rds_cluster_parameter_group" "default" {
  for_each = var.rds
  name        = "${var.env}-${each.key}-roboshop-rds"
  family      = "aurora5.7"
  description = "RDS default cluster parameter group"

}

resource "aws_db_subnet_group" "default" {
  for_each   = var.rds
  name       = "${var.env}-${each.key}-roboshop-rds"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${each.key}-roboshop-rds"
  }
}