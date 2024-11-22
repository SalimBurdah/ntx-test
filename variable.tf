# AWS AZ
variable "aws_az" {
  default     = "ap-southeast-3a"
}

# VPC Variables
variable "vpc_cidr" {
  default     = "10.1.64.0/18"
}

# Subnet Variables
variable "public_subnet_cidr" {
  default     = "10.1.64.0/24"
}

#Variable yang dibuat : aws access key, region dan secret key
variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "linux_instance_type" {
  type        = string
  description = "EC2 instance untuk Server Linux"
  default     = "t3.micro"
}
variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate public IP address ke EC2 instance"
  default     = true
}
variable "linux_root_volume_size" {
  type        = number
  default = 8
}
variable "linux_data_volume_size" {
  type        = number
  default = 10
}
variable "linux_root_volume_type" {
  type        = string
  default     = "gp3"
}
variable "linux_data_volume_type" {
  type        = string
  default     = "gp3"
}