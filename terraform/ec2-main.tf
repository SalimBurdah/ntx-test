# Membuat security group untuk EC2
resource "aws_security_group" "aws-ntx-sg" {
  name        = "ntx-sg"
  description = "Allow incoming traffic ke EC2 Instance"
  vpc_id      = aws_vpc.vpc.id  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming koneksi HTTP "
  }
    ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming koneksi HTTP "
  }  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming koneksi SSH"
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Membuat EC2 Instance
resource "aws_instance" "ntx-server" {
count                       = 2  
ami                         = data.aws_ami.ubuntu-linux-2004.id #kita menggunakan versi 20
instance_type               = var.linux_instance_type
subnet_id                   = aws_subnet.public-subnet.id
vpc_security_group_ids      = [aws_security_group.aws-ntx-sg.id]
associate_public_ip_address = var.linux_associate_public_ip_address
source_dest_check           = false
key_name                    = aws_key_pair.key_pair.key_name
  
# root disk
root_block_device {
volume_size           = var.linux_root_volume_size
volume_type           = var.linux_root_volume_type
delete_on_termination = true
encrypted             = true
}

# extra disk
ebs_block_device {
device_name           = "/dev/xvda"
volume_size           = var.linux_data_volume_size
volume_type           = var.linux_data_volume_type
encrypted             = true
delete_on_termination = true
}
  
tags = {
    Name = "ntx-dev"
    }
}
