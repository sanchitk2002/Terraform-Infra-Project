resource "aws_instance" "terraformEC2" {
    ami = "ami-0f918f7e67a3323f0"
    
    instance_type = "t2.micro"
    key_name = "sanchit"
    vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
    subnet_id = aws_subnet.public-subnet1.id
    associate_public_ip_address = true
    
    user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
            
              EOF

    tags = {
      Name = "terraform_EC2"
    }
              
}