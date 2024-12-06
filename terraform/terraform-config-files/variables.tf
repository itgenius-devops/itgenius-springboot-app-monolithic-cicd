variable "region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  default     = "vpc-042e20b92a177e5bb"
}

variable "subnet_ids" {
  description = "The list of subnet IDs to associate with resources"
  type        = list(string)
  default     = ["subnet-038402fb5b115020c", "subnet-07a3d5bfa59b05d53", "subnet-0f8468f34ec3b6d6f", "subnet-0616d37dba1488ff8"]
}

variable "instance_ami" {
  description = "AMI ID for the instances"
  default     = "ami-0453ec754f44f9a4a"
}

variable "instance_key_name" {
  description = "An Existing Keypair to be used for the instances"
  default     = "ITG"
}

variable "instance_subnet_id" {
  description = "Public Subnet ID for the instances"
  default     = "subnet-038402fb5b115020c"
}

variable "instance_type" {
  description = "The Instance type"
  default     = "t2.micro"
}
variable "sonar_nexus_instance_type" {
  description = "The Instance type"
  default     = "t2.medium"
}

variable "db_name" {
  description = "The name of the database"
  default     = "itgeniusdb"
}

variable "db_username" {
  description = "Master username for the database"
  default     = "itgeniusmaster"
}

variable "db_password" {
  description = "Master password for the database"
  default     = "itgenius1234"
}

variable "db_instance_class" {
  description = "Instance class for the RDS database"
  default     = "db.t4g.micro"
}

variable "db_engine_version" {
  description = "MySQL Engine Version"
  default     = "8.0"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  default     = "itgenius-s3-bucket"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  default     = "itgenius-dynamoDB"
}
