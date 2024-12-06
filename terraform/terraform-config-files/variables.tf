variable "region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  default     = "vpc-060d68cf8f4f0ff4b"
}

variable "subnet_ids" {
  description = "The list of subnet IDs to associate with resources"
  type        = list(string)
  default     = ["subnet-0305d0946c139cda7", "subnet-0413b34ddd5fbc136", "subnet-085dd956e5b639f40", "subnet-029b9641533fc3b1e"]
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
  default     = "subnet-0305d0946c139cda7"
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
