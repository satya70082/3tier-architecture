variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default = "ami-0e2c8caa4b6378d8c"
  
}
variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default = "t2.micro"
  
}
variable "key_name" {
  description = "The key pair to use for the EC2 instance"
  type        = string
    default = "satyayt"
}