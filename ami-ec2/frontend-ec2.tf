resource "aws_instance" "front" {
  ami =var.ami_id
    instance_type = var.instance_type
    key_name =var.key_name
    user_data = templatefile("./frontend.sh",{})
    tags = {
        Name = "Frontend"
    }
}