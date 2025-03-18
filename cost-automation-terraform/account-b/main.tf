# Create AWS Cost and Usage Report

resource "aws_s3_bucket" "bucket-b" {
  bucket = var.bucket2
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.bucket-b.id

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
            "Resource": "arn:aws:s3:::${var.bucket2}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${var.account_no_b}",
                    "aws:SourceArn": "arn:aws:cur:us-east-1:${var.account_no_b}:definition/*"
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
            "Resource": "arn:aws:s3:::${var.bucket2}/*",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${var.account_no_b}",
                    "aws:SourceArn": "arn:aws:cur:us-east-1:${var.account_no_b}:definition/*"
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
            "Resource": "arn:aws:s3:::${var.bucket2}"
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
            "Resource": "arn:aws:s3:::${var.bucket2}/*"
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
            "Resource": "arn:aws:s3:::${var.bucket2}/*"
        }
    ]
  })
}

resource "aws_cur_report_definition" "cur-report-b" {
  report_name                = var.cur_report_name_b
  time_unit                  = "DAILY"
  format                     = "Parquet"
  compression                = "Parquet"
  report_versioning          = "OVERWRITE_REPORT"
  additional_artifacts       = ["ATHENA"]
  additional_schema_elements = ["RESOURCES"]

  s3_bucket = aws_s3_bucket.bucket-b.bucket
  s3_region = "eu-west-1"
  s3_prefix = "test/"
  depends_on = [
    aws_s3_bucket_policy.s3_policy,
  ]
}
