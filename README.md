
**Starting AWS EKS cluster manually in AWS web console**
 - [1. EKS cluster costs few cents per hour](#1-eks-cluster-costs-few-cents-per-hour)
 - [2. Allow seeing billing data for IAM user](#2-allow-seeing-billing-data-for-iam-user)
 - [3. Create budget in AWS to be notified by email](#3-create-budget-in-aws-to-be-notified-by-email)
 - [4. Create an extra user and group in AWS with admin privilages](#4-create-an-extra-user-and-group-in-aws-with-admin-privilages)
 - [5. Install awscli and kubectl binaries](#5-install-awscli-and-kubectl-binaries)
 - [6. Retrive programatic access from AWS and configure aws cli](#6-retrive-programatic-access-from-aws-and-configure-aws-cli)
 - [7. Create EKS control plane IAM role in AWS web console](#7-create-eks-control-plane-iam-role-in-aws-web-console)
 - [8. Create EKS node group IAM role in AWS web console](#8-create-eks-node-group-iam-role-in-aws-web-console)


 - [9. Create EKS cluster in AWS web console](#9-create-eks-cluster-in-aws-web-console)
 - [10. Create EKS node group in AWS web console](#10-create-eks-node-group-in-aws-web-console)
 - [11. Create KUBECONFIG at your local](#11-create-kubeconfig-at-your-local)
 - [12. First NGINX deployment by kubectl to AWS EKS cluster created manually](#12-first-nginx-deployment-by-kubectl-to-aws-eks-cluster-created-manually)

TODO: add leacture on ssh key pair <br/>
TODO: clean up

<!-- - [1. EKS cluster costs few cents per hour](#1-eks-cluster-costs-few-cents-per-hour)-->
### 1. EKS cluster costs few cents per hour

<!-- - [2. Allow seeing billing data for IAM user](#2-allow-seeing-billing-data-for-iam-user)-->
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

<!-- - [3. Create budget in AWS to be notified by email](#3-create-budget-in-aws-to-be-notified-by-email)-->
### 3. Create budget in AWS to be notified by email

![](img/budget-1.png)

![](img/budget-2.png)

![](img/budget-3.png)

![](img/budget-4.png)

![](img/budget-5.png)

![](img/budget-6.png)

![](img/budget-7.png)

![](img/budget-8.png)

<!-- - [4. Create an extra user and group in AWS with admin privilages](#4-create-an-extra-user-and-group-in-aws-with-admin-privilages)-->
### 4. Create an extra user and group in AWS with admin privilages

![](img/create-iam-1.png)

![](img/create-iam-2.png)

![](img/create-iam-3.png)

![](img/create-iam-4.png)

![](img/create-iam-5.png)

![](img/create-iam-6.png)

![](img/create-iam-7.png)

![](img/create-iam-8.png)



<!-- - [5. Install awscli and kubectl binaries](#5-install-awscli-and-kubectl-binaries)-->
### 5. Install awscli and kubectl binaries

* **Install** awscli binary
https://docs.aws.amazon.com/cli/latest/userguide/install-linux-al2017.html

* Please **configure** these two files:
  - ~/.aws/credentials
  - ~/.aws/config


![](img/aws-cli-1.png)

Link: https://kubernetes.io/docs/tasks/tools/install-kubectl/

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client
```
![](img/kubectl-1.png)

<!-- - [6. Retrive programatic access from AWS and configure aws cli](#7-retrive-programatic-access-from-aws-and-configure-aws-cli)-->
### 6. Retrive programatic access from AWS and configure aws cli

![](img/aws-cli-2.png)

![](img/aws-cli-3.png)

![](img/aws-cli-4.png)


**edit file:** `~/.aws/credentials`
```bash
vim  ~/.aws/credentials

...
[terraform]
aws_access_key_id = ...
aws_secret_access_key = ...

[devopsinuse]
aws_access_key_id = ...
aws_secret_access_key = ...
...

:wq!
```

**edit file:** `~/.aws/config`

```bash
vim ~/.aws/config

...
[profile terraform]
region=eu-central-1

[profile devopsinuse]
region=eu-central-1
...

:wq!
```

**Make sure** that your `aws` is configured correctly and can talk to AWS
```bash
aws iam list-users --profile devopsinuse
{
    "Users": [
        {
            "Path": "/",
            "UserName": "devopsinuse",
            "UserId": "AFSDFSDFSDFSDFSD",
            "Arn": "arn:aws:iam::61111111116:user/devopsinuse",
            "CreateDate": "2020-04-20T08:03:36Z",
            "PasswordLastUsed": "2020-04-28T18:25:07Z"
        },
        {
            "Path": "/",
            "UserName": "terraform",
            "UserId": "ADSGDSDASDASFSDFSDB",
            "Arn": "arn:aws:iam::61111111116:user/terraform",
            "CreateDate": "2020-04-28T10:24:32Z"
        }
    ]
}
```
<!-- - [7. Create EKS control plane IAM role in AWS web console](#7-create-eks-control-plane-iam-role-in-aws-web-console)-->
### 7. Create EKS control plane IAM role in AWS web console

![](img/eks-iam-cluster-role-1.png)

![](img/eks-iam-cluster-role-2.png)

![](img/eks-iam-cluster-role-3.png)

![](img/eks-iam-cluster-role-4.png)

![](img/eks-iam-cluster-role-5.png)

![](img/eks-iam-cluster-role-6.png)

![](img/eks-iam-cluster-role-7.png)


<!-- - [8. Create EKS node group IAM role in AWS web console](#8-create-eks-node-group-iam-role-in-aws-web-console)-->
### 8. Create EKS node group IAM role in AWS web console

Find **Roles** section under ***Identity and Access Management (IAM)***

![](img/eks-iam-cluster-role-1.png)

Click at ***EC2*** from *Choose a use case* menu when creating AWS IAM role for ***EKS node group***

![](img/eks-iam-node-group-1.png)


**Search manually** for these **3 policies** for **EKS node group** and 
mark then once found in **checkbox**
* *AmazonEC2ContainerRegistryReadOnly*

![](img/eks-iam-node-group-2.png)

**Search manually** for these **3 policies** for **EKS node group** and 
mark then once found in **checkbox**
* *AmazonEKSWorkerNodePolicy*

![](img/eks-iam-node-group-3.png)

**Search manually** for these **3 policies** for **EKS node group** and 
mark then once found in **checkbox**
* *AmazonEKS_CNI_Policy*

This time you can ***click: Next: Tags*** blue button if all **three** *IAM Policies* are **check-boxed**

![](img/eks-iam-node-group-4.png)

**Tags are optional** however, they help to identify leftovers once you want to clean your AWS account

![](img/eks-iam-node-group-5.png)


**Review** your AWS IAM role and assign some **Role name** to it ***e.g. DIU-EKSNodeGroupRole***

![](img/eks-iam-node-group-6.png)

Role ***DIU-EKSNodeGroupRole*** is finally created

![](img/eks-iam-node-group-7.png)


<!-- - [9. Create SSH key pain in AWS console](#9-create-ssh-key-pain-in-aws-console)-->
### 9. Create SSH key pain in AWS console

![](img/ssh-keys-1.png)

![](img/ssh-keys-2.png)

![](img/ssh-keys-3.png)


![](img/sg-3.png)

SSH tunnel approach without the need to seup Security group in AWS

```bash
ssh -o "IdentitiesOnly yes" \
-i  ~/.ssh/devopsinuse.pem \ 
ec2-user@35.157.105.203 \
-L30111:127.0.0.1:30111
```
![](img/ssh-keys-4.png)

<!-- - [10. Create EKS cluster in AWS web console](#10-create-eks-cluster-in-aws-web-console)-->
### 10. Create EKS cluster in AWS web console

![](img/eks-control-plane-1.png)

![](img/eks-control-plane-2.png)

![](img/eks-control-plane-3.png)

![](img/eks-control-plane-4.png)

![](img/eks-control-plane-5.png)

![](img/eks-control-plane-6.png)


<!-- - [11. Create EKS node group in AWS web console](#11-create-eks-node-group-in-aws-web-console)-->
### 11. Create EKS node group in AWS web console

![](img/node-group-1.png)

![](img/node-group-2.png)

![](img/node-group-3.png)

![](img/node-group-4.png)

![](img/node-group-5.png)

![](img/node-group-6.png)

![](img/node-group-7.png)

![](img/node-group-8.png)

![](img/node-group-9.png)

![](img/node-group-10.png)

![](img/node-group-11.png)

![](img/node-group-12.png)


<!-- - [12. Create KUBECONFIG at your local](#12-create-kubeconfig-at-your-local)-->
### 12. Create KUBECONFIG at your local

**Run this** command get the content of your `~/.kube/config` file at your local

```bash
aws eks --region eu-central-1 update-kubeconfig --name diu-eks-cluster --profile devopsinuse

Added new context arn:aws:eks:eu-central-1:611111111116:cluster/diu-eks-cluster to /home/username/.kube/config
```

**If you now go and take** a look what is inside the file: `~/.kube/config`, you will find a correct connection settings to be able to **communicate** with your **AWS EKS Kubernetes cluster** under your **AWS Free Tier account**


Run following commands to make sure that you can communicte with your **AWS EKS Kubernetes cluster** under your **AWS Free Tier account**

```bash
kubectl get nodes
NAME                                            STATUS   ROLES    AGE     VERSION
ip-172-31-20-97.eu-central-1.compute.internal   Ready    <none>   9m2s    v1.15.10-eks-bac369
ip-172-31-3-232.eu-central-1.compute.internal   Ready    <none>   8m55s   v1.15.10-eks-bac369

kubectl get pods -A
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE
kube-system   aws-node-ldt44             1/1     Running   0          9m14s
kube-system   aws-node-s6nb9             1/1     Running   0          9m7s
kube-system   coredns-5b6dbb4b59-4rjkm   1/1     Running   0          23m
kube-system   coredns-5b6dbb4b59-bnxs4   1/1     Running   0          23m
kube-system   kube-proxy-ncm6q           1/1     Running   0          9m14s
kube-system   kube-proxy-zffwq           1/1     Running   0          9m7s
```

<!-- - [13. First NGINX deployment by kubectl to AWS EKS cluster created manually](#13-first-nginx-deployment-by-kubectl-to-aws-eks-cluster-created-manually)-->
### 13. First NGINX deployment by kubectl to AWS EKS cluster created manually

```bash
tree deployment-eks-nginx-manual 

deployment-eks-nginx-manual
├── deployment-eks-nginx-manual.html
├── index-eks-nginx-manual_files
│   ├── bootstrap.min.css
│   ├── bootstrap.min.js
│   ├── Chart.min.js
│   ├── dashboard.css
│   ├── feather.min.js
│   ├── jquery-3.2.1.slim.min.js
│   └── popper.min.js
└── index-eks-nginx-manual.html
```

```bash

cd deployment-eks-nginx-manual/


kubectl create configmap nginx-cm \
--from-file=index-eks-nginx-manual.html \
--from-file=index-eks-nginx-manual_files/bootstrap.min.css \
--from-file=index-eks-nginx-manual_files/bootstrap.min.js \ 
--from-file=index-eks-nginx-manual_files/Chart.min.js \
--from-file=index-eks-nginx-manual_files/dashboard.css \
--from-file=index-eks-nginx-manual_files/feather.min.js \
--from-file=index-eks-nginx-manual_files/jquery-3.2.1.slim.min.js \
--from-file=index-eks-nginx-manual_files/popper.min.js
```

**Explore** file: `deployment-eks-nginx-manual.yaml` for creating **deployment** and **service** Kubernetes objects

```yaml
---
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /usr/share/nginx/html/index.html
          readOnly: true
          name: nginx-cm
          subPath: index.html
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/bootstrap.min.css
          readOnly: true
          name: nginx-cm
          subPath: bootstrap.min.css
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/bootstrap.min.js
          readOnly: true
          name: nginx-cm
          subPath: bootstrap.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/Chart.min.js
          readOnly: true
          name: nginx-cm
          subPath: Chart.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/dashboard.css
          readOnly: true
          name: nginx-cm
          subPath: dashboard.css
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/feather.min.js
          readOnly: true
          name: nginx-cm
          subPath: feather.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/jquery-3.2.1.slim.min.js
          readOnly: true
          name: nginx-cm
          subPath: jquery-3.2.1.slim.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/popper.min.js
          readOnly: true
          name: nginx-cm
          subPath: popper.min.js
      
      volumes:
      # Do not forget to run this command up front
      # kubectl create configmap nginx-cm --from-file=index-eks-nginx-manual.html
      - name: nginx-cm
        configMap:
          name: nginx-cm 
          items:
            - key: index-eks-nginx-manual.html
              path: index.html
            - key: bootstrap.min.css
              path: bootstrap.min.css
            - key: bootstrap.min.js
              path: bootstrap.min.js
            - key: Chart.min.js
              path: Chart.min.js
            - key: dashboard.css
              path: dashboard.css
            - key: feather.min.js
              path: feather.min.js
            - key: jquery-3.2.1.slim.min.js
              path: jquery-3.2.1.slim.min.js
            - key: popper.min.js
              path: popper.min.js

              

---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30111
  selector:
    app: nginx

```
**Allow** port `30111` in ***Security Group*** section in AWS console

![](img/sg-2.png)


**Execute deployment** of your **Nginx** web server with **custom content**
```bash
kubectl apply -f deployment-eks-nginx-manual.yaml
```

**Retrive** IP Addresses of your **physical nodes** in AWS

```bash
 kubectl get nodes -o wide | awk -F" " '{print $1"\t"$7}'
NAME    EXTERNAL-IP
ip-172-31-20-97.eu-central-1.compute.internal   35.157.105.203
ip-172-31-3-232.eu-central-1.compute.internal   3.121.160.180
```


![](img/eks-manual-nginx-nodes-1.png)
![](img/eks-manual-nginx-nodes-2.png)


Explore Nginx pod by attaching to **a running container**

```bash
kubectl get pods                                    
NAME                     READY   STATUS    RESTARTS   AGE
nginx-6d786774cd-fmtgh   1/1     Running   0          31m

kubectl exec -it  nginx-6d786774cd-fmtgh -- bash
root@nginx-6d786774cd-fmtgh:/# 


root@nginx-6d786774cd-fmtgh:/# ls usr/share/nginx/html/index* -l
-rw-r--r-- 1 root root 10:17 usr/share/nginx/html/index.html

usr/share/nginx/html/index-eks-nginx-manual_files:
total 516
-rw-r--r-- 1 root root  10:17 Chart.min.js
-rw-r--r-- 1 root root  10:17 bootstrap.min.css
-rw-r--r-- 1 root root  10:17 bootstrap.min.js
-rw-r--r-- 1 root root  10:17 dashboard.css
-rw-r--r-- 1 root root  10:17 feather.min.js
-rw-r--r-- 1 root root  10:17 jquery-3.2.1.slim.min.js
-rw-r--r-- 1 root root  10:17 popper.min.js
```


```bash
# get all deployments in default namespace
kubectl get deployment nginx -o yaml         


apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: | 
      {...}
  creationTimestamp: "..."
  generation: 1
  labels:
    app: nginx
  name: nginx
  namespace: default
  resourceVersion: "15772"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/nginx
  uid: 83a88f7c-19f9-40b6-a3e6-76b6afc3f445
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 2
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /usr/share/nginx/html/index.html
          name: nginx-cm
          readOnly: true
          subPath: index.html
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/bootstrap.min.css
          name: nginx-cm
          readOnly: true
          subPath: bootstrap.min.css
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/bootstrap.min.js
          name: nginx-cm
          readOnly: true
          subPath: bootstrap.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/Chart.min.js
          name: nginx-cm
          readOnly: true
          subPath: Chart.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/dashboard.css
          name: nginx-cm
          readOnly: true
          subPath: dashboard.css
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/feather.min.js
          name: nginx-cm
          readOnly: true
          subPath: feather.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/jquery-3.2.1.slim.min.js
          name: nginx-cm
          readOnly: true
          subPath: jquery-3.2.1.slim.min.js
        - mountPath: /usr/share/nginx/html/index-eks-nginx-manual_files/popper.min.js
          name: nginx-cm
          readOnly: true
          subPath: popper.min.js
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - configMap:
          defaultMode: 420
          items:
          - key: index-eks-nginx-manual.html
            path: index.html
          - key: bootstrap.min.css
            path: bootstrap.min.css
          - key: bootstrap.min.js
            path: bootstrap.min.js
          - key: Chart.min.js
            path: Chart.min.js
          - key: dashboard.css
            path: dashboard.css
          - key: feather.min.js
            path: feather.min.js
          - key: jquery-3.2.1.slim.min.js
            path: jquery-3.2.1.slim.min.js
          - key: popper.min.js
            path: popper.min.js
          name: nginx-cm
        name: nginx-cm
status:
  availableReplicas: 1
  conditions:
   ...
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

```


```bash
kubectl get service  nginx -o yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {}
  creationTimestamp: "..."
  name: nginx
  namespace: default
  resourceVersion: "15759"
  selfLink: /api/v1/namespaces/default/services/nginx
  uid: 67ad2770-154a-4dc4-aa32-a4c2d53af8d2
spec:
  clusterIP: 10.100.210.78
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 30111
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
```

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


