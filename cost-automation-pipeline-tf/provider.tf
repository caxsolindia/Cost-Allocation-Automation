terraform {
   backend "s3" {
     bucket = "cost-automation-terraform-pipeline-statefile"
     # dynamodb_table = "state-lock"
     key    = "global/mystatefile/terraform.tfstate"
     region = "eu-west-1"
     encrypt = true
     profile = "test-org"
   }
}

provider "aws" {
  profile = "test-org"
  region = "eu-west-1"
}