# B/G Deployment - AWS Code Deploy

This sample terraform code creates ALB, TG's, Fargate ECS Cluster and Code Deploy components 

## Pre-Requisites

```bash
1. Terraform v0.12
2. AWS Acccount Credentials and Backend S3 for state store
3. ECR repository 
4. Docker Images with two flavours for B/G deployment
5. Update the variables file with ECR repo name etc
6. Update the task-definitions/web_services.json file as required

```

## Usage

```python
1. Once the resources are created, you can go to ECS Fargate service
2. Proceed for service update, this displays the steps to initiate the AWS code deployment 
3. You can test by re-routing traffic to B/G setup manually and complete the change
4. This terraform code ignores the chagnes we do on code deploy using lifecycle meta on Listener, ecs service etc.
```

