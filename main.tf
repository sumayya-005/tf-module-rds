resource "aws_db_instance" "default" {
  for_each             = var.rds
  allocated_storage    = each.value.allocated_storage
  db_name              = "${var.env}-${each.key}-roboshop-rds"
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_calss
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = each.value.parameter_group_name
  skip_final_snapshot  = true
}