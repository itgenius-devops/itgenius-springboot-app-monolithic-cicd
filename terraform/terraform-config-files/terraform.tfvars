region                  = "us-east-1"
vpc_id                  = "vpc-0eeb9af51dcf5660a"

subnet_ids = [
  "subnet-09e6e1eb0955bd8c4",
  "subnet-06b80d535f6fadd49",
  "subnet-09ae938733d8db793"
]

instance_ami            = "ami-05ffe3c48a9991133"
db_secret_name          = "itgenius-db-secret"
instance_key_name       = "new-server"
instance_subnet_id      = "subnet-09e6e1eb0955bd8c4"
instance_type           = "t2.micro"
sonar_nexus_instance_type = "t2.medium"
db_name                 = "itgeniusdb"
db_instance_class       = "db.t3.micro"
db_engine_version       = "8.0"
s3_bucket_name          = "itgenius-app-statefile-s3-bucket"
