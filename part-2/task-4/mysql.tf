
resource "aws_instance" "mysql" {
  ami             = var.AmiLinux 
  instance_type   = var.instance_type
  iam_instance_profile = var.iam-role-name
  key_name = var.key_path
  vpc_security_group_ids = [aws_security_group.case-study.id]
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "mysql-instance"
  }
    user_data = <<EOF

#!/bin/bash
echo "Copying the SSH Key Of NGINX to the server"
echo -e "mysql\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAB*******************F/SNZPMT4Qm/RVgBbIhG8VsoDhGM0tgIzWyTaNxDPSDx/yzJ8FQwCKOH6YR3RugLvTU+jDKvI8BWOnMM5cgrbfKbBssUyJSdWI86py4bi05A3X6O5+6xS6IvQbZwlbJiu/DbgAcvGLiq1mDi77O+DvU22RNgCB9hGddryWc3nTDOMyVaex5EdfvgxEli1DAM2YYr/DdxVvdzkrP/1fol6t+XT4FeQyW/KcQuRA53qG0aSYlSN/6NUO3OGuLn jenkins@gritfy.com\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAPlhbcDQ06FO8euMxVvsglV4gqhD0v1l8h+bk/X+eJWqQMHZ0CXzsywTe+32zdu9JydbwiQiMIlDwFy0nsyX+quzLupYejrAtFFOKoFSzNB3ng69KSV+M6kUZdXHfP9PjYt5wZfOW0h/W9+2Oz406UjpeaW5t9XPftx784nLsocR3d7mosIgLMXkFLijOfJknhEKWxMmvkwV15fcuPfpRhvJkFDCmpFMBTaOwE2rDuj22r0Z4bI78CdtZgTSB5eK1YebOtEUllB+pwoMA40cNgnivd ubuntu@gritfy.com" >> /home/ubuntu/.ssh/authorized_keys

echo "Installing MYSQL"
yum install mysql -y

echo "Changing Hostname"
echo -e "ngnix-host-prod" >/etc/hostname
EOF


}
