

data "aws_iam_policy_document" "assume_role_quicksight" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["quicksight.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "role_for_lambda_quicksight" {
  name               = "aws-quicksight-service-role-v1"
  assume_role_policy = data.aws_iam_policy_document.assume_role_quicksight.json
}
resource "aws_iam_policy" "policy_for_lambda_quicksight" {
  name        = "AWSQuicksightAthenaAccess"
  path        = "/"
  description = "AWSQuicksightAthenaAccess"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:BatchGetQueryExecution",
                "athena:CancelQueryExecution",
                "athena:GetCatalogs",
                "athena:GetExecutionEngine",
                "athena:GetExecutionEngines",
                "athena:GetNamespace",
                "athena:GetNamespaces",
                "athena:GetQueryExecution",
                "athena:GetQueryExecutions",
                "athena:GetQueryResults",
                "athena:GetQueryResultsStream",
                "athena:GetTable",
                "athena:GetTables",
                "athena:ListQueryExecutions",
                "athena:RunQuery",
                "athena:StartQueryExecution",
                "athena:StopQueryExecution",
                "athena:ListWorkGroups",
                "athena:ListEngineVersions",
                "athena:GetWorkGroup",
                "athena:GetDataCatalog",
                "athena:GetDatabase",
                "athena:GetTableMetadata",
                "athena:ListDataCatalogs",
                "athena:ListDatabases",
                "athena:ListTableMetadata"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "glue:CreateDatabase",
                "glue:DeleteDatabase",
                "glue:GetDatabase",
                "glue:GetDatabases",
                "glue:UpdateDatabase",
                "glue:CreateTable",
                "glue:DeleteTable",
                "glue:BatchDeleteTable",
                "glue:UpdateTable",
                "glue:GetTable",
                "glue:GetTables",
                "glue:BatchCreatePartition",
                "glue:CreatePartition",
                "glue:DeletePartition",
                "glue:BatchDeletePartition",
                "glue:UpdatePartition",
                "glue:GetPartition",
                "glue:GetPartitions",
                "glue:BatchGetPartition"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload",
                "s3:CreateBucket",
                "s3:PutObject",
                "s3:PutBucketPublicAccessBlock"
            ],
            "Resource": [
                "arn:aws:s3:::aws-athena-query-results-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "lakeformation:GetDataAccess"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
  })
}
resource "aws_iam_policy" "policy_for_lambda_quicksightiamp" {
  name        = "AWSQuickSightIAMPolicy"
  path        = "/"
  description = "AWSQuickSightIAMPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:List*"
            ],
            "Resource": "*"
        }
    ]
  })
}
resource "aws_iam_policy" "policy_for_lambda_quicksightiamprds" {
  name        = "AWSQuickSightRDSPolicy"
  path        = "/"
  description = "AWSQuickSightRDSPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "rds:Describe*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
  })
}
resource "aws_iam_policy" "policy_for_lambda_quicksightiampred" {
  name        = "AWSQuickSightRedshiftPolicy"
  path        = "/"
  description = "AWSQuickSightRedshiftPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "redshift:Describe*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
  })
}
resource "aws_iam_policy" "policy_for_lambda_quicksightiamps3" {
  name        = "AWSQuickSightS3Policy"
  path        = "/"
  description = "AWSQuickSightS3Policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::stanko-rm-temp-2021-09",
                "arn:aws:s3:::basefoundationinfrastruc-mainawsfoundationpipe-mmkru9w8qjdf",
                "arn:aws:s3:::aws-f-project-data",
                "arn:aws:s3:::aws-athena-query-results-eu-west-1-133251199057",
                "arn:aws:s3:::cf-templates-6j99cb488k43-eu-west-1",
                "arn:aws:s3:::aws-foundation-cur-4win",
                "arn:aws:s3:::aws-foundation-athena-cur-results",
                "arn:aws:s3:::aws-glue-assets-133251199057-eu-west-1",
                "arn:aws:s3:::foundationprojectsuti-projectsutilitiesbasepip-br9nx36kyumf",
                "arn:aws:s3:::foundation-copy-of-cur-from-master-payable-account",
                "arn:aws:s3:::foundation-copy-project-data-dynamodb",
                "arn:aws:s3:::cdk-hnb659fds-assets-133251199057-eu-west-1",
                "arn:aws:s3:::stanko-rm-temp-2022-01"
            ]
        },
        {
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::stanko-rm-temp-2021-09/*",
                "arn:aws:s3:::basefoundationinfrastruc-mainawsfoundationpipe-mmkru9w8qjdf/*",
                "arn:aws:s3:::aws-f-project-data/*",
                "arn:aws:s3:::aws-athena-query-results-eu-west-1-133251199057/*",
                "arn:aws:s3:::cf-templates-6j99cb488k43-eu-west-1/*",
                "arn:aws:s3:::aws-foundation-cur-4win/*",
                "arn:aws:s3:::aws-foundation-athena-cur-results/*",
                "arn:aws:s3:::aws-glue-assets-133251199057-eu-west-1/*",
                "arn:aws:s3:::foundationprojectsuti-projectsutilitiesbasepip-br9nx36kyumf/*",
                "arn:aws:s3:::foundation-copy-of-cur-from-master-payable-account/*",
                "arn:aws:s3:::foundation-copy-project-data-dynamodb/*",
                "arn:aws:s3:::cdk-hnb659fds-assets-133251199057-eu-west-1/*",
                "arn:aws:s3:::stanko-rm-temp-2022-01/*"
            ]
        }
    ]
  })
}
resource "aws_iam_policy" "policy_for_lambda_quicksightiampkms" {
  name        = "KMS_READ_CUR_Key_c"
  path        = "/"
  description = "KMS_READ_CUR_Key"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:GetParametersForImport",
                "kms:GetPublicKey",
                "kms:Decrypt",
                "kms:ListKeyPolicies",
                "kms:ListRetirableGrants",
                "kms:GetKeyRotationStatus",
                "kms:GetKeyPolicy",
                "kms:DescribeKey",
                "kms:ListResourceTags",
                "kms:ListGrants"
            ],
            "Resource": "arn:aws:kms:eu-west-1:896720957345:key/2ed597a9-d5c9-47e5-b924-a8d23977f96f"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "kms:DescribeCustomKeyStores",
                "kms:ListKeys",
                "kms:ListAliases"
            ],
            "Resource": "*"
        }
    ]
  })
}
resource "aws_iam_policy_attachment" "lambda_attachment12" {
  name       = "AWSGlueServiceRole_policy_23"
  roles      = [aws_iam_role.role_for_lambda_quicksight.name]
  policy_arn = aws_iam_policy.policy_for_lambda_quicksight.arn
}
resource "aws_iam_policy_attachment" "lambda_attachment13" {
  name       = "AWSGlueServiceRole_policy_24"
  roles      = [aws_iam_role.role_for_lambda_quicksight.name]
  policy_arn = aws_iam_policy.policy_for_lambda_quicksightiamp.arn
}
resource "aws_iam_policy_attachment" "lambda_attachment14" {
  name       = "AWSGlueServiceRole_policy_25"
  roles      = [aws_iam_role.role_for_lambda_quicksight.name]
  policy_arn = aws_iam_policy.policy_for_lambda_quicksightiamprds.arn
}
resource "aws_iam_policy_attachment" "lambda_attachment15" {
  name       = "AWSGlueServiceRole_policy_26"
  roles      = [aws_iam_role.role_for_lambda_quicksight.name]
  policy_arn = aws_iam_policy.policy_for_lambda_quicksightiampred.arn
}
resource "aws_iam_policy_attachment" "lambda_attachment16" {
  name       = "AWSGlueServiceRole_policy_27"
  roles      = [aws_iam_role.role_for_lambda_quicksight.name]
  policy_arn = aws_iam_policy.policy_for_lambda_quicksightiamps3.arn
}
resource "aws_iam_policy_attachment" "lambda_attachment17" {
  name       = "AWSGlueServiceRole_policy_28"
  roles      = [aws_iam_role.role_for_lambda_quicksight.name]
  policy_arn = aws_iam_policy.policy_for_lambda_quicksightiampkms.arn
}

# Glue Role

data "aws_iam_policy_document" "assume_role_glue" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "role_for_lambda_glue" {
  name               = "AWSGlueServiceRole-access-to-data"
  assume_role_policy = data.aws_iam_policy_document.assume_role_glue.json
}
resource "aws_iam_policy" "policy_for_lambda_glue" {
  name        = "AWSGlueServiceRole_p"
  path        = "/"
  description = "AWSGlueServiceRole"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "glue:*",
                "s3:GetBucketLocation",
                "s3:ListBucket",
                "s3:ListAllMyBuckets",
                "s3:GetBucketAcl",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeRouteTables",
                "ec2:CreateNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcAttribute",
                "iam:ListRolePolicies",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket"
            ],
            "Resource": [
                "arn:aws:s3:::aws-glue-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::aws-glue-*/*",
                "arn:aws:s3:::*/*aws-glue-*/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::crawler-public*",
                "arn:aws:s3:::aws-glue-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*:/aws-glue/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Condition": {
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": [
                        "aws-glue-service-resource"
                    ]
                }
            },
            "Resource": [
                "arn:aws:ec2:*:*:network-interface/*",
                "arn:aws:ec2:*:*:security-group/*",
                "arn:aws:ec2:*:*:instance/*"
            ]
        }
    ]
  })
}
resource "aws_iam_policy" "policy_for_lambda_glue1" {
  name        = "AWSGlueServiceRole-access-to-data-policy_glue"
  path        = "/"
  description = "AWSGlueServiceRole-access-to-data-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket1}/*"
            ]
        }
    ]
  })
}
resource "aws_iam_policy_attachment" "lambda_attachment10" {
  name       = "AWSGlueServiceRole_policy_22"
  roles      = [aws_iam_role.role_for_lambda_glue.name]
  policy_arn = aws_iam_policy.policy_for_lambda_glue.arn
}
resource "aws_iam_policy_attachment" "lambda_attachment11" {
  name       = "AWSGlueServiceRole-access-to-data_policy_23"
  roles      = [aws_iam_role.role_for_lambda_glue.name]
  policy_arn = aws_iam_policy.policy_for_lambda_glue1.arn
}

# Lambda Function 1
# cost-automation 

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role_for_lambda" {
  name               = "cost_automation_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "policy_for_lambda" {
  name        = "basic_lambda_policy"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda1" {
  name        = "Athena-access-rights"
  path        = "/"
  description = "Athena-access-rights-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:StartQueryExecution",
                "athena:GetQueryExecution",
                "athena:GetQueryResults",
                "athena:StopQueryExecution"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket6}/*",
                "arn:aws:s3:::${var.bucket5}/"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda2" {
  name        = "glue-access-rights"
  path        = "/"
  description = "glue-access-rights-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "athena:StartQueryExecution",
                "athena:GetQueryExecution",
                "athena:GetQueryResults"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "glue:GetTable",
                "glue:GetPartition",
                "glue:GetPartitions"
            ],
            "Resource": [
                "arn:aws:glue:${var.region}:${var.main_account_no}:catalog",
                "arn:aws:glue:${var.region}:${var.main_account_no}:database/${var.gluedbname}",
                "arn:aws:glue:${var.region}:${var.main_account_no}:table/${var.gluedbname}/*",
                "arn:aws:iam::${var.main_account_no}:role/AWSGlueServiceRole-access-to-data",
                "arn:aws:sts::${var.main_account_no}:assumed-role/AWSGlueServiceRole-access-to-data/AWS-Crawler"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda3" {
  name        = "KMS_READ_CUR_Key"
  path        = "/"
  description = "KMS_READ_CUR_Key-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:GetParametersForImport",
                "kms:GetPublicKey",
                "kms:Decrypt",
                "kms:ListKeyPolicies",
                "kms:ListRetirableGrants",
                "kms:GetKeyRotationStatus",
                "kms:GetKeyPolicy",
                "kms:DescribeKey",
                "kms:ListResourceTags",
                "kms:ListGrants"
            ],
            "Resource": "arn:aws:kms:${var.region}:${var.main_account_no}:key/3ef43c99-55d6-48d6-be78-d2c2b9840206"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "kms:DescribeCustomKeyStores",
                "kms:ListKeys",
                "kms:ListAliases"
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda4" {
  name        = "KMS-project-settings"
  path        = "/"
  description = "KMS-project-settings-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::aws-foundation-projectdata-bucket/*"
        },
        {
            "Effect": "Allow",
            "Action": "kms:Decrypt",
            "Resource": "arn:aws:kms:${var.region}:${var.main_account_no}:key/3ef43c99-55d6-48d6-be78-d2c2b9840206"
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda5" {
  name        = "s3-access-rights"
  path        = "/"
  description = "s3-access-rights-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowS3AccessEUWest1",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload",
                "s3:CreateBucket",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "${var.region}"
                }
            },
            "Resource": [
                "arn:aws:s3:::${var.bucket6}",
                "arn:aws:s3:::${var.bucket6}/*",
                "arn:aws:s3:::aws-foundation-invoice-bucket",
                "arn:aws:s3:::aws-foundation-invoice-bucket/*",
                "arn:aws:s3:::${var.bucket1}",
                "arn:aws:s3:::${var.bucket1}/*",
                "arn:aws:s3:::${var.bucket2}",
                "arn:aws:s3:::${var.bucket2}/*",
                "arn:aws:s3:::${var.bucket3}",
                "arn:aws:s3:::${var.bucket3}/*",
                "arn:aws:s3:::aws-foundation-projectdata-bucket",
                "arn:aws:s3:::aws-foundation-projectdata-bucket/*",
                "arn:aws:s3:::${var.bucket5}/projects-settings/",
                "arn:aws:s3:::${var.bucket5}/invoice_data/"
                # "arn:aws:s3:::aws-foundation-cur-4win",
                # "arn:aws:s3:::aws-foundation-cur-4win/*",
                # "arn:aws:s3:::aws-foundation-testorganisation-cur",
                # "arn:aws:s3:::aws-foundation-testorganisation-cur/*",
                # "arn:aws:s3:::aws-foundation-immersionday-cur-new",
                # "arn:aws:s3:::aws-foundation-immersionday-cur-new/*"
            ]
        },
        {
            "Sid": "AllowS3ReadWriteBucket",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket6}",
                "arn:aws:s3:::${var.bucket6}/*"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda6" {
  name        = "ses-access-rights"
  path        = "/"
  description = "ses-access-rights-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": [
                "arn:aws:ses:${var.region}:${var.main_account_no}:identity/net.pavan.hc@gmail.com"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": [
                "arn:aws:ses:${var.region}:${var.main_account_no}:identity/net.pavan.hc@gmail.com"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": [
                "arn:aws:ses:${var.region}:${var.main_account_no}:identity/net.pavan.hc@gmail.com"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda7" {
  name        = "AWSGlueServiceRole_policy"
  path        = "/"
  description = "AWSGlueServiceRole"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "glue:*",
                "s3:GetBucketLocation",
                "s3:ListBucket",
                "s3:ListAllMyBuckets",
                "s3:GetBucketAcl",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeRouteTables",
                "ec2:CreateNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcAttribute",
                "iam:ListRolePolicies",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket"
            ],
            "Resource": [
                "arn:aws:s3:::aws-glue-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::aws-glue-*/*",
                "arn:aws:s3:::*/*aws-glue-*/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::crawler-public*",
                "arn:aws:s3:::aws-glue-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*:/aws-glue/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Condition": {
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": [
                        "aws-glue-service-resource"
                    ]
                }
            },
            "Resource": [
                "arn:aws:ec2:*:*:network-interface/*",
                "arn:aws:ec2:*:*:security-group/*",
                "arn:aws:ec2:*:*:instance/*"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lambda8" {
  name        = "AWSGlueServiceRole-access-to-data-policy"
  path        = "/"
  description = "AWSGlueServiceRole-access-to-data-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket1}/*"
            ]
        }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_attachment" {
  name       = "lambda_execution_basic_policy"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment1" {
  name       = "lambda_execution_policy_athena-access-rights"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda1.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment2" {
  name       = "lambda_execution_policy_glue-access-rights"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda2.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment3" {
  name       = "lambda_execution_policy_KMS_READ_CUR_Key"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda3.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment4" {
  name       = "lambda_execution_policy_KMS-project-settings"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda4.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment5" {
  name       = "lambda_execution_policy_s3-access-rights"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda5.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment6" {
  name       = "lambda_execution_policy_ses-access-rights"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda6.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment7" {
  name       = "lambda_execution_ROSAKMSProviderPolicy"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/ROSAKMSProviderPolicy"
}

resource "aws_iam_policy_attachment" "lambda_attachment8" {
  name       = "AWSGlueServiceRole_policy"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda7.arn
}

resource "aws_iam_policy_attachment" "lambda_attachment9" {
  name       = "AWSGlueServiceRole-access-to-data_policy"
  roles      = [aws_iam_role.role_for_lambda.name]
  policy_arn = aws_iam_policy.policy_for_lambda8.arn
}

data "archive_file" "samplelambda" {
  type        = "zip"
  source_dir = "module/cost-automation"
  output_path = "module/lambda_function.zip"
}

resource "aws_lambda_function" "lambda_fucntion" {
  filename      = "module/lambda_function.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.role_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.samplelambda.output_base64sha256
  runtime = "python3.10"
  timeout      = 900
  environment {
    variables = {
      ATHENA_QUERY_Detailed = "SELECT * FROM \"cur4win\".\"last_month_project_costs_total\"",
      ATHENA_QUERY_Summary  = "SELECT * FROM \"cur4win\".\"last_month_project_costs_total_summary\"",
      BUCKET_NAME           = "${var.bucket6}",
      CC_ERROR_RECIPIENT    = "net.pavan.hc@gmail.com",
      CC_RECIPIENT          = "net.pavan.hc@gmail.com",
      ERROR_SUBJECT         = "Error in Lambda Function 'Cost Automation'",
      OUTPUT_LOCATION       = "s3://${var.bucket6}/sahel",
      PRIMARY_ERROR_RECIPIENT = "net.pavan.hc@gmail.com",
      PRIMARY_RECIPIENT      = "net.pavan.hc@gmail.com",
      REGION                = "${var.region}",
      SENDER                = "net.pavan.hc@gmail.com"
    }
  }
}

resource "aws_lambda_permission" "allow_eventbridge" {
  function_name =  aws_lambda_function.lambda_fucntion.function_name
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule.arn
}

# Lambda Function 2 
# aws-foundation-projectdataexport-fromdynamodb

data "aws_iam_policy_document" "assume_role1" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role_for_lambda1" {
  name               = "test_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role1.json
}

resource "aws_iam_policy" "policy_for_lamnbda1" {
  name        = "b_policy_for_lambda"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "policy_for_lamnbda2" {
  name        = "export-to-s3-role"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
      "Sid": "DynamoDBPermission",
      "Effect": "Allow",
      "Action": [
        "dynamodb:ExportTableToPointInTime"
      ],
      "Resource": "*"
      },
      {
          "Sid": "S3Permission",
          "Effect": "Allow",
          "Action": [
            "s3:PutObject"
          ],
          "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_attachmednt1" {
  name       = "lambda_execution_policy_emailcheck"
  roles      = [aws_iam_role.role_for_lambda1.name]
  policy_arn = aws_iam_policy.policy_for_lamnbda1.arn
}

resource "aws_iam_policy_attachment" "lambda_attachmednt2" {
  name       = "lambda_execution_policy_export"
  roles      = [aws_iam_role.role_for_lambda1.name]
  policy_arn = aws_iam_policy.policy_for_lamnbda2.arn
}

data "archive_file" "testlambda" {
  type        = "zip"
  source_file = "module/projectdata_dynamodb.py"
  output_path = "module/projectdata_dynamodb.zip"
}

resource "aws_lambda_function" "lambda_fucntion1" {
  filename      = "module/projectdata_dynamodb.zip"
  function_name = var.lambda_function_name1
  role          = aws_iam_role.role_for_lambda1.arn
  handler       = "projectdata_dynamodb.lambda_handler"
  source_code_hash = data.archive_file.testlambda.output_base64sha256
  runtime = "python3.9"
}

resource "aws_lambda_permission" "allow_eventbridge1" {
  function_name =  aws_lambda_function.lambda_fucntion1.function_name
  statement_id  = "AllowExecutionFromEventBridges"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule1.arn
}

# Event Bridge & Rule

resource "aws_cloudwatch_event_bus" "ebus" {
  name = "cost-allocation-event-bus"
}
 
resource "aws_cloudwatch_event_bus_policy" "event_bus_policy" {
  event_bus_name = aws_cloudwatch_event_bus.ebus.name
 
  policy = jsonencode({
   "Version": "2012-10-17",
  "Statement": [{
    "Sid": "AllowAccountToPutEvents",
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.main_account_no}:root"
    },
    "Action": "events:PutEvents",
    "Resource": "arn:aws:events:${var.region}:${var.main_account_no}:event-bus/cost-allocation-event-bus"
  }, {
    "Sid": "AllowAllAccountsFromOrganizationToPutEvents",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "events:PutEvents",
    "Resource": "arn:aws:events:${var.region}:${var.main_account_no}:event-bus/cost-allocation-event-bus",
    "Condition": {
      "StringEquals": {
        "aws:PrincipalOrgID": "o-be4db1ulpd"
      }
    }
  }, {
    "Sid": "AllowAccountToManageRulesTheyCreated",
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.main_account_no}:root"
    },
    "Action": ["events:PutRule", "events:PutTargets", "events:DeleteRule", "events:RemoveTargets", "events:DisableRule", "events:EnableRule", "events:TagResource", "events:UntagResource", "events:DescribeRule", "events:ListTargetsByRule", "events:ListTagsForResource"],
    "Resource": "arn:aws:events:${var.region}:${var.main_account_no}:rule/cost-allocation-event-bus",
    "Condition": {
      "StringEqualsIfExists": {
        "events:creatorAccount": "133251199057"
      }
    }
  }],
  })
}

resource "aws_cloudwatch_event_rule" "rule" {
  name = "aws-costautomation-athena-trigger"
  schedule_expression = "cron(0 9 6 * ? *)"
  # event_bus_name = aws_cloudwatch_event_bus.ebus.name
}

resource "aws_cloudwatch_event_rule" "rule1" {
  name = "aws-costautomation-export-projectdata"
  schedule_expression = "cron(0 9 5 * ? *)"
  # event_bus_name = aws_cloudwatch_event_bus.ebus.name
}

# Target

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.rule.name
  arn       = aws_lambda_function.lambda_fucntion.arn
}

resource "aws_cloudwatch_event_target" "event_target1" {
  rule      = aws_cloudwatch_event_rule.rule1.name
  arn       = aws_lambda_function.lambda_fucntion1.arn
}

# AWS Glue Database

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.gluedbname
}

# S3 Bucket

resource "aws_s3_bucket" "s31" {
  bucket = var.bucket5
}
resource "aws_s3_bucket" "s32" {
  bucket = var.bucket6
}
resource "aws_s3_object" "folder3" {
    bucket = "${aws_s3_bucket.s32.bucket}"
    acl    = "private"
    key    = "sahel/"
    source = "/dev/null"
}
resource "aws_s3_bucket_policy" "s3_policy1" {
  bucket = aws_s3_bucket.s31.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowS3AccessEUWest1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.main_account_no}:role/cost_automation_role"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.bucket5}",
                "arn:aws:s3:::${var.bucket5}/*"
            ]
        }
    ]
  })
}
resource "aws_s3_object" "folder1" {
    bucket = "${aws_s3_bucket.s31.bucket}"
    acl    = "private"
    key    = "projects-settings/"
    source = "/dev/null"
}
resource "aws_s3_object" "folder2" {
    bucket = "${aws_s3_bucket.s31.bucket}"
    acl    = "private"
    key    = "invoice_data/"
    source = "/dev/null"
}

# crawler role

data "aws_iam_policy_document" "assume_role_crawler" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role_for_crawler" {
  name               = "AWSGlueServiceRole-stanko-test-2021-09"
  assume_role_policy = data.aws_iam_policy_document.assume_role_crawler.json
}

resource "aws_iam_policy" "policy_for_crawler" {
  name        = "S3_fullaccess_policy"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version": "2012-10-17",
  "Statement": [
       {
          "Effect": "Allow",
          "Action": [
              "s3:*",
              "s3-object-lambda:*"
          ],
          "Resource": "*"
       }
   ]
  })
}

resource "aws_iam_policy" "policy_for_crawler1" {
  name        = "AWSCloudShellFullAccess_policy"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
       {
          "Action": [
              "cloudshell:*"
          ],
          "Effect": "Allow",
          "Resource": "*"
       }
   ]
  })
}

resource "aws_iam_policy" "policy_for_crawler2" {
  name        = "AWSGlueService_policy"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
       {
          "Effect": "Allow",
          "Action": [
              "glue:*",
              "s3:GetBucketLocation",
              "s3:ListBucket",
              "s3:ListAllMyBuckets",
              "s3:GetBucketAcl",
              "ec2:DescribeVpcEndpoints",
              "ec2:DescribeRouteTables",
              "ec2:CreateNetworkInterface",
              "ec2:DeleteNetworkInterface",
              "ec2:DescribeNetworkInterfaces",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeSubnets",
              "ec2:DescribeVpcAttribute",
              "iam:ListRolePolicies",
              "iam:GetRole",
              "iam:GetRolePolicy",
              "cloudwatch:PutMetricData"
          ],
          "Resource": [
              "*"
          ]
       },
       {
          "Effect": "Allow",
          "Action": [
              "s3:CreateBucket"
          ],
          "Resource": [
              "arn:aws:s3:::aws-glue-*"
          ]
       },
       {
          "Effect": "Allow",
          "Action": [
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject"
          ],
          "Resource": [
              "arn:aws:s3:::aws-glue-*/*",
              "arn:aws:s3:::*/*aws-glue-*/*"
          ]
       },
       {
          "Effect": "Allow",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::crawler-public*",
              "arn:aws:s3:::aws-glue-*"
          ]
       },
       {
          "Effect": "Allow",
          "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
          ],
          "Resource": [
              "arn:aws:logs:*:*:*:/aws-glue/*"
          ]
       },
       {
          "Effect": "Allow",
          "Action": [
              "ec2:CreateTags",
              "ec2:DeleteTags"
          ],
          "Condition": {
              "ForAllValues:StringEquals": {
                   "aws:TagKeys": [
                      "aws-glue-service-resource"
                   ]
              }
          },
          "Resource": [
              "arn:aws:ec2:*:*:network-interface/*",
              "arn:aws:ec2:*:*:security-group/*",
              "arn:aws:ec2:*:*:instance/*"
          ]
       }
   ]
  })
}


resource "aws_iam_policy" "policy_for_crawler4" {
  name        = "UsageKMSinMasterPayable"
  path        = "/"
  description = "policy"

  policy = jsonencode({
    "Version": "2012-10-17",
  "Statement": [
       {
          "Sid": "AllowUseOfKeyInMasterPayable",
          "Effect": "Allow",
          "Action": [
              "kms:Encrypt",
              "kms:Decrypt",
              "kms:ReEncrypt*",
              "kms:GenerateDataKey*",
              "kms:DescribeKey",
              "kms:*"
          ],
          "Resource": "arn:aws:kms:eu-west-1:896720957345:key/2ed597a9-d5c9-47e5-b924-a8d23977f96f"
       },
       {
          "Sid": "ExampleStmt1",
          "Action": [
              "s3:GetObject"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::arn:aws:s3:::aws-foundation-mainpayable-cur/*"
       }
   ]
  })
}

resource "aws_iam_policy_attachment" "crawler_attachment" {
  name       = "crawler_attachment"
  roles      = [aws_iam_role.role_for_crawler.name]
  policy_arn = aws_iam_policy.policy_for_crawler.arn
}

resource "aws_iam_policy_attachment" "crawler_glue_attachment1" {
  name       = "crawler_glue_attachment1"
  roles      = [aws_iam_role.role_for_crawler.name]
  policy_arn = aws_iam_policy.policy_for_crawler1.arn
}

resource "aws_iam_policy_attachment" "crawler_glue_attachment2" {
  name       = "crawler_glue_attachment2"
  roles      = [aws_iam_role.role_for_crawler.name]
  policy_arn = aws_iam_policy.policy_for_crawler2.arn
}

# resource "aws_iam_policy_attachment" "crawler_glue_attachment3" {
#   name       = "crawler_glue_attachment3"
#   roles      = [aws_iam_role.role_for_crawler.name]
#   policy_arn = aws_iam_policy.policy_for_crawler3.arn
# }

resource "aws_iam_policy_attachment" "crawler_glue_attachment4" {
  name       = "crawler_glue_attachment4"
  roles      = [aws_iam_role.role_for_crawler.name]
  policy_arn = aws_iam_policy.policy_for_crawler4.arn
}


# crawler 2

resource "aws_glue_crawler" "example1" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  schedule      = "cron(25 3 4 * ? *)"
  name          = var.crawler2
  role          = aws_iam_role.role_for_crawler.arn

  s3_target {
    path = "s3://${var.bucket3}/cur/aws-foundation-immersinday-cur/aws-foundation-immersinday-cur/"
  }
}

# crawler 3

resource "aws_glue_crawler" "example2" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  schedule      = "cron(25 3 4 * ? *)"
  name          = var.crawler3
  role          = aws_iam_role.role_for_crawler.arn

  s3_target {
    path = "s3://${var.bucket2}/cur/aws-foundation-testorganisation-cur/aws-foundation-testorganisation-cur/"
  }
}

# crawler 4

resource "aws_glue_crawler" "example3" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  schedule      = "cron(25 3 4 * ? *)"
  name          = var.crawler4
  role          = aws_iam_role.role_for_crawler.arn

  s3_target {
    path = "s3://${var.bucket5}/projects-settings/"
  }
}

# crawler 5

resource "aws_glue_crawler" "example4" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  schedule      = "cron(25 3 4 * ? *)"
  name          = var.crawler5
  role          = aws_iam_role.role_for_crawler.arn

  s3_target {
    path = "s3://${var.bucket5}/invoice_data/"
  }
}

# crawler 6

resource "aws_glue_crawler" "example5" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  schedule      = "cron(25 3 4 * ? *)"
  name          = var.crawler6
  role          = aws_iam_role.role_for_crawler.arn

  s3_target {
    path = "s3://${var.bucket1}/cur/aws-foundation-mainpayable-cur/aws-foundation-mainpayable-cur/"
    exclusions = ["**.json", "**.yml", "**.sql", "**.gz","**.gzip"]
    sample_size = 1 
  }


# AWS Athena

resource "aws_s3_bucket" "example" {
  bucket = var.bucket7
}

resource "null_resource" "query1" {
  depends_on = [aws_s3_bucket.example]
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE EXTERNAL TABLE IF NOT EXISTS invoice_data(
          rechnungsid STRING,
          aws_service_charges_in_dollar DOUBLE,
          aws_service_charges_in_euro DOUBLE,
          exchange_rate STRING,
          year BIGINT,
          month BIGINT,
          aws_service_charges_in_dollar_with_out_vat_and_credits DOUBLE,
          aws_service_charges_in_euro_with_out_vat_and_credits DOUBLE
          )
          ROW FORMAT DELIMITED
          FIELDS TERMINATED BY '\t'
          LINES TERMINATED BY '\n'
          LOCATION 's3://${var.bucket5}/invoice_data/////';" \
          --result-configuration OutputLocation=s3://${var.bucket7}/ \
          --region ${var.region}
    EOT
  }
}

resource "null_resource" "query22" {
  depends_on = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE EXTERNAL TABLE IF NOT EXISTS aws_foundation_mainpayable_cur (
          identity_line_item_id string,
          identity_time_interval string,          
          bill_invoice_id string,
          bill_invoicing_entity string,
          bill_billing_entity string,
          bill_bill_type string,
          bill_payer_account_id string,
          bill_billing_period_start_date timestamp,
          bill_billing_period_end_date timestamp,
          line_item_usage_account_id string,
          line_item_line_item_type string,
          line_item_usage_start_date timestamp,
          line_item_usage_end_date timestamp,
          line_item_product_code string,
          line_item_usage_type string,
          line_item_operation string,
          line_item_availability_zone string,
          line_item_resource_id string,
          line_item_usage_amount double,
          line_item_normalization_factor double,
          line_item_normalized_usage_amount double,
          line_item_currency_code string,
          line_item_unblended_rate string,
          line_item_unblended_cost double,
          line_item_blended_rate string,
          line_item_blended_cost double,
          line_item_line_item_description string,
          line_item_tax_type string,
          line_item_legal_entity string,
          product_product_name string,
          product_size_flex string,
          product_account_assistance string,
          product_accounts string,
          product_alarm_type string,
          product_architectural_review string,
          product_architecture string,
          product_architecture_support string,
          product_availability string,
          product_availability_zone string,
          product_backupservice string,
          product_base_product_reference_code string,
          product_best_practices string,
          product_broker_engine string,
          product_cache_engine string,
          product_capacitystatus string,
          product_case_severityresponse_times string,
          product_category string,
          product_ci_type string,
          product_classicnetworkingsupport string,
          product_clock_speed string,
          product_component string,
          product_compute_family string,
          product_compute_type string,
          product_content_type string,
          product_counts_against_quota string,
          product_cpu_architecture string,
          product_cputype string,
          product_current_generation string,
          product_customer_service_and_communities string,
          product_data string,
          product_data_transfer_quota string,
          product_data_type string,
          product_database_engine string,
          product_datatransferout string,
          product_dedicated_ebs_throughput string,
          product_deployment_option string,
          product_describes string,
          product_description string,
          product_disableactivationconfirmationemail string,
          product_durability string,
          product_duration string,
          product_ecu string,
          product_edition string,
          product_endpoint string,
          product_endpoint_type string,
          product_engine string,
          product_engine_code string,
          product_enhanced_networking_support string,
          product_enhanced_networking_supported string,
          product_equivalentondemandsku string,
          product_event_type string,
          product_feature string,
          product_fee_code string,
          product_fee_description string,
          product_finding_group string,
          product_finding_source string,
          product_finding_storage string,
          product_flow string,
          product_free_overage string,
          product_free_query_types string,
          product_free_usage_included string,
          product_from_location string,
          product_from_location_type string,
          product_from_region_code string,
          product_gets string,
          product_gpu string,
          product_gpu_memory string,
          product_graphqloperation string,
          product_group string,
          product_group_description string,
          product_included_services string,
          product_inference_type string,
          product_instance string,
          product_instance_family string,
          product_instance_name string,
          product_instance_type string,
          product_instance_type_family string,
          product_intel_avx2_available string,
          product_intel_avx_available string,
          product_intel_turbo_available string,
          product_invocation string,
          product_launch_support string,
          product_license_model string,
          product_location string,
          product_location_type string,
          product_logs_destination string,
          product_m2m_category string,
          product_marketoption string,
          product_max_iops_burst_performance string,
          product_max_iopsvolume string,
          product_max_throughputvolume string,
          product_max_volume_size string,
          product_maximum_extended_storage string,
          product_memory string,
          product_memory_gib string,
          product_memorytype string,
          product_message_delivery_frequency string,
          product_message_delivery_order string,
          product_min_volume_size string,
          product_network_performance string,
          product_newcode string,
          product_normalization_size_factor string,
          product_operating_system string,
          product_operation string,
          product_operations_support string,
          product_ops_items string,
          product_origin string,
          product_overage_type string,
          product_overhead string,
          product_pack_size string,
          product_parameter_type string,
          product_physical_cpu string,
          product_physical_gpu string,
          product_physical_processor string,
          product_platoclassificationtype string,
          product_platoinstancename string,
          product_platoinstancetype string,
          product_platopricingtype string,
          product_policy_type string,
          product_pre_installed_sw string,
          product_pricing_unit string,
          product_pricingplan string,
          product_proactive_guidance string,
          product_processor_architecture string,
          product_processor_features string,
          product_product_family string,
          product_product_schema_description string,
          product_product_type string,
          product_programmatic_case_management string,
          product_protocol string,
          product_provider string,
          product_provisioned string,
          product_q_present string,
          product_queue_type string,
          product_ratetype string,
          product_realtimeoperation string,
          product_recipient string,
          product_region string,
          product_region_code string,
          product_request_description string,
          product_request_type string,
          product_resource string,
          product_resource_endpoint string,
          product_routing_target string,
          product_routing_type string,
          product_scan_type string,
          product_servicecode string,
          product_servicename string,
          product_sku string,
          product_standard_group string,
          product_standard_storage string,
          product_standard_storage_retention_included string,
          product_steps string,
          product_storage string,
          product_storage_class string,
          product_storage_media string,
          product_storage_type string,
          product_subscription_type string,
          product_subservice string,
          product_technical_support string,
          product_tenancy string,
          product_tenancy_support string,
          product_thirdparty_software_support string,
          product_throughput string,
          product_tickettype string,
          product_tier string,
          product_tiertype string,
          product_time_window string,
          product_titan_model string,
          product_to_location string,
          product_to_location_type string,
          product_to_region_code string,
          product_training string,
          product_transfer_type string,
          product_type string,
          product_type_description string,
          product_updates string,
          product_usage_family string,
          product_usage_group string,
          product_usage_volume string,
          product_usagetype string,
          product_vaulttype string,
          product_vcpu string,
          product_version string,
          product_volume_api_name string,
          product_volume_type string,
          product_vpcnetworkingsupport string,
          product_who_can_open_cases string,
          product_with_active_users double,
          pricing_rate_code string,
          pricing_rate_id string,
          pricing_currency string,
          pricing_public_on_demand_cost double,
          pricing_public_on_demand_rate string,
          pricing_term string,
          pricing_unit string,
          reservation_amortized_upfront_cost_for_usage double,
          reservation_amortized_upfront_fee_for_billing_period double,
          reservation_effective_cost double,
          reservation_end_time string,
          reservation_modification_status string,
          reservation_normalized_units_per_reservation string,
          reservation_number_of_reservations string,
          reservation_recurring_fee_for_usage double,
          reservation_start_time string,
          reservation_subscription_id string,
          reservation_total_reserved_normalized_units string,
          reservation_total_reserved_units string,
          reservation_units_per_reservation string,
          reservation_unused_amortized_upfront_fee_for_billing_period double,
          reservation_unused_normalized_unit_quantity double,
          reservation_unused_quantity double,
          reservation_unused_recurring_fee double,
          reservation_upfront_value double,
          savings_plan_total_commitment_to_date double,
          savings_plan_savings_plan_a_r_n string,
          savings_plan_savings_plan_rate double,
          savings_plan_used_commitment double,
          savings_plan_savings_plan_effective_cost double,
          savings_plan_amortized_upfront_commitment_for_billing_period double,
          savings_plan_recurring_commitment_for_billing_period double,
          resource_tags_aws_created_by string,
          resource_tags_user_project_name string,
          resource_tags_user_cost_level string,
          resource_tags_user_cost_project string,
          resource_tags_user_cost_subproject string,
          cost_category_project_name string,
          product_api_type string,
          product_entity_type string,
          product_platopagedatatype string,
          year string,
          month string
        )
        ROW FORMAT DELIMITED
        LOCATION 's3://${var.bucket1}/cur/aws-foundation-mainpayable-cur/aws-foundation-mainpayable-cur/////';" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "query3" {
  depends_on = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE EXTERNAL TABLE IF NOT EXISTS aws_foundation_billing_cur_athena_testaccount(
          identity_line_item_id string,
          identity_time_interval string,
          bill_invoice_id string,
          bill_invoicing_entity string,
          bill_billing_entity string,
          bill_bill_type string,
          bill_payer_account_id string,
          bill_billing_period_start_date timestamp,
          bill_billing_period_end_date timestamp,
          line_item_usage_account_id string,
          line_item_line_item_type string,
          line_item_usage_start_date timestamp,
          line_item_usage_end_date timestamp,
          line_item_product_code string,
          line_item_usage_type string,
          line_item_operation string,
          line_item_availability_zone string,
          line_item_resource_id string,
          line_item_usage_amount double,
          line_item_normalization_factor double,
          line_item_normalized_usage_amount double,
          line_item_currency_code string,
          line_item_unblended_rate string,
          line_item_unblended_cost double,
          line_item_blended_rate string,
          line_item_blended_cost double,
          line_item_line_item_description string,
          line_item_tax_type string,
          line_item_legal_entity string,
          product_product_name string,
          product_size_flex string,
          product_alarm_type string,
          product_availability string,
          product_availability_zone string,
          product_backupservice string,
          product_capacitystatus string,
          product_category string,
          product_ci_type string,
          product_classicnetworkingsupport string,
          product_clock_speed string,
          product_compute_family string,
          product_compute_type string,
          product_current_generation string,
          product_datatransferout string,
          product_description string,
          product_durability string,
          product_ecu string,
          product_endpoint_type string,
          product_enhanced_networking_supported string,
          product_event_type string,
          product_finding_group string,
          product_finding_source string,
          product_finding_storage string,
          product_free_usage_included string,
          product_from_location string,
          product_from_location_type string,
          product_from_region_code string,
          product_gpu_memory string,
          product_group string,
          product_group_description string,
          product_instance_family string,
          product_instance_type string,
          product_instance_type_family string,
          product_intel_avx2_available string,
          product_intel_avx_available string,
          product_intel_turbo_available string,
          product_license_model string,
          product_location string,
          product_location_type string,
          product_logs_destination string,
          product_marketoption string,
          product_max_iops_burst_performance string,
          product_max_iopsvolume string,
          product_max_throughputvolume string,
          product_max_volume_size string,
          product_memory string,
          product_message_delivery_frequency string,
          product_message_delivery_order string,
          product_network_performance string,
          product_normalization_size_factor string,
          product_operating_system string,
          product_operation string,
          product_physical_processor string,
          product_platopricingtype string,
          product_pre_installed_sw string,
          product_processor_architecture string,
          product_processor_features string,
          product_product_family string,
          product_queue_type string,
          product_region string,
          product_region_code string,
          product_scan_type string,
          product_servicecode string,
          product_servicename string,
          product_sku string,
          product_standard_group string,
          product_standard_storage string,
          product_storage string,
          product_storage_class string,
          product_storage_media string,
          product_storage_type string,
          product_tenancy string,
          product_to_location string,
          product_to_location_type string,
          product_to_region_code string,
          product_transfer_type string,
          product_usage_volume string,
          product_usagetype string,
          product_vcpu string,
          product_version string,
          product_volume_api_name string,
          product_volume_type string,
          product_vpcnetworkingsupport string,
          product_with_active_users string,
          pricing_rate_code string,
          pricing_rate_id string,
          pricing_currency string,
          pricing_public_on_demand_cost double,
          pricing_public_on_demand_rate string,
          pricing_term string,
          pricing_unit string,
          reservation_amortized_upfront_cost_for_usage double,
          reservation_amortized_upfront_fee_for_billing_period double,
          reservation_effective_cost double,
          reservation_end_time string,
          reservation_modification_status string,
          reservation_normalized_units_per_reservation string,
          reservation_number_of_reservations string,
          reservation_recurring_fee_for_usage double,
          reservation_start_time string,
          reservation_subscription_id string,
          reservation_total_reserved_normalized_units string,
          reservation_total_reserved_units string,
          reservation_units_per_reservation string,
          reservation_unused_amortized_upfront_fee_for_billing_period double,
          reservation_unused_normalized_unit_quantity double,
          reservation_unused_quantity double,
          reservation_unused_recurring_fee double,
          reservation_upfront_value double,
          savings_plan_total_commitment_to_date double,
          savings_plan_savings_plan_a_r_n string,
          savings_plan_savings_plan_rate double,
          savings_plan_used_commitment double,
          savings_plan_savings_plan_effective_cost double,
          savings_plan_amortized_upfront_commitment_for_billing_period double,
          savings_plan_recurring_commitment_for_billing_period double,
          product_architecture string,
          product_product_type string,
          product_invocation string,
          product_time_window string,
          product_abd_instance_class string,
          product_describes string,
          product_gets string,
          product_ops_items string,
          product_updates string,
          product_pricingplan string,
          product_provider string,
          product_subservice string,
          product_type string,
          konto string,
          year string,
          month string
        )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
        LINES TERMINATED BY '\n'
        LOCATION 's3://${var.bucket2}/cur/aws-foundation-testorganisation-cur/aws-foundation-testorganisation-cur/////';" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "query4" {
  depends_on = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE EXTERNAL TABLE IF NOT EXISTS aws_foundation_immersinday_cur (
          identity_line_item_id string,
          identity_time_interval string,
          bill_invoice_id string,
          bill_invoicing_entity string,
          bill_billing_entity string,
          bill_bill_type string,
          bill_payer_account_id string,
          bill_billing_period_start_date timestamp,
          bill_billing_period_end_date timestamp,
          line_item_usage_account_id string,
          line_item_line_item_type string,
          line_item_usage_start_date timestamp,
          line_item_usage_end_date timestamp,
          line_item_product_code string,
          line_item_usage_type string,
          line_item_operation string,
          line_item_availability_zone string,
          line_item_resource_id string,
          line_item_usage_amount double,
          line_item_normalization_factor double,
          line_item_normalized_usage_amount double,
          line_item_currency_code string,
          line_item_unblended_rate string,
          line_item_unblended_cost double,
          line_item_blended_rate string,
          line_item_blended_cost double,
          line_item_line_item_description string,
          line_item_tax_type string,
          line_item_legal_entity string,
          product_product_name string,
          product_size_flex string,
          product_availability string,
          product_backupservice string,
          product_category string,
          product_ci_type string,
          product_durability string,
          product_from_location string,
          product_from_location_type string,
          product_from_region_code string,
          product_group string,
          product_group_description string,
          product_location string,
          product_location_type string,
          product_logs_destination string,
          product_message_delivery_frequency string,
          product_message_delivery_order string,
          product_operation string,
          product_platopricingtype string,
          product_product_family string,
          product_queue_type string,
          product_region string,
          product_region_code string,
          product_servicecode string,
          product_servicename string,
          product_sku string,
          product_storage_class string,
          product_storage_media string,
          product_storage_type string,
          product_to_location string,
          product_to_location_type string,
          product_to_region_code string,
          product_transfer_type string,
          product_usagetype string,
          product_version string,
          product_volume_type string,
          pricing_rate_code string,
          pricing_rate_id string,
          pricing_currency string,
          pricing_public_on_demand_cost double,
          pricing_public_on_demand_rate string,
          pricing_term string,
          pricing_unit string,
          reservation_amortized_upfront_cost_for_usage double,
          reservation_amortized_upfront_fee_for_billing_period double,
          reservation_effective_cost double,
          reservation_end_time string,
          reservation_modification_status string,
          reservation_normalized_units_per_reservation string,
          reservation_number_of_reservations string,
          reservation_recurring_fee_for_usage double,
          reservation_start_time string,
          reservation_subscription_id string,
          reservation_total_reserved_normalized_units string,
          reservation_total_reserved_units string,
          reservation_units_per_reservation string,
          reservation_unused_amortized_upfront_fee_for_billing_period double,
          reservation_unused_normalized_unit_quantity double,
          reservation_unused_quantity double,
          reservation_unused_recurring_fee double,
          reservation_upfront_value double,
          savings_plan_total_commitment_to_date double,
          savings_plan_savings_plan_a_r_n string,
          savings_plan_savings_plan_rate double,
          savings_plan_used_commitment double,
          savings_plan_savings_plan_effective_cost double,
          savings_plan_amortized_upfront_commitment_for_billing_period double,
          savings_plan_recurring_commitment_for_billing_period double,
          product_vaulttype string,
          year string,
          month string
        )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
        LINES TERMINATED BY '\n'
        LOCATION 's3://${var.bucket3}/cur/aws-foundation-immersinday-cur/aws-foundation-immersinday-cur/////';" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "query55" {
  depends_on = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE EXTERNAL TABLE IF NOT EXISTS projects_settings (
          awsaccountid string,
          accountemail string,
          accountname string,
          projectname string,
          projectidentifier string,
          budgetname string,
          projectlead string,
          projectdeputy string,
          billingcontact string,
          securitycontact string,
          operationcontact string,
          projectstartdate string,
          projectenddate string,
          projectbudget string,
          projectjobnumber string,
          uplift string,
          billable string,
          projectcostcenter string,
          cluster string,
          serviceunit string,
          businessarea string,
          comment string,
          accountdeprovisioningdate string,
          accountdeleted string,
          projectclosed string,
          adgroup string,
          projectdescription string,
          konto string
        )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
        LINES TERMINATED BY '\n'
        LOCATION 's3://${var.bucket5}/projects-settings/////';" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "query66" {
  depends_on = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE EXTERNAL TABLE IF NOT EXISTS aws_foundation_testorganisation_cur (
          identity_line_item_id string,
          identity_time_interval string,
          bill_invoice_id string,
          bill_invoicing_entity string,
          bill_billing_entity string,
          bill_bill_type string,
          bill_payer_account_id string,
          bill_billing_period_start_date timestamp,
          bill_billing_period_end_date timestamp,
          line_item_usage_account_id string,
          line_item_line_item_type string,
          line_item_usage_start_date timestamp,
          line_item_usage_end_date timestamp,
          line_item_product_code string,
          line_item_usage_type string,
          line_item_operation string,
          line_item_availability_zone string,
          line_item_resource_id string,
          line_item_usage_amount double,
          line_item_normalization_factor double,
          line_item_normalized_usage_amount double,
          line_item_currency_code string,
          line_item_unblended_rate string,
          line_item_unblended_cost double,
          line_item_blended_rate string,
          line_item_blended_cost double,
          line_item_line_item_description string,
          line_item_tax_type string,
          line_item_legal_entity string,
          product_product_name string,
          product_size_flex string,
          product_alarm_type string,
          product_availability string,
          product_availability_zone string,
          product_backupservice string,
          product_capacitystatus string,
          product_category string,
          product_ci_type string,
          product_classicnetworkingsupport string,
          product_clock_speed string,
          product_compute_family string,
          product_compute_type string,
          product_current_generation string,
          product_datatransferout string,
          product_description string,
          product_durability string,
          product_ecu string,
          product_endpoint_type string,
          product_enhanced_networking_supported string,
          product_event_type string,
          product_finding_group string,
          product_finding_source string,
          product_finding_storage string,
          product_free_usage_included string,
          product_from_location string,
          product_from_location_type string,
          product_from_region_code string,
          product_gpu_memory string,
          product_group string,
          product_group_description string,
          product_instance_family string,
          product_instance_type string,
          product_instance_type_family string,
          product_intel_avx2_available string,
          product_intel_avx_available string,
          product_intel_turbo_available string,
          product_license_model string,
          product_location string,
          product_location_type string,
          product_logs_destination string,
          product_marketoption string,
          product_max_iops_burst_performance string,
          product_max_iopsvolume string,
          product_max_throughputvolume string,
          product_max_volume_size string,
          product_memory string,
          product_message_delivery_frequency string,
          product_message_delivery_order string,
          product_network_performance string,
          product_normalization_size_factor string,
          product_operating_system string,
          product_operation string,
          product_physical_processor string,
          product_platopricingtype string,
          product_pre_installed_sw string,
          product_processor_architecture string,
          product_processor_features string,
          product_product_family string,
          product_queue_type string,
          product_region string,
          product_region_code string,
          product_scan_type string,
          product_servicecode string,
          product_servicename string,
          product_sku string,
          product_standard_group string,
          product_standard_storage string,
          product_storage string,
          product_storage_class string,
          product_storage_media string,
          product_storage_type string,
          product_tenancy string,
          product_to_location string,
          product_to_location_type string,
          product_to_region_code string,
          product_transfer_type string,
          product_usage_volume string,
          product_usagetype string,
          product_vcpu string,
          product_version string,
          product_volume_api_name string,
          product_volume_type string,
          product_vpcnetworkingsupport string,
          product_with_active_users string,
          pricing_rate_code string,
          pricing_rate_id string,
          pricing_currency string,
          pricing_public_on_demand_cost double,
          pricing_public_on_demand_rate string,
          pricing_term string,
          pricing_unit string,
          reservation_amortized_upfront_cost_for_usage double,
          reservation_amortized_upfront_fee_for_billing_period double,
          reservation_effective_cost double,
          reservation_end_time string,
          reservation_modification_status string,
          reservation_normalized_units_per_reservation string,
          reservation_number_of_reservations string,
          reservation_recurring_fee_for_usage double,
          reservation_start_time string,
          reservation_subscription_id string,
          reservation_total_reserved_normalized_units string,
          reservation_total_reserved_units string,
          reservation_units_per_reservation string,
          reservation_unused_amortized_upfront_fee_for_billing_period double,
          reservation_unused_normalized_unit_quantity double,
          reservation_unused_quantity double,
          reservation_unused_recurring_fee double,
          reservation_upfront_value double,
          savings_plan_total_commitment_to_date double,
          savings_plan_savings_plan_a_r_n string,
          savings_plan_savings_plan_rate double,
          savings_plan_used_commitment double,
          savings_plan_savings_plan_effective_cost double,
          savings_plan_amortized_upfront_commitment_for_billing_period double,
          savings_plan_recurring_commitment_for_billing_period double,
          product_architecture string,
          product_product_type string,
          product_invocation string,
          product_time_window string,
          product_abd_instance_class string,
          product_describes string,
          product_gets string,
          product_ops_items string,
          product_updates string,
          product_pricingplan string,
          product_provider string,
          product_subservice string,
          product_type string,
          product_vaulttype string,
          product_content_type string,
          product_origin string,
          product_recipient string,
          year string,
          month string
        ) 
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
        LINES TERMINATED BY '\n'
        LOCATION 's3://${var.bucket2}/cur/aws-foundation-testorganisation-cur/aws-foundation-testorganisation-cur/////';" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

# View query

resource "null_resource" "v1" {
  depends_on = [null_resource.query66]
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"aws-f_project_costs_per_service\" AS 
          SELECT
            *,
            RANK() OVER (PARTITION BY \"project_id\", \"type\", \"year_month\" ORDER BY \"total_costs\" DESC) AS rank
          FROM
            (
             SELECT
               \"projects\".\"projectidentifier\" AS \"project_id\",
               CONCAT(\"year\", '-', LPAD(\"month\", 2, '0')) AS \"year_month\",
               \"year\",
               \"month\",
               \"product_servicename\" AS \"service_name\",
               ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"total_costs\",
               \"projects\".\"projectname\" AS \"project_name\",
               \"projects\".\"cluster\",
               \"projects\".\"serviceunit\" AS \"service_unit\",
               \"projects\".\"businessarea\" AS \"business_area\",
               \"projects\".\"projectlead\" AS \"project_lead\",
               \"line_item_line_item_type\" AS \"type\",
               \"projects\".\"projectbudget\" AS \"budget\"
             FROM
               (\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
               LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
             WHERE NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))
             GROUP BY \"projectidentifier\", \"bill_billing_period_start_date\", \"costs\".\"product_servicename\", \"projects\".\"projectname\", \"projects\".\"cluster\", \"projects\".\"serviceunit\", \"projects\".\"projectlead\", \"line_item_line_item_type\", \"year\", \"month\", \"projects\".\"projectbudget\", \"businessarea\"
             ORDER BY \"projects\".\"projectidentifier\" ASC
            );" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v2" {
  depends_on = [null_resource.v1] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"aws-f_project_costs_per_account\" AS 
          SELECT
            *,
            RANK() OVER (PARTITION BY \"project_id\", \"type\", \"year_month\" ORDER BY \"total_costs\" DESC) AS rank
          FROM
            (
             SELECT
               \"projects\".\"projectidentifier\" AS \"project_id\",
               CONCAT(\"year\", '-', LPAD(\"month\", 2, '0')) AS \"year_month\",
               \"year\",
               \"month\",
               \"line_item_usage_account_id\" AS \"account_id\",
               ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"total_costs\",
               \"projects\".\"projectname\" AS \"project_name\",
               \"projects\".\"cluster\",
               \"projects\".\"serviceunit\" AS \"service_unit\",
               \"projects\".\"businessarea\" AS \"business_area\",
               \"projects\".\"projectlead\" AS \"project_lead\",
               \"line_item_line_item_type\" AS \"type\",
               \"projects\".\"projectbudget\" AS \"budget\"
             FROM
               (\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
               LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
             WHERE NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))
             GROUP BY \"projectidentifier\", \"bill_billing_period_start_date\", \"costs\".\"line_item_usage_account_id\", \"projects\".\"projectname\", \"projects\".\"cluster\", \"projects\".\"serviceunit\", \"projects\".\"projectlead\", \"line_item_line_item_type\", \"year\", \"month\", \"projects\".\"projectbudget\", \"businessarea\"
             ORDER BY \"projects\".\"projectidentifier\" ASC
            );" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v3" {
  depends_on = [null_resource.v2] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"aws-f_project_costs\" AS 
          SELECT
            *,
            RANK() OVER (PARTITION BY \"type\", \"year_month\" ORDER BY \"total_costs\" DESC) AS rank
          FROM
            (
             SELECT
               \"projects\".\"projectidentifier\" AS \"project_id\",
               CONCAT(\"year\", '-', LPAD(\"month\", 2, '0')) AS \"year_month\",
               \"year\",
               \"month\",
               ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"total_costs\",
               SUM(\"line_item_unblended_cost\") AS \"total_costs_unblended\",
               SUM(\"line_item_blended_cost\") AS \"total_costs_blended\",
               \"projects\".\"projectname\" AS \"project_name\",
               \"projects\".\"cluster\",
               \"projects\".\"serviceunit\" AS \"service_unit\",
               \"projects\".\"businessarea\" AS \"business_area\",
               \"projects\".\"projectlead\" AS \"project_lead\",
               \"line_item_line_item_type\" AS \"type\",
               \"projects\".\"projectbudget\" AS \"budget\"
             FROM
               \"cur4win\".\"aws_foundation_billing_cur_athena\" costs
               LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\")
             WHERE NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))
             GROUP BY \"projectidentifier\", \"bill_billing_period_start_date\", \"projects\".\"projectname\", \"projects\".\"cluster\", \"projects\".\"serviceunit\", \"projects\".\"projectlead\", \"line_item_line_item_type\", \"year\", \"month\", \"projects\".\"projectbudget\", \"businessarea\"
             ORDER BY \"projects\".\"projectidentifier\" ASC
            );" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v4" {
  depends_on = [null_resource.v3] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_summary_page\" AS 
          WITH
            cte AS (
             SELECT
               \"bill_invoice_id\",
               \"bill_billing_entity\",
               SUM((CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN -(\"line_item_unblended_cost\") ELSE 0 END)) AS Credit,
               SUM((CASE WHEN (NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))) THEN \"line_item_unblended_cost\" ELSE 0 END)) AS Total_Cost
             FROM
               (
                SELECT
                  \"bill_invoice_id\",
                  \"bill_billing_entity\",
                  \"line_item_line_item_type\",
                  \"line_item_unblended_cost\",
                  \"year\",
                  \"month\"
                FROM
                  \"cur4win\".\"aws_foundation_billing_cur_athena\"
                UNION ALL
                SELECT
                  \"bill_invoice_id\",
                  \"bill_billing_entity\",
                  \"line_item_line_item_type\",
                  \"line_item_unblended_cost\",
                  \"year\",
                  \"month\"
                FROM
                  \"cur4win\".\"aws_foundation_billing_cur_athena_testaccount\"
                UNION ALL
                SELECT
                  \"bill_invoice_id\",
                  \"bill_billing_entity\",
                  \"line_item_line_item_type\",
                  \"line_item_unblended_cost\",
                  \"year\",
                  \"month\"
                FROM
                  \"cur4win\".\"aws_foundation_immersionday_cur\"
               )  all_tables
             WHERE (((\"line_item_line_item_type\" = 'Credit') AND (\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR))) OR ((NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))) AND (\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR))))
             GROUP BY \"bill_invoice_id\", \"bill_billing_entity\"
            ) 
          SELECT
            \"bill_invoice_id\" AS \"AWS Rechnungsnummer\",
            SUM(Total_Cost) AS \"AWS Kosten Gesamt (Netto)\",
            SUM(Credit) AS \"Preisvorteil (Credits)\"
          FROM
            cte
          GROUP BY \"bill_invoice_id\", \"bill_billing_entity\";" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v5" {
  depends_on = [null_resource.v4] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_summary\" AS 
          SELECT
            \"bill_invoice_id\" AS \"Rechnungsnummer\",
            ROUND(((SELECT CAST(\"exchange_rate\" AS double) FROM cur4win.invoice_data LIMIT 1) * SUM(\"line_item_unblended_cost\")), 2) AS \"Betrag € Netto\"
          FROM
            cur4win.aws_foundation_billing_cur_athena costs
          WHERE ((NOT (costs.line_item_line_item_type IN ('Tax', 'Credit'))) AND (costs.\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (costs.\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\";" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v6" {
  depends_on = [null_resource.v5] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_per_account_per_service\" AS 
          SELECT
            \"projects\".\"projectname\" AS \"project_name\",
            \"projects\".\"awsaccountid\" AS \"aws_account_id\",
            \"projects\".\"accountname\" AS \"aws_account_name\",
            \"costs\".\"product_servicename\" AS \"service_name\",
            ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"total_costs\",
            SUM(\"line_item_unblended_cost\") AS \"unblended_cost\",
            SUM(\"line_item_blended_cost\") AS \"blended_cost\"
          FROM
            \"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\")
          WHERE ((NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))) AND (\"year\" = CAST(year(date_add('MONTH', -1, current_date)) AS varchar)) AND (\"month\" = CAST(month(date_add('MONTH', -1, current_date)) AS varchar)))
          GROUP BY \"projects\".\"projectname\", \"projects\".\"awsaccountid\", \"projects\".\"accountname\", \"costs\".\"product_servicename\"
          ORDER BY \"project_name\" ASC, \"total_costs\" DESC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v7" {
  depends_on = [null_resource.v6] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"data_validity_list_not_tracked_exchange_rates_invoices\" AS 
          SELECT DISTINCT
            \"costs\".\"bill_invoice_id\" AS not_tracked_invoice_exchange_rate
          FROM
            \"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\")
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\"))
          WHERE ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"invoices\".\"rechnungsid\" IS NULL));" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v8" {
  depends_on = [null_resource.v7] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"data_validity_list_not_tracked_aws_accounts\" AS 
          SELECT DISTINCT
            \"costs\".\"line_item_usage_account_id\" AS not_assigned_aws_account
          FROM
            \"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\")
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\"))
          WHERE ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"projects\".\"awsaccountid\" IS NULL));" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v9" {
  depends_on = [null_resource.v8] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"data_validity_find_errors_in_projects_join\" AS 
          SELECT
            \"costs\".\"line_item_usage_account_id\",
            count(DISTINCT \"projects\".\"awsaccountid\") AS joined_entries_per_aws_account
          FROM
            \"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\")
          WHERE ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"costs\".\"line_item_usage_account_id\", \"costs\".\"month\", \"costs\".\"year\"
          HAVING (count(DISTINCT \"projects\".\"awsaccountid\") <> 1);" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v10" {
  depends_on = [null_resource.v9] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"data_validity_find_errors_in_invoices_join\" AS 
          SELECT
            \"costs\".\"line_item_usage_account_id\",
            \"costs\".\"bill_billing_entity\",
            count(DISTINCT \"invoices\".\"rechnungsid\") AS joined_entries_per_aws_account
          FROM
            \"cur4win\".\"ws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\"))
          WHERE ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"costs\".\"line_item_usage_account_id\", \"costs\".\"bill_billing_entity\", \"costs\".\"month\", \"costs\".\"year\"
          HAVING (count(DISTINCT \"invoices\".\"rechnungsid\") <> 1);" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v11" {
  depends_on = [null_resource.v10] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"data_validity_count_active_aws_accounts_last_month\" AS 
          SELECT count(DISTINCT line_item_usage_account_id) AS active_aws_accounts_last_month
          FROM
            cur4win.aws_foundation_billing_cur_athena
          WHERE ((year = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (month = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)));" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v12" {
  depends_on = [null_resource.v11] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs\" AS 
          SELECT
            projects.projectcostcenter AS cost_center,
            projects.projectjobnumber AS job_number,
            projects.projectname AS project_name,
            ROUND(SUM(line_item_unblended_cost), 2) AS total_costs,
            SUM(line_item_unblended_cost) AS unblended_cost,
            SUM(line_item_blended_cost) AS blended_cost,
            year,
            month
          FROM
            cur4win.aws_foundation_billing_cur_athena costs
            LEFT JOIN cur4win.projects_settings projects ON (costs.line_item_usage_account_id = projects.awsaccountid)
          WHERE ((NOT (line_item_line_item_type IN ('Tax', 'Credit'))) AND (year = CAST(year(date_add('MONTH', -1, current_date)) AS varchar)) AND (month = CAST(month(date_add('MONTH', -1, current_date)) AS varchar)))
          GROUP BY projects.projectname, projects.projectcostcenter, projects.projectjobnumber, year, month
          ORDER BY total_costs DESC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v13" {
  depends_on = [null_resource.v12]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_mainpayable_summary\" AS 
          SELECT
            \"bill_invoice_id\" AS \"AWS Rechnungsnummer \",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" <> 'Tax' AND \"line_item_line_item_type\" <> 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"AWS Kosten Gesamt (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Usage' AND \"projectjobnumber\" <> '') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Anteil Kosten Kundenprojekte (Netto)\",
            ROUND((ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Usage' AND \"projectjobnumber\" = '') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) + ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2)), 2) AS \"Anteil interne Projekte/Kosten (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Preisvorteil (Credits)\",
            ROUND(SUM((\"line_item_unblended_cost\" * \"exchange_rate\")), 2) AS \"AWS Überweisung (Brutto)\"
          FROM
            ((\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\"
          ORDER BY \"bill_invoice_id\" ASC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v14" {
  depends_on = [null_resource.v13]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_testaccount_summary\" AS 
          SELECT
            \"bill_invoice_id\" AS \"AWS Rechnungsnummer \",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" <> 'Tax' AND \"line_item_line_item_type\" <> 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"AWS Kosten Gesamt (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Usage' AND \"projectjobnumber\" <> '') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Anteil Kosten Kundenprojekte (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" <> 'Tax' AND \"line_item_line_item_type\" <> 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Anteil interne Projekte/Kosten (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Preisvorteil (Credits)\",
            ROUND(SUM((\"line_item_unblended_cost\" * \"exchange_rate\")), 2) AS \"AWS Überweisung (Brutto)\"
          FROM
            ((\"cur4win\".\"aws_foundation_billing_cur_athena_testaccount\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\"
          ORDER BY \"bill_invoice_id\" ASC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v15" {
  depends_on = [null_resource.v14]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_immersionday_summary\" AS 
          SELECT
            \"bill_invoice_id\" AS \"AWS Rechnungsnummer \",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" <> 'Tax' AND \"line_item_line_item_type\" <> 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"AWS Kosten Gesamt (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Usage' AND \"projectjobnumber\" <> '') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Anteil Kosten Kundenprojekte (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" <> 'Tax' AND \"line_item_line_item_type\" <> 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Anteil interne Projekte/Kosten (Netto)\",
            ROUND(SUM(CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN (\"line_item_unblended_cost\" * \"exchange_rate\") ELSE 0 END), 2) AS \"Preisvorteil (Credits)\",
            ROUND(SUM((\"line_item_unblended_cost\" * \"exchange_rate\")), 2) AS \"AWS Überweisung (Brutto)\"
          FROM
            ((\"cur4win\".\"aws_foundation_immersionday_cur\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\"
          ORDER BY \"bill_invoice_id\" ASC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v16" {
  depends_on = [null_resource.v15]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_total_summary\" AS 
          SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_immersionday_summary\"
          UNION SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_testaccount_summary\"
          UNION SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_mainpayable_summary\";" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v17" {
  depends_on = [null_resource.v16]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_with_exrate\" AS 
          SELECT
            \"bill_invoice_id\" AS \"RechnungsID\",
            SPLIT(\"projectjobnumber\", '.')[1] AS \"Jobnummer\",
            \"konto\" AS \"Konto\",
            (CASE WHEN REGEXP_LIKE(SPLIT(\"projectjobnumber\", '.')[1], '^[0-9]+$') THEN '10' ELSE NULL END) AS \"Position\",
            ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"Betrag $ Netto\",
            CAST(\"exchange_rate\" AS DOUBLE) AS \"Umrechnungskurs\",
            ROUND(SUM((CASE WHEN (\"line_item_line_item_type\" <> 'Tax') THEN (CAST(\"exchange_rate\" AS DOUBLE) * \"line_item_unblended_cost\") ELSE 0 END)), 2) AS \"Betrag € Netto\",
            \"uplift\" AS \"Aufschlag\",
            \"billable\" AS \"Verrechnung an Kunde\",
            \"projectlead\" AS \"Ansprechpartner 1\",
            \"projectdeputy\" AS \"Ansprechpartner 2\",
            \"projects\".\"projectname\" AS \"Projektbeschreibung\"
          FROM
            ((\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((NOT (\"costs\".\"line_item_line_item_type\" IN ('Tax', 'Credit'))) AND (\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\", \"projectjobnumber\", \"konto\", \"exchange_rate\", \"uplift\", \"billable\", \"projectlead\", \"projectdeputy\", \"projects\".\"projectname\"
          ORDER BY \"Betrag $ Netto\" DESC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v18" {
  depends_on = [null_resource.v17]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_immersionday_org\" AS 
          SELECT
            \"bill_invoice_id\" AS \"RechnungsID\",
            'KST 9242' AS \"Jobnummer\",
            '-' AS \"Konto\",
            '-' AS \"Position\",
            ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"Betrag $ Netto\",
            CAST(\"exchange_rate\" AS DOUBLE) AS \"Umrechnungskurs\",
            ROUND((CAST(\"exchange_rate\" AS DOUBLE) * SUM(\"line_item_unblended_cost\")), 2) AS \"Betrag € Netto\",
            '-' AS \"Aufschlag\",
            'No' AS \"Verrechnung an Kunde\",
            'melody.barth@gmail.com' AS \"Ansprechpartner 1\",
            'jana.strattner@gmail.com' AS \"Ansprechpartner 2\",
            'Central AWS Costcenter, Immersion Day' AS \"Projektbeschreibung\"
          FROM
            ((\"cur4win\".\"aws_foundation_immersionday_cur\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((NOT (costs.\"line_item_line_item_type\" IN ('Tax', 'Credit'))) AND (costs.\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (costs.\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\", \"exchange_rate\";" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v19" {
  depends_on = [null_resource.v18]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_main_payable\" AS 
          SELECT
            \"bill_invoice_id\" AS \"RechnungsID\",
            'KST 9242' AS \"Jobnummer\",
            '-' AS \"konto\",
            (CASE WHEN REGEXP_LIKE(SPLIT(\"projectjobnumber\", '.')[1], '^[0-9]+$') THEN '10' ELSE NULL END) AS \"Position\",
            (CASE WHEN REGEXP_LIKE(\"bill_invoice_id\", '^[a-zA-Z].*[0-9]$') THEN ROUND((SUM(\"line_item_unblended_cost\") + (SELECT ROUND(SUM((CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN \"line_item_unblended_cost\" ELSE 0 END)), 2)
              FROM
                ((\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
                LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
                LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
              WHERE
                ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
            )), 2) ELSE ROUND((CAST(\"exchange_rate\" AS DOUBLE) * SUM(\"line_item_unblended_cost\")), 2) END) AS \"Betrag $ Netto\",
            CAST(\"exchange_rate\" AS DOUBLE) AS \"Umrechnungskurs\",
            (CASE WHEN REGEXP_LIKE(\"bill_invoice_id\", '^[a-zA-Z].*[0-9]$') THEN ROUND(((CAST(\"exchange_rate\" AS DOUBLE) * SUM(\"line_item_unblended_cost\")) + (SELECT ROUND(SUM((CASE WHEN (\"line_item_line_item_type\" = 'Credit') THEN (\"line_item_unblended_cost\" * CAST(\"exchange_rate\" AS DOUBLE)) ELSE 0 END)), 2)
              FROM
                ((\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
                LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
                LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
              WHERE
                ((\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
            )), 2) ELSE ROUND((CAST(\"exchange_rate\" AS DOUBLE) * SUM(\"line_item_unblended_cost\")), 2) END) AS \"Betrag € Netto\",
            '-' AS \"Aufschlag\",
            'No' AS \"Verrechnung an Kunde\",
            'melody.barth@gmail.com' AS \"Ansprechpartner 1\",
            'jana.strattner@gmail.com' AS \"Ansprechpartner 2\",
            'Central AWS Costcenter, internal projects w/o JN' AS \"Projektbeschreibung\"
          FROM
            ((\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
            LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
            LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((\"projectjobnumber\" = '') AND (NOT (\"costs\".\"line_item_line_item_type\" IN ('Tax', 'Credit'))) AND (\"costs\".\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (\"costs\".\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\", \"costs\".\"year\", \"costs\".\"month\", \"projectjobnumber\", \"exchange_rate\"
          ORDER BY \"Betrag $ Netto\" DESC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v20" {
  depends_on = [null_resource.v19]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_test_org\" AS 
          SELECT
            \"bill_invoice_id\" AS \"RechnungsID\",
            'KST 9242' AS \"Jobnummer\",
            '-' AS \"Konto\",
            '-' AS \"Position\",
            ROUND(SUM(\"line_item_unblended_cost\"), 2) AS \"Betrag $ Netto\",
            CAST(\"exchange_rate\" AS DOUBLE) AS \"Umrechnungskurs\",
            ROUND((CAST(\"exchange_rate\" AS DOUBLE) * SUM(\"line_item_unblended_cost\")), 2) AS \"Betrag € Netto\",
            'ADD MANUALLY' AS \"Aufschlag\",
            'nein' AS \"Verrechnung an Kunde\",
            'jana.strattner@gmail.com' AS \"Ansprechpartner 1\",
            'jana.strattner@gmail.com' AS \"Ansprechpartner 2\",
            'Central AWS Costcenter, Test' AS \"Projektbeschreibung\"
          FROM
            ((\"cur4win\".\"aws_foundation_testorganisation_cur\" costs
              LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
              LEFT JOIN \"cur4win\".\"invoice_data\" invoices ON (((CAST(\"costs\".\"month\" AS VARCHAR) = CAST(\"invoices\".\"month\" AS VARCHAR)) AND (CAST(\"costs\".\"year\" AS VARCHAR) = CAST(\"invoices\".\"year\" AS VARCHAR))) AND (\"invoices\".\"rechnungsid\" = \"costs\".\"bill_invoice_id\")))
          WHERE
            ((NOT (costs.line_item_line_item_type IN ('Tax', 'Credit'))) AND (costs.\"year\" = CAST(YEAR(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)) AND (costs.\"month\" = CAST(MONTH(DATE_ADD('MONTH', -1, current_date)) AS VARCHAR)))
          GROUP BY \"bill_invoice_id\", \"exchange_rate\";" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v21" {
  depends_on = [null_resource.v20]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"last_month_project_costs_total\" AS
          SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_test_org\"
          UNION SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_main_payable\"
          UNION SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_immersionday_org\"
          UNION SELECT *
          FROM
            \"cur4win\".\"last_month_project_costs_with_exrate\"
          WHERE (\"jobnummer\" <> '')
          ORDER BY \"Betrag € Netto\" DESC;" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region ${var.region}
    EOT
  }
}

resource "null_resource" "v22" {
  depends_on = [null_resource.v21]

  provisioner "local-exec" {
    command = "sleep 5"
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_PROFILE=test-org aws athena start-query-execution \
        --query-execution-context Database=${var.gluedbname} \
        --query-string "CREATE OR REPLACE VIEW \"aws-f_project_costs_per_service_last_month\" AS 
        SELECT
          *,
          rank() OVER (PARTITION BY \"project_id\", \"type\", \"year_month\" ORDER BY \"total_costs\" DESC) rank
        FROM
          (
          SELECT
            \"projects\".\"projectidentifier\" \"project_id\",
            concat(\"year\", '-', lpad(\"month\", 2, '0')) \"year_month\",
            year,
            month,
            \"product_servicename\" \"service_name\",
            round(sum(\"line_item_unblended_cost\"), 2) \"total_costs\",
            \"projects\".\"projectname\" \"project_name\",
            \"projects\".\"cluster\",
            \"projects\".\"serviceunit\" \"service_unit\",
            \"projects\".\"businessarea\" \"business_area\",
            \"projects\".\"projectlead\" \"project_lead\",
            \"line_item_line_item_type\" \"type\",
            \"projects\".\"projectbudget\" \"budget\"
          FROM
            (\"cur4win\".\"aws_foundation_billing_cur_athena\" costs
          LEFT JOIN \"cur4win\".\"projects_settings\" projects ON (\"costs\".\"line_item_usage_account_id\" = \"projects\".\"awsaccountid\"))
          WHERE ((NOT (\"line_item_line_item_type\" IN ('Tax', 'Credit'))) AND (year = CAST(EXTRACT(YEAR FROM date_add('month', -1, date_trunc('month', current_date))) AS varchar)) AND (month = CAST(EXTRACT(MONTH FROM date_add('month', -1, date_trunc('month', current_date))) AS varchar)))
          GROUP BY \"projectidentifier\", \"bill_billing_period_start_date\", \"costs\".\"product_servicename\", \"projects\".\"projectname\", \"projects\".\"cluster\", \"projects\".\"serviceunit\", \"projects\".\"projectlead\", \"line_item_line_item_type\", \"year\", \"month\", \"projects\".\"projectbudget\", \"businessarea\"
          ORDER BY \"projects\".\"projectidentifier\" ASC
        )" \
        --result-configuration OutputLocation=s3://${var.bucket7}/ \
        --region eu-west-1
    EOT
  }
}