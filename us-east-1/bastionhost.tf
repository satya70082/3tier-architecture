resource "aws_instance" "bastion" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.pub1.id
    vpc_security_group_ids = [aws_security_group.bastion-host.id ]
    tags = {
      Name= "bastion-server"
    }
}