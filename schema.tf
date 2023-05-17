resource "null_resource" "load_schema" {
  depends_on = [aws_docdb_cluster.docdb,aws_docdb_cluster_instance.cluster_instances]

  provisioner "local-exec" {
    command = <<EOF

curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
unzip mongodb.zip
cd mongodb-main
curl -L -O https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFilerds-combined-ca-bundle.pem --username ${local.DOCDB_USER}
 --password ${local.DOCDB_PASS} < catalogue.js

mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFilerds-combined-ca-bundle.pem --username ${local.DOCDB_USER}
--password ${local.DOCDB_PASS} < user.js
EOF
  }
}