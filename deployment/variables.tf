variable environment {}
variable aws_region {}
variable aws_profile {}
variable dynamo_db_lock {}

#========AWS API Variables====
variable "aws-api-create-enable" {
  default = "true"
}

variable "aws-api-gateway-name" { default = "default_name" }

variable "description" {
  default = "API to access micro services"
}

variable "aws_vpc_link" { default = "default_vpc_link" }
variable "lambda_backend_integration" { default = [] }
variable "swagger-file_path" {}
variable "integration_connectiontype" { default = "VPC_LINK" }
variable "integration_type" { default = "HTTP_PROXY" }
variable "api_gateway_whitelist_ips" { default = {} }

variable "public_domain_name" { default = "" }
