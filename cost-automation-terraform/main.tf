module "module" {
  source = "./module"
  bucket5 = var.bucket5
  bucket6 = var.bucket6
  bucket7 = var.bucket7
  bucket1 = var.bucket1
  bucket3 = var.bucket3
  bucket2 = var.bucket2
  lambda_function_name = var.lambda_function_name
  lambda_function_name1 = var.lambda_function_name1
  # crawler1 = var.crawler1
  crawler2 = var.crawler2
  crawler3 = var.crawler3
  crawler4 = var.crawler4
  crawler5 = var.crawler5
  crawler6 = var.crawler6
  # bucket_name1 = module.account-a.bucket_name1
  # bucket_name2 = module.account-b.bucket_name2
  
  gluedbname = var.gluedbname
  main_account_no = var.main_account_no
  region = var.region
  providers = {
    aws = aws.test-org
  }
}

# not using these modules since we are using existing cur report name and cur buckets from organisazation account(prod)

# module "account-a" {
#   source = "./account-a"
#   bucket1 = var.bucket1
#   region = "eu-west-1"
#   account_no_a = var.account_no_a
#   main_account_no = var.main_account_no
#   cur_report_name_a = var.cur_report_name_a
#   providers = {
#     aws = aws.mainpayable-accounta
#   }
# }

# module "account-b" {
#   source = "./account-b"
#   bucket2 = var.bucket2
#   region = "us-east-1"
#   account_no_b = var.account_no_b
#   main_account_no = var.main_account_no
#   cur_report_name_b = var.cur_report_name_b
#   providers = {
#     aws = aws.org-master-accountb
#   }
# }

