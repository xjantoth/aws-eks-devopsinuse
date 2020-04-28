
1. Starting AWS EKS cluster manually in AWS web console
### 1. EKS cluster costs few cents per hour

### 2. Allow seeing billing data for IAM user

* Login to your **root** AWS account in **AWS Free Tier**.<br/>
* The access to a **billing information** is **disabled** by default for **IAM accounts**

![](img/allow-billing-in-root-account-0.png)

* **Input user/password** from your phone to authenticate and login to the **root** account.<br/> 

![](img/allow-billing-in-root-account-1.png)

* **Input MFA code** from your phone to authenticate and login to the **root** account.<br/> 

![](img/allow-billing-in-root-account-2.png)

* Click at **My Account** item from **drop down menu**

![](img/billing-permissions-0.png)

* Click **Edit** to allow - ***Activate IAM Access*** for other IAM accounts than root account.

![](img/billing-permissions-1.png)

* Hit **Update** button to take ***Activate IAM Access*** for other IAM accounts than root account.

![](img/billing-permissions-2.png)

### 3. Create budget in AWS to be notified by email

![](img/budget-1.png)

![](img/budget-2.png)

![](img/budget-3.png)

![](img/budget-4.png)

![](img/budget-5.png)

![](img/budget-6.png)

![](img/budget-7.png)

![](img/budget-8.png)

### 4. Create an extra user and group in AWS with admin privilages

![](img/create-iam-1.png)

![](img/create-iam-2.png)

![](img/create-iam-3.png)

![](img/create-iam-4.png)

![](img/create-iam-5.png)

![](img/create-iam-6.png)

![](img/create-iam-7.png)

![](img/create-iam-8.png)




### 6. Install awscli and kubectl binaries
### 7. Retrive programatic access from AWS
### 8. Create EKS control plane IAM role in AWS web console
### 9. Create EKS node group  IAM role in AWS web console
### 10. Create EKS cluster in AWS web console
### 11. Create EKS node group in AWS web console
### 12. Create KUBECONFIG at your local
### 13. First NGINX deployment by kubectl to AWS EKS cluster created manually

2. Using terrafrom to manage AWS EKS cluster
### 14. Install terrafrom binary at your local
### 15. Run terrafrom init and validate to initialize required plugins
### 16. Fill up terraform.eks.tfvars file with your AWS security credentials
### 17. Run terrafrom plan and terrafrom apply
### 18. Run terraform apply uncomment iam.tf to create mandatory AWS IAM roles 
### 19. Run terraform apply uncomment sg.tf to create mandatory Security Group 
### 20. Run terraform apply uncomment subnets.tf to create Subnets in AWS 
### 21. Run terraform apply uncomment aws_eks_cluster in main.tf to create AWS EKS cluster control plane
### 22. Run terraform apply uncomment aws_eks_node_group in main.tf to create AWS EKS node group
### 23. Explore terrafrom console commands with custom tags variable
### 24. First NGINX deployment by kubectl to AWS EKS cluster created by terraform
### 25. How to destroy AWS EKS by terrafrom destroy

3. Helm charts
### 26. Install helm v3 and helmfile binaries
### 27. Create your own NGINX helm chart
### 28. Deploy NGINX helm chart via helm v3
### 29. Deploy PostgreSQL helm chart from stable helm chart repository
### 30. Self written micro backend helm chart
### 31. Self written micro frontend helm chart
### 32. Nginx ingress controller helm chart
### 33. Creating own helm chart repository from Github account
### 33. Creating own helm chart repository from Chartmuseum



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


