# EC2
resource "aws_instance" "tfimportec2" {
ami = var.ami[var.region]
#AMI is region-specific - confirm right region to avoid error
instance_type = var.instance_override == false ? var.instance_type : var.no_instance_type_change
key_name = "MyPrivateKey"
}
resource "aws_eip" "tfeip1" {
vpc = true
tags = {
  Name = "Tf-eip"
 }
}

# EIPs
resource "aws_eip_association" "eip_assoc1" {
instance_id   = aws_instance.tfimportec2.id
allocation_id = aws_eip.tfeip1.id
}

# RDS
resource "aws_db_instance" "tfdatabase" {
engine         = "mysql"
engine_version = "8.0.20"
instance_class = "db.t2.micro"
name           = "tf-import-mysql"
allocated_storage = 20
availability_zone = "us-east-1f"
skip_final_snapshot = true
backup_retention_period = 0
apply_immediately = true
username = var.username
}
