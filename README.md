# apigateway-terraform

## Setting the host/dev machine
Build the docker image

    docker build -t apigateway-terraform/terraform:latest -f Dockerfile .

Run the docker container

    docker run -i -d -v $(pwd):/mnt/workspace apigateway-terraform/terraform:latest

Enter the Container and use it as a Dev Environment

    docker exec -it $(docker ps | grep apigateway-terraform/terraform:latest | awk '{print $1}') bash

Setup the AWS Credentials which has sufficient permission

    aws configure
    AWS Access Key ID [None]: *********
    AWS Secret Access Key [None]: **********
    Default region name [None]: ap-southeast-2
    Default output format [Noµne]:


After Setup the Credentials, Initialize the terraform and execute the plan
Cd into the specific environment folder and run the terraform

    cd /mnt/workspace/env/dev
    terraform init -reconfigure -var-file=dev.variables.tfvar -backend-config=dev.backend.tfvar ../../deployment/
    terraform plan -var-file=dev.variables.tfvar ../../deployment
    terraform apply -var-file=dev.variables.tfvar ../../deployment

To destroy

    terraform destroy -var-file=dev.variables.tfvar ../../deployment/
