# Jenkins-Project

This Project is about to bring a basic app "Hello-App" using Jenkins (for building a CICD pipeline) & System provisioning and configuration management in AWS.

## Automated
Terraform
1. Launching EC2 instance (Bastion, Jenkins & App) in a VPC setup on AWS which includes public & private subnets (multi-AZ). Public subnets should be used for only exposing required services. <br>
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
1. A Jenkins pipeline to build nodejs app image & deploy it on the app instance. <br>
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




