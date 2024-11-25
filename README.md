## Tools and Technologies

I'm using tools and services to implement the solution in the below:

- **CI Services**: GitHub Actions
- **Provisioning Tools**: Terraform
- **Local Environment**: Docker
- **Cloud Providers**: AWS
- **Load Balancers**: NGINX
- **Version Control**: GitHub

### Provisioning Infrastructure with Terraform

git clone git@github.com:SalimBurdah/ntx-test.git
cd terraform

create terraform.tfvars
add variable aws key
to create aws key go to the aws IAM

aws_access_key = "your_access_key"
aws_secret_key = "your_secret_key"
aws_region     = "ap-southeast-3"           #region jakarta

terraform init
terraform configure
terraform plan
terraform apply

terraform will be created 2 instance with the name ntx-dev
Once the EC2 instances are created, you can SSH into them using the key pair you configured:
chmod 400 private-key.pem
ssh -i /path/to/your/private-key.pem ubuntu@<EC2_PUBLIC_IP>

### install nginx and create SSL certificate

I installed nginx on one of server and the configuration nginx as a load balancer in the directory nginx
copy the default to the file in directory /etc/nginx/site-available

and then i created a self signed SSL certificate for try using https.
i created domain with the name ntx-app.com
i configure in my local machine to add hosts the domain

sudo vi /etc/hosts
<EC2_PUBLIC_IP> domain_name

### Deploy Application using cicd github action

for the cicd pipeline in the directory .github/workflows
Before deploying the application, i configure the variable that is needed:

i created the reposity docker hub with the name salimburdah/ntx-app and you can docker pull salimburdah/ntx-app

i configure the github secret to store the following secrets in my GitHub repository settings under Settings > Secrets:
DOCKER_USERNAME: Your Docker Hub username.
DOCKER_PASSWORD: Your Docker Hub password.
DOCKER_IMAGE_NAME: The name of the Docker image (e.g., salimburdah/ntx-app).
EC2_PRIVATE_KEY: The private SSH key for accessing the EC2 instances.
EC2_USER: The SSH user for your EC2 instances (e.g., ubuntu).
EC2_HOST_1 and EC2_HOST_2: The public IP addresses of your EC2 instances.

Step-by-Step Deployment :
1. Fork this repository to your GitHub account.
2. Configure GitHub Secrets
   Go to your repository’s Settings > Secrets and add the necessary secrets:
   - DOCKER_USERNAME, DOCKER_PASSWORD, DOCKER_IMAGE_NAME
   - EC2_PRIVATE_KEY, EC2_USER, EC2_HOST_1, EC2_HOST_2
3. Clone the Repository
4. Clone the forked repository to your local machine:
   git clone https://github.com/your-username/your-repository.git
   cd your-repository

5.Push Code to Trigger CI/CD Pipeline
  Push your changes to a feature branch:
  git checkout -b feature/your-feature
  git add .
  git commit -m "Add your feature"
  git push origin feature/your-feature

This will trigger the GitHub Actions workflow.

if you can open the application in your browser you can following this:

<EC2_PUBLIC_IP>:3000 or you can access the domain ntx-app.com


### Assumptions

Docker Installed on EC2: The script assumes Docker is not installed on the EC2 instances. If Docker is already installed, the installation step is skipped.

Docker Hub Access: the pipeline assumes that the Docker Hub credentials (DOCKER_USERNAME and DOCKER_PASSWORD) are correctly stored as GitHub Secrets and that the Docker image can be pushed and pulled successfully to/from Docker Hub

This implementation assumes only two EC2 instances, and no load balancing or auto-scaling configurations are involved. It is assumed that traffic distribution is handled at the application level (e.g., manually setting up round-robin or other methods if needed).

### Challenges

Without a load balancer or auto-scaling groups, managing traffic to multiple instances manually can be challenging, especially as the number of instances grows or traffic fluctuates.

Docker image builds may fail due to various reasons, such as missing dependencies in the Dockerfile, incorrect configurations. Also, if the Docker Hub credentials are not configured correctly, the image may fail to be pushed to Docker Hub.


