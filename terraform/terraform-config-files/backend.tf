terraform {
  backend "s3" {
    bucket         = "itgenius-s3-bucket"
    key            = "terraform_statefile"
    region         = "us-east-1"
    dynamodb_table = "itgenius-dynamoDB"
  }
}

