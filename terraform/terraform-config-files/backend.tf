terraform {
  backend "s3" {
    bucket         = "itgenius-app-statefile-s3-bucket"
    key            = "terraform_statefile"
    region         = "us-east-1"
    use_lockfile   = true
  }
}

