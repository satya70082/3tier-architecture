variable "ami" {
  description = "value of the AMI"
  type = string
  default = "ami-0e2c8caa4b6378d8c" # Ubuntu 18.04
}
variable "key_name" {
  description = "value of the key name"
  type = string
  default = "satyayt"
  
}
variable "instance_type" {
  description = "value of the instance type"
  type = string
  default = "t2.micro"
  
}
# backup_retention variable declaration
variable "backupr-retention" {
    type = number
    default = "7"
  
}
