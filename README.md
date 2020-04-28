
1. Starting AWS EKS cluster manually in AWS web console
### 1. EKS cluster costs few cents per hour
### 2. Allow seeing billing data for IAM user 
### 3. Create budget in AWS to be notified by email
### 4. Create an extra user and group in AWS with admin privilages
### 5. Install awscli and kubectl binaries
### 6. Retrive programatic access from AWS
### 7. Create EKS control plane IAM role in AWS web console
### 8. Create EKS node group  IAM role in AWS web console
### 9. Create EKS cluster in AWS web console
### 10. Create EKS node group in AWS web console
### 11. Create KUBECONFIG at your local
### 12. First NGINX deployment by kubectl to AWS EKS cluster created manually

2. Using terrafrom to manage AWS EKS cluster
### 13. Install terrafrom binary at your local
### 14. Run terrafrom init and validate to initialize required plugins
### 15. Fill up terraform.eks.tfvars file with your AWS security credentials
### 16. Run terrafrom plan and terrafrom apply
### 17. Run terraform apply uncomment iam.tf to create mandatory AWS IAM roles 
### 18. Run terraform apply uncomment sg.tf to create mandatory Security Group 
### 19. Run terraform apply uncomment subnets.tf to create Subnets in AWS 
### 20. Run terraform apply uncomment aws_eks_cluster in main.tf to create AWS EKS cluster control plane
### 21. Run terraform apply uncomment aws_eks_node_group in main.tf to create AWS EKS node group
### 22. Explore terrafrom console commands with custom tags variable
### 23. First NGINX deployment by kubectl to AWS EKS cluster created by terraform
### 24. How to destroy AWS EKS by terrafrom destroy

3. Helm charts
### 25. Install helm v3 and helmfile binaries
### 26. Create your own NGINX helm chart
### 27. Deploy NGINX helm chart via helm v3
### 28. Deploy PostgreSQL helm chart from stable helm chart repository
### 29. Self written micro backend helm chart
### 30. Self written micro frontend helm chart
### 31. Nginx ingress controller helm chart
### 32. Creating own helm chart repository from Github account
### 32. Creating own helm chart repository from Chartmuseum



### How to create KUBECONFIG for EKS cluster
```bash
aws eks --region eu-central-1 update-kubeconfig --name diu-eks-cluster
```

### How to test cluster by running PostgreSQL deployment via helmfile

Export variables
```bash
export HC_ALLOWED_IPS="172.31.0.0/16"
export HC_DB="microservice"
export HC_DB_USER="micro"
export HC_DB_PASS="password"
export HC_MASTER_DB_PASS="password"
export HC_MASTER_DB_USER="postgres"
```

Template your deployment first
```bash
helmfile -f helmfile-postgresql.yaml template
```

Execute PostgreSQL deployment
```bash
helmfile -f helmfile-postgresql.yaml sync
```

Test your AWS PostgreSQL deployment
```bash
kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace default --image "docker.io/bitnami/postgresql:11.7.0-debian-10-r82" --env="PGPASSWORD=password" --command -- psql --host postgresql -U micro -d microservice -p 5432                                                        

If you don't see a command prompt, try pressing enter.

microservice=> 
microservice=> 
microservice=> 
microservice=> 

```


