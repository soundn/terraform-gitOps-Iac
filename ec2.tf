resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id # Ubuntu 24 AMI in eu-north-1
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              
              # Deploy a Static Website on Ubuntu 24 with Nginx

              # Exit immediately if a command exits with a non-zero status
              set -e

              # 1. Update System Packages
              apt update

              # 2. Install Nginx
              apt install nginx -y

              # 3. Clone the Website Code
              git clone https://github.com/GerromeSieger/Static-Site.git

              # 4. Deploy the Website
              cp -r Static-Site/* /var/www/html

              # 5. Restart Nginx
              systemctl restart nginx

              echo "Static website deployment completed."
              EOF



  tags = {
    Name = "StaticWeb-terraform"
  }
}

resource "aws_instance" "nginx" {
  ami                    = "ami-0705384c0b33c194c" # Ubuntu 24 AMI in eu-north-1
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              
              # Deploy a Static Website on Ubuntu 24 with Nginx

              # Exit immediately if a command exits with a non-zero status
              set -e

              # 1. Update System Packages
              apt update

              # 2. Install Nginx
              apt install nginx -y

              # 5. Restart Nginx
              systemctl restart nginx

              echo "Static website deployment completed."
              EOF

  tags = {
    Name = "nginx"
  }
}
