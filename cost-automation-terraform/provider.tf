terraform {
   backend "s3" {
     bucket = "mhp-cost-automation-terraform-statefile"
     # dynamodb_table = "state-lock"
     key    = "global/mystatefile/terraform.tfstate"
     region = "eu-west-1"
     encrypt = true
     profile = "test-org"
   }
}
  
provider "aws" {
  profile = "main-account"
  alias = "main-account"
  region = "eu-west-1"
}

provider "aws" {
  profile = "accounta"
  alias = "accounta"
  region = "eu-west-1"
}

provider "aws" {
  profile = "accountb"
  alias = "accountb"
  region = "eu-west-1"
}

