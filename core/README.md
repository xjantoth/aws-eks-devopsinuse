# How to use this simple code

```bash
terraform validate
terraform fmt -recursive
terraform plan -var-file=terraform.certification.tfvars
terraform apply  -var-file=terraform.certification.tfvars
terraform destroy  -var-file=terraform.certification.tfvars

terraform console   -var-file=terraform.certification.tfvars



dig NS  devopsinuse.com 

dig   abc.devopsinuse.com

; <<>> DiG 9.14.7 <<>> abc.devopsinuse.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 46532
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;abc.devopsinuse.com.		IN	A

;; ANSWER SECTION:
abc.devopsinuse.com.	300	IN	A	11.22.33.44

;; Query time: 29 msec
;; SERVER: 192.168.1.1#53(192.168.1.1)
;; WHEN: Sun Nov 17 13:14:51 CET 2019
;; MSG SIZE  rcvd: 53

dig NS devopsinuse.com

will print Name Servers resolving this domain name
```


# S3

```bash
https://docs.aws.amazon.com/cli/latest/index.html
https://awspolicygen.s3.amazonaws.com/policygen.html

aws s3 ls help
aws s3 ls
aws s3 mb s3://new-bucket-cert
aws s3 ls s3://new-bucket-cert
aws s3 cp s3://new-bucket-cert/coffee.jpg coffee.jpg 
aws  s3api delete-bucket --bucket new-bucket-cert --region eu-central-1
```

# AWS EC2 MInstance Metadata

```bash
 curl http://169.254.169.254/latest/meta-data
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
events/
hostname
iam/
identity-credentials/
instance-action
instance-id
instance-type
local-hostname
local-ipv4
mac
metrics/
network/
placement/
profile
public-hostname
public-ipv4
public-keys/
reservation-id
security-groups
```