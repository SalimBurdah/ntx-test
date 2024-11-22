# Membuat secure private key dan encode menjadi PEM
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
} 
# Membuat keypair
resource "aws_key_pair" "key_pair" {
  key_name   = "ec2-key-pair"  
  public_key = tls_private_key.key_pair.public_key_openssh
} 
# Save file-nya ke local
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.key_pair.private_key_pem
}