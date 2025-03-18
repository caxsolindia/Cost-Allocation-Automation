# Cost-Allocation-Automation

# General overview
The Cost Dashboarding serves as the backbone of our cost management strategy. It complements Cost Automation, which aims to automate cost factors such as individual account costs and total costs for various accounts, sending this information to relevant colleagues in the form of an Excel file to facilitate efficient invoicing and avoid manual cost calculations.

# High level Architecture
For the Cost Dashboarding of projects within the AWS Foundation of MHP, the AWS CUR (Cost and Usage Report) is utilized to obtain detailed information about the usage of AWS and the associated costs for each account. This information is stored in an S3 bucket named CUR Bucket. To ensure data currency, a crawler is triggered monthly to retrieve and update the data from the respective buckets.

Subsequently, the crawler searches through the data. The obtained information, including the data structure and metadata is stored in the central metadata repository, the AWS Glue Data Catalog. Additionally, the billing information and project data buckets are searched and their metadata is also stored in the AWS Glue Data Catalog. The Project Data bucket contains all relevant information about ongoing projects at the AWS Foundation of MHP that utilize cloud services. Data from various buckets (Exchange Rate, Project Data, and CUR Bucket) is extracted and linked together in the catalog.

The project data flows from DynamoDB through the API Gateway and via a Lambda function that formats the data into a flattened JSON format into the Project Data bucket. The Lambda function is triggered once a month to transfer the data from DynamoDB into the Project Data bucket. Subsequently, the architecture diagram will provide an overview of the Cost Dashboarding process.

According to the architecture outlined below, Terraform will deploy the resources in the Main_Account account through
AWS CodePipeline.
![Cost-Infra-Page-7](https://github.com/user-attachments/assets/3b1c3df1-a23f-4ece-8bef-70ca3b477c42)


# Code folder structure snippet
Infrastructure-as-Code (IaC) is being used to design and deploy this infrastructure on AWS. Additionally, Continuous Integration/Continuous Deployment
(CI/CD) pipelines are necessary for the deployment of infrastructure.

The solution is designed around users storing Terraform assets within an AWS CodeCommit repository. Commits to this repository will trigger an AWS CodePipeline pipeline which will scan the code for security vulnerabilities, before deploying the project into the AWS account.

```bash
cost-automation-pipeline-tf/
├── main.tf
├── provider.tf
cost-automation-terraform/
├── account-a/
├── account-b/
├── module/
│   ├── cost-automation/
│   │   ├── lambda_function.zip
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── projectdata_dynamodb.py
│   │   └── variable.tf  
├── .tflint.hcl
├── main.tf
├── provider.tf
├── terraform.tfvars
└── variable.tf
```

# Solution details and Git repository structure

## The main infrastructure code - cost-automation-terraform/

The directory cost-automation-terraform/ contains the main infrastructure code, AWS resources. The workflow of these resources is:

  - first deploy them to a dev environment, then verify that they were deployed correctly in the dev environment

## Terraform backend - providers.tf file

In order to use Terraform, Terraform backend must be set up. For this solution the S3 Terraform backend was chosen. This means that an S3 bucket and a DynamoDB table have to be created. There are many ways of creating these 2 resources. In this solution it was decided to use Terraform with local backend to set up the S3 Terraform backend. The code needed to set up the S3 backend is kept in the providers.tf/ file.

## CICD pipeline - cost-automation-terraform-pipeline/

In order to be able to use a CICD pipeline to deploy the main infrastructure code, a pipeline has to be defined and deployed. In this solution, AWS CodePipeline and AWS CodeBuild are used to provide the CICD pipeline capabilities. The AWS CodePipeline pipeline and AWS CodeBuild projects are deployed also using Terraform. The Terraform code is kept in the cost-automation-terraform-pipeline/ directory. Have also used tf_lint and checkov to run statics checks.

# Summary

In summary, there are 2 directories with Terraform files. Thanks to that, deploying this solution:

- is automated

- is done in an idempotent way (meaning - you can run this deployment multiple times and expect the same effect)
can be reapplied in a case of configuration drift

The process of deploying this solution involves these steps:

  - Set up access to AWS Management Console and to AWS CLI.

  - Create an AWS CodeCommit git repository and upload code to it.

  - Set up Terraform backend.

  - Deploy a CICD pipeline (using mhp-cost-automation-terraform-pipeline/ directory).

  - Deploy the main infrastructure code (using mhp-cost-automation-terraform/ directory).


