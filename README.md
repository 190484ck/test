# REPO DETAILS

# Docker steps: Details in Dockerfile in docker folder

create Dockerfile
Create Image: docker build -t c1 .        ----- dot denotes current directory
show image: docker images
create container and start: docker run -i -t --name container1 -p 80:80 c1
show containers: docker ps -a
push image to docker hub: docker login -u <your-username>
                          docker tag c1:latest chandan/c1
                          docker push chandan/c1

# Terraform steps: Details in terraform folder

Resources will create:

1 VPC, 2 EC2, 2 EBS, 1 s3 bucket

# Pipeline Details: .gitlab-ci.yml file created in root folder
  
  file name: .gitlab-ci.yml
  4 stages : validate, plan, apply & destroy has been created.
