resource "aws_instance" "backend" {
  ami =var.ami_id
    instance_type = var.instance_type
    key_name =var.key_name
    user_data = templatefile("./backend.sh",{})
    tags = {
        Name = "Backend"
    }
  
}