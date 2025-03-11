# Cost-Allocation-Automation

# General overview
The Cost Dashboarding serves as the backbone of our cost management strategy. It complements Cost Automation, which aims to automate cost factors such as individual account costs and total costs for various accounts, sending this information to relevant colleagues in the form of an Excel file to facilitate efficient invoicing and avoid manual cost calculations.

# High level Architecture
According to the architecture outlined below, Terraform will deploy the resources in the Main_Account account through
AWS CodePipeline.
![Cost-Infra-1](https://github.com/user-attachments/assets/586c1ce1-c3c7-435d-a2cb-be00f960a3bd)

# Code folder structure snippet
Infrastructure-as-Code (IaC) is being used to design and deploy this infrastructure on AWS. Additionally, Continuous Integration/Continuous Deployment
(CI/CD) pipelines are necessary for the deployment of infrastructure.

![image](https://github.com/user-attachments/assets/3f856b84-95bc-4282-8090-fb8cb3b1e186)
