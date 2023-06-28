# Jenkins-Project

This Project is about to built a 3 Tier Architecture using Terraform in AWS, Installing docker on Jenkins & App Server using Ansible, Deploying application on app server using CICD Jenkins and storing the build artifacts into ECR.

## Automated
Terraform
1. Launching EC2 instance (Bastion, Jenkins & App) in a 3 Tier VPC Setup. <br>
    a. Bastion in public subnet. <br>
    b. Jenkins and App in private subnet. <br>
2. Security Groups for EC2 Instances & ALB. <br> 
3. Storing tf state file in S3 and enabling terrafom locking with help of dynamoDB <br>

Ansible
1. Configuring dynamic inventory. <br>
2. Installing docker on Jenkins & App Server. <br>

Docker
1. Running Jenkins & App as Docker container. <br>

CICD Jenkins
1. CI : Building & Pushing app image using Jenkins declarative pipeline. <br>
2. CD : Deploying application as docker container in app server using Jenkins declarative pipeline. <br>

ECR
1. Pushing & Storing app build artifacts into ECR.

## Manual Creations
a) ALB and Target Groups <br>
b) S3 Bucket <br>
c) ECR Repo <br>
d) DynamoDB table <br>

## Important Manual Commands
#Command to avoid sudo for docker commands on Jenkins & App Server
```
ansible all -m shell -a "sudo usermod -aG docker ${USER}" -i /path/inventory_aws_ec2.yaml
```

#Command to run jenkins as docker container in Jenkins Server
```
docker run -itd --name jenkins-local -p 8080:8080 -v jenkins:/var/jenkins_home --env JENKINS_OPTS="--prefix=/jenkins" jenkins/jenkins:lts
```




