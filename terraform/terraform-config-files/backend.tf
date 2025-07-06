terraform {
  backend "s3" {
    bucket         = "itgenius-app-statefile-s3-bucket"
    key            = "terraform_statefile"
    region         = "us-east-1"
    dynamodb_table = "itgenius-app-statefile-dynamoDB"
  }
}

