# Create AWS Cost and Usage Report

resource "aws_s3_bucket" "bucket-a" {
  bucket = var.bucket1
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.bucket-a.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "Policy887047732645",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "billingreports.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy"
            ],
            "Resource": "arn:aws:s3:::${var.bucket1}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${var.account_no_a}",
                    "aws:SourceArn": "arn:aws:cur:us-east-1:${var.account_no_a}:definition/*"
                }
            }
        },
        {
            "Sid": "Stmt1335892526596",
            "Effect": "Allow",
            "Principal": {
                "Service": "billingreports.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.bucket1}/*",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${var.account_no_a}",
                    "aws:SourceArn": "arn:aws:cur:us-east-1:${var.account_no_a}:definition/*"
                }
            }
        },
        {
            "Sid": "AddCannedAcl",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${var.main_account_no}:role/aws-quicksight-service-role-v1",
                    "arn:aws:iam::${var.main_account_no}:root"
                ]
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy",
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::${var.bucket1}"
        },
        {
            "Sid": "AllowReadFiles",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${var.main_account_no}:role/aws-quicksight-service-role-v1",
                    "arn:aws:iam::${var.main_account_no}:root"
                ]
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::${var.bucket1}/*"
        },
        {
            "Sid": "AllowS3AccessEUWest1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.main_account_no}:role/cost_automation_role"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::${var.bucket1}/*"
        }
    ]
  })
}

resource "aws_cur_report_definition" "cur-report-a" {
  report_name                = var.cur_report_name_a
  time_unit                  = "DAILY"
  format                     = "Parquet"
  compression                = "Parquet"
  report_versioning          = "OVERWRITE_REPORT"
  additional_artifacts       = ["ATHENA"]
  additional_schema_elements = ["RESOURCES"]

  s3_bucket = aws_s3_bucket.bucket-a.bucket
  s3_region = "eu-west-1"
  s3_prefix = "test/"
  depends_on = [
    aws_s3_bucket_policy.s3_policy,
  ]
}

# kms key

resource "aws_kms_key" "kms" {
  description = "kms key"
}

resource "aws_kms_alias" "kms" {
  name          = "alias/aws_foundation/CUR_KMS_KEY_TF"
  target_key_id = aws_kms_key.kms.key_id
}

# resource "aws_kms_key_policy" "kmspolicy" {
#   key_id = aws_kms_key.kms.id
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "arn:aws:iam::${var.account_no_a}:root"
#             },
#             "Action": "kms:*",
#             "Resource": "*"
#         },
#         {
#             "Sid": "KeyUsageToManagementAccountGlue",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": [
#                     "arn:aws:iam::${var.main_account_no}:role/service-role/aws-quicksight-service-role-v0",
#                     "arn:aws:iam::${var.main_account_no}:root"
#                 ]
#             },
#             "Action": [
#                 "kms:Encrypt",
#                 "kms:Decrypt",
#                 "kms:ReEncrypt*",
#                 "kms:GenerateDataKey*",
#                 "kms:DescribeKey",
#                 "kms:*"
#             ],
#             "Resource": "*"
#         }
#     ]
#   })
# }
