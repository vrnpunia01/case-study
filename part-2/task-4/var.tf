variable "profile" {
    description = "AWS credentials profile you want to use"
}
variable "AWS_ACCESS_KEY_ID" {}

variable "AWS_SECRET_KEY" {}

variable "aws_region" {    
    default = "us-east-1"
}

variable "availability_zones" { 
    type     = string   
    default  = "us-east-1"
}
variable "environment" { 
    type     = string   
    default  = "case-study"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "pblc_cidr_block" {
  description = "CIDR block for Public Subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "pvt_cidr_block" {
  description = "CIDR block for Private Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "AmiLinux" {
  type = string
  default = "ami-b73b63a0" 
  description = "have only added one region"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "iam-role-name" {
type = string
default = "case-study"
}

variable "key_path" {

type = string
default =  "~/.ssh/id_rsa.pub"

}
