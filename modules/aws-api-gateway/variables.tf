variable "environment" {
  default = ""
}

variable "name" {
  default = "sample"
}

variable "description" {
  default = "API to access micro services"
}

variable "enable" {
  default = "true"
}

variable "aws_vpc_link" {
  default = []
}

variable "lambda_backend_integration" {
  default = []
}

variable "swagger-file_path" {
  default = ""
}

variable "integration_connectiontype" {
  default = ""
}

variable "integration_type" {
  default = ""
}

variable "whitelist_ips" {
  default = {}
}

variable "public_domain_name" {
  default = ""
}
