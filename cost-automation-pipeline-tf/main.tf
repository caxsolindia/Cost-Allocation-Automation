# Tflint Build Role script 020526017978

data "aws_iam_policy_document" "tflint_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tflint_role" {
  name               = "cost_tflint_codebuild_role"
  assume_role_policy = data.aws_iam_policy_document.tflint_assume_role.json
}

resource "aws_iam_policy" "tflint_policy" {
  name        = "cost_tflint_codebuild_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_tflint_build",
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_tflint_build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::cost-automation-tfpipeline*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:eu-west-1:020526017978:cost-automation-terraform"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:eu-west-1:020526017978:report-group/cost_tflint_build-*"
            ]
        }
    ]
  })
}

resource "aws_iam_policy_attachment" "tflint_attach_policy" {
  name       = "tflint_a_policy"
  roles      = [aws_iam_role.tflint_role.name]
  policy_arn = aws_iam_policy.tflint_policy.arn
}

resource "aws_codebuild_project" "tflint_build" {
  name          = "cost_tflint_build"
  description   = "cost_tflint_codebuild_project"
  build_timeout = 5
  service_role  = aws_iam_role.tflint_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  
  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/cost-automation-terraform"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

  # Specify the buildspec directly within the source block
  buildspec = <<EOF
    version: 0.2

    phases:
      install:
        commands:
          - wget https://github.com/terraform-linters/tflint/releases/latest/download/tflint_linux_amd64.zip 
          - unzip tflint_linux_amd64.zip 
          - sudo mv tflint /usr/local/bin/ 
          - tflint --version 

      pre_build:
        commands:
          - echo "Installing Terraform"
          - curl -LO https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip
          - unzip terraform_1.6.3_linux_amd64.zip
          - sudo mv terraform /usr/local/bin/
          - terraform --version
          - echo "Terraform installed successfully"

      build:
        commands:
          - tflint
    EOF
}
}

# Checkov Build Role script

data "aws_iam_policy_document" "checkov_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "checkov_role" {
  name               = "cost_checkov_codebuild_role"
  assume_role_policy = data.aws_iam_policy_document.checkov_assume_role.json
}

resource "aws_iam_policy" "checkov_policy" {
  name        = "cost_checkov_codebuild_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_checkov_build",
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_checkov_build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::cost-automation-tfpipeline*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:eu-west-1:020526017978:cost-automation-terraform"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:eu-west-1:020526017978:report-group/cost_checkov_build-*"
            ]
        }
    ]
  })
}

resource "aws_iam_policy_attachment" "checkov_attach_policy" {
  name       = "checkov_a_policy"
  roles      = [aws_iam_role.checkov_role.name]
  policy_arn = aws_iam_policy.checkov_policy.arn
}

resource "aws_codebuild_project" "checkov_build" {
  name          = "cost_checkov_build"
  description   = "cost_checkov_codebuild_project"
  build_timeout = 5
  service_role  = aws_iam_role.checkov_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  
  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/cost-automation-terraform"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

  # Specify the buildspec directly within the source block
  buildspec = <<EOF
    version: 0.2

    phases:
      install:
        runtime-versions:
          python: 3.11  # Update the Python version to 3.11
        commands:
          - apt-get update
          - apt-get install -y python3-pip
          - pip3 install checkov

      pre_build:
        commands:
          - echo "Installing Terraform"
          - wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
          - unzip terraform_0.14.7_linux_amd64.zip
          - mv terraform /usr/local/bin/
          - rm terraform_0.14.7_linux_amd64.zip
          - terraform --version
          - echo "Terraform installed successfully"

      build:
        commands:
          - echo "Executing Checkov for Terraform code"
          - checkov -d . --soft-fail
    EOF
}
}

# Terraform Plan Build Role script

data "aws_iam_policy_document" "terraformplan_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "terraformplan_role" {
  name               = "cost_terraformplan_codebuild_role"
  assume_role_policy = data.aws_iam_policy_document.terraformplan_assume_role.json
}

resource "aws_iam_policy" "terraformplan_policy" {
  name        = "cost_terraformplan_codebuild_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_tf_plan_build",
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_tf_plan_build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::cost-automation-tfpipeline*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:eu-west-1:020526017978:cost-automation-terraform"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:eu-west-1:020526017978:report-group/cost_tf_plan_build-*"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "secretmanagerpolicy" {
  name        = "cost_secretmanagerpolicy"
  path        = "/"
  description = "My secretmanagerpolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Resource": "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS"
        }
    ]
  })
}

resource "aws_iam_policy_attachment" "terraformplan_attach_policy" {
  name       = "terraformplan_a_policy"
  roles      = [aws_iam_role.terraformplan_role.name]
  policy_arn = aws_iam_policy.terraformplan_policy.arn
}

resource "aws_iam_policy_attachment" "terraformplan_attach_policy1" {
  name       = "terraformplan_a_policy1"
  roles      = [aws_iam_role.terraformplan_role.name]
  policy_arn = aws_iam_policy.secretmanagerpolicy.arn
}

resource "aws_codebuild_project" "terraformplan_build" {
  name          = "cost_tf_plan_build"
  description   = "cost_terraformplan_codebuild_project"
  build_timeout = 5
  service_role  = aws_iam_role.terraformplan_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  
  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/cost-automation-terraform"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

  # Specify the buildspec directly within the source block
  buildspec = <<EOF

    version: 0.2
    
    env:
      secrets-manager:
        SECRET_VALUE:  "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-test-org"
        SECRET_VALUE1: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-test-org"
        SECRET_VALUE2: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-mainpayable-accounta"
        SECRET_VALUE3: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-mainpayable-accounta"
        SECRET_VALUE4: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-org-master-accountb"
        SECRET_VALUE5: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-org-master-accountb"
        SECRET_VALUE6: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-immersion-day-main-accountc"
        SECRET_VALUE7: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-immersion-day-main-accountc"
    
    phases:
      pre_build:
        commands:
          - echo "Setting up AWS credentials"
          - echo "Setting up AWS credentials for Main Account"
          - aws configure set aws_access_key_id $SECRET_VALUE --profile test-org
          - aws configure set aws_secret_access_key $SECRET_VALUE1 --profile test-org

          - echo "Setting up AWS credentials for Accounta Account"
          - aws configure set aws_access_key_id $SECRET_VALUE2 --profile mainpayable-accounta
          - aws configure set aws_secret_access_key $SECRET_VALUE3 --profile mainpayable-accounta

          - echo "Setting up AWS credentials for Accountb Account"
          - aws configure set aws_access_key_id $SECRET_VALUE4 --profile org-master-accountb
          - aws configure set aws_secret_access_key $SECRET_VALUE5 --profile org-master-accountb

          - echo "Setting up AWS credentials for Accountc Account"
          - aws configure set aws_access_key_id $SECRET_VALUE6 --profile immersion-day-main-accountc
          - aws configure set aws_secret_access_key $SECRET_VALUE7 --profile immersion-day-main-accountc

          - aws configure set default.region eu-west-1 --profile test-org
          - aws configure set default.region us-east-1 --profile mainpayable-accounta
          - aws configure set default.region us-east-1 --profile org-master-accountb
          - aws configure set default.region us-east-1 --profile immersion-day-main-accountc
    
      build:
        commands:
          - echo "Installing Terraform"
          - curl -LO https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
          - unzip terraform_1.5.6_linux_amd64.zip
          - mv terraform /usr/local/bin/
          - terraform --version
          - echo "Running Terraform commands"
          - cd .
          - terraform init
          - terraform validate
          - terraform plan
    EOF
}
}

# Terraform Apply Build Role script

data "aws_iam_policy_document" "terraformapply_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "terraformapply_role" {
  name               = "cost_terraformapply_codebuild_role"
  assume_role_policy = data.aws_iam_policy_document.terraformapply_assume_role.json
}

resource "aws_iam_policy" "terraformapply_policy" {
  name        = "cost_terraformapply_codebuild_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_tf_apply_build",
                "arn:aws:logs:eu-west-1:020526017978:log-group:/aws/codebuild/cost_tf_apply_build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::cost-automation-tfpipeline*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:eu-west-1:020526017978:cost-automation-terraform"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:eu-west-1:020526017978:report-group/cost_tf_apply_build-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Resource": "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS"
        }
    ]
  })
}

resource "aws_iam_policy_attachment" "terraformapply_attach_policy" {
  name       = "terraformapply_a_policy"
  roles      = [aws_iam_role.terraformapply_role.name]
  policy_arn = aws_iam_policy.terraformapply_policy.arn
}

resource "aws_codebuild_project" "terraformapply_build" {
  name          = "cost_tf_apply_build"
  description   = "terraformapply_codebuild_project"
  build_timeout = 10
  service_role  = aws_iam_role.terraformapply_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  
  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/cost-automation-terraform"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

  # Specify the buildspec directly within the source block
  buildspec = <<EOF
  
    version: 0.2
    
    env:
      secrets-manager:
        SECRET_VALUE:  "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-test-org"
        SECRET_VALUE1: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-test-org"
        SECRET_VALUE2: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-mainpayable-accounta"
        SECRET_VALUE3: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-mainpayable-accounta"
        SECRET_VALUE4: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-org-master-accountb"
        SECRET_VALUE5: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-org-master-accountb"
        SECRET_VALUE6: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:ak-immersion-day-main-accountc"
        SECRET_VALUE7: "arn:aws:secretsmanager:eu-west-1:020526017978:secret:cost-automation-pipeline-c5DGnS:sk-immersion-day-main-accountc"
    
    phases:
      pre_build:
        commands:
          - echo "Setting up AWS credentials"
          - echo "Setting up AWS credentials for Main Account"
          - aws configure set aws_access_key_id $SECRET_VALUE --profile test-org
          - aws configure set aws_secret_access_key $SECRET_VALUE1 --profile test-org

          - echo "Setting up AWS credentials for Accounta Account"
          - aws configure set aws_access_key_id $SECRET_VALUE2 --profile mainpayable-accounta
          - aws configure set aws_secret_access_key $SECRET_VALUE3 --profile mainpayable-accounta

          - echo "Setting up AWS credentials for Accountb Account"
          - aws configure set aws_access_key_id $SECRET_VALUE4 --profile org-master-accountb
          - aws configure set aws_secret_access_key $SECRET_VALUE5 --profile org-master-accountb

          - echo "Setting up AWS credentials for Accountc Account"
          - aws configure set aws_access_key_id $SECRET_VALUE6 --profile immersion-day-main-accountc
          - aws configure set aws_secret_access_key $SECRET_VALUE7 --profile immersion-day-main-accountc

          - aws configure set default.region eu-west-1 --profile test-org
          - aws configure set default.region us-east-1 --profile mainpayable-accounta
          - aws configure set default.region us-east-1 --profile org-master-accountb
          - aws configure set default.region us-east-1 --profile immersion-day-main-accountc
    
      build:
        commands:
          - echo "Installing Terraform"
          - curl -LO https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
          - unzip terraform_1.5.6_linux_amd64.zip
          - mv terraform /usr/local/bin/
          - terraform --version
          - echo "Running Terraform commands"
          - cd .
          - terraform init
          - terraform plan
          - terraform apply -auto-approve

      post_build:
        commands:
          - echo "Deploying infrastructure"
    EOF
}
}

# Code Pipeline terraform script

data "aws_iam_policy_document" "assume_role1" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example1" {
  name               = "cost_codepipeline_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role1.json
}

resource "aws_iam_policy" "policy1" {
  name        = "cost_codepipeline_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Statement": [
        {
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEqualsIfExists": {
                    "iam:PassedToService": [
                        "cloudformation.amazonaws.com",
                        "elasticbeanstalk.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Action": [
                "codecommit:CancelUploadArchive",
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:GetRepository",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:UploadArchive"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codestar-connections:UseConnection"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "elasticbeanstalk:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "cloudwatch:*",
                "s3:*",
                "sns:*",
                "cloudformation:*",
                "rds:*",
                "sqs:*",
                "ecs:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "lambda:InvokeFunction",
                "lambda:ListFunctions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "opsworks:CreateDeployment",
                "opsworks:DescribeApps",
                "opsworks:DescribeCommands",
                "opsworks:DescribeDeployments",
                "opsworks:DescribeInstances",
                "opsworks:DescribeStacks",
                "opsworks:UpdateApp",
                "opsworks:UpdateStack"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "cloudformation:CreateStack",
                "cloudformation:DeleteStack",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "cloudformation:CreateChangeSet",
                "cloudformation:DeleteChangeSet",
                "cloudformation:DescribeChangeSet",
                "cloudformation:ExecuteChangeSet",
                "cloudformation:SetStackPolicy",
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild",
                "codebuild:BatchGetBuildBatches",
                "codebuild:StartBuildBatch"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "devicefarm:ListProjects",
                "devicefarm:ListDevicePools",
                "devicefarm:GetRun",
                "devicefarm:GetUpload",
                "devicefarm:CreateUpload",
                "devicefarm:ScheduleRun"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "servicecatalog:ListProvisioningArtifacts",
                "servicecatalog:CreateProvisioningArtifact",
                "servicecatalog:DescribeProvisioningArtifact",
                "servicecatalog:DeleteProvisioningArtifact",
                "servicecatalog:UpdateProduct"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeImages"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "states:DescribeExecution",
                "states:DescribeStateMachine",
                "states:StartExecution"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "appconfig:StartDeployment",
                "appconfig:StopDeployment",
                "appconfig:GetDeployment"
            ],
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
  })
}

resource "aws_iam_policy_attachment" "lambda_execution_policy_get1" {
  name       = "lambda_execution_policy_get1"
  roles      = [aws_iam_role.example1.name]
  policy_arn = aws_iam_policy.policy1.arn
}

resource "aws_s3_bucket" "example" {
  bucket = "cost-automation-tfpipeline-artifacts"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "cost-automation-tfpipeline"
  role_arn = aws_iam_role.example1.arn

  artifact_store {
    location = "cost-automation-tfpipeline-artifacts"
    type     = "S3"
  }


  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "cost-automation-terraform"
        BranchName     = "master"
      }
    }
  }


  stage {
    name = "Tflint_Scan"

    action {
      name             = "Tflint_Scan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "cost_tflint_build"
      }
    }
  }

  stage {
    name = "Checkov_Scan"

    action {
      name             = "Checkov_Scan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output1"]
      version          = "1"

      configuration = {
        ProjectName = "cost_checkov_build"
      }
    }
  }


  stage {
    name = "Terraform_Plan"

    action {
      name             = "Terraform_Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output2"]
      version          = "1"

      configuration = {
        ProjectName = "cost_tf_plan_build"
      }
    }
  }

 stage {
    name = "ManualApproval"

    action {
      name             = "ManualApproval"
      category         = "Approval"
      owner            = "AWS"
      provider         = "Manual"
      input_artifacts  = []
      output_artifacts = []
      version          = "1"

      configuration = {
        NotificationArn = "arn:aws:sns:eu-west-1:020526017978:cost-sns"
      }
    }
  }

 stage {
    name = "Terraform_Apply"

    action {
      name             = "Terraform_Apply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output3"]
      version          = "1"

      configuration = {
        ProjectName = "cost_tf_apply_build"
      }
    }
  }

}

# SNS

resource "aws_sns_topic" "sns_topic" {
  name = "cost-sns"
  display_name = "COST-AUTOMATION-PIPELINE-APPROVAL"
}

resource "aws_sns_topic_subscription" "email-notification" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "net.pavan.hc@gmail.com"
}
