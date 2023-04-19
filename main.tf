resource "aws_rds_cluster" "default" {
  cluster_identifier  = "${var.env}-${var.name}-roboshop-rds"
  engine              = var.engine
  engine_version      = var.engine_version
  database_name       = "mydb"
  master_username     = "foo"
  master_password     = "cjnsdfnjn"
  skip_final_snapshot = true
  db_cluster_parameter_group_name = "${var.env}-${var.name}-roboshop-rds"
  db_subnet_group_name = "${var.env}-${var.name}-roboshop-rds"
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${var.env}-${var.name}-roboshop-rds"
  family      = "aurora5.7"
  description = "RDS default cluster parameter group"

}

resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-${var.name}-roboshop-rds"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${var.name}-roboshop-rds"
  }
}