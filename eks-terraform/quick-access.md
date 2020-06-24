**Reminder how to start AWS EKS cluster by terraform:**

```bash
git clone https://github.com/xjantoth/aws-eks-devopsinuse.git
```

to **comment** terraform files (getting back to initial clear state). This **helps** to get the terraform code to the state **right after fresh** `git clone https://github.com/xjantoth/aws-eks-devopsinuse.git` command.

```bash
sed -i 's/^/#/' iam.tf outputs.tf sg.tf subnets.tf
sed -i '/^.*EKS_CLUSTER_START.*/,/^.*EKS_NODE_GROUP_END.*/s/^/#/' main.tf
```

* **uncomment** all files from `eks-terraform/` **folder** at once:

```bash
sed 's/^#//' -i iam.tf
sed 's/^#//' -i sg.tf
sed 's/^#//' -i subnets.tf
sed 's/^#//' -i outputs.tf
sed -e '/^.*EKS_CLUSTER_START.*/,/^.*EKS_CLUSTER_END.*/s/^#//' -i main.tf
sed -e '/^.*EKS_NODE_GROUP_START.*/,/^.*EKS_NODE_GROUP_END.*/s/^#//' -i main.tf
```
`variables.tf` (this file is uncommented all the time)
`outputs.tf` (does not really matter whether it's uncommented or not)

**Delete** all **hidden** terraform `files/folders`:

```
echo "" > ~/.kube/config && cat ~/.kube/config
cd eks-terraform
rm terraform.tfstate.backup terraform.tfstate .terraform -rf
ls  ~/.ssh/eks-aws.pub
terraform init
terraform validate
terraform fmt -recursive
```

**Bring** up your AWS EKS Kubernetes cluster (this will take about ~15min)

```bash
terraform apply -var-file terraform.eks.tfvars
```

Update **KUBECONFIG** once AWS EKS cluster is up and running

```bash
aws eks \
--region eu-central-1 \
update-kubeconfig \
--name diu-eks-cluster \
--profile devopsinuse > &>/dev/null
```


**Add** output of this commnad to `/etc/hosts` file

```bash
kubectl get nodes -o wide | awk -F" " '{print $7 "\tk8s-ingress-name"}' | grep -v "EXTER"
```

**Work** with AWS EKS cluster ...

```bash
...
kubectl get ... ...
kubectl describe...
kubectl run ...
kubectl delete ...
kubectl edit ...
kubectl log ...
kubectl explain ...
kubectl expose ...
kubectl apply ...
kubectl create ...
...
```


**Delete** up your AWS EKS Kubernetes cluster (this will take about ~15min)

```bash
# Please undeploy everyhting from your AWS EKS cluster
helm delete <release-name>
kubectl delete -f <file-name>.yaml

# Once applications are undeployed, please run:
terraform destroy -var-file terraform.eks.tfvars
```


