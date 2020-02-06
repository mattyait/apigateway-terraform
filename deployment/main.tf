module "aws-api-gateway" {
  source                     = "../modules/aws-api-gateway"
  enable                     = "${var.aws-api-create-enable}"
  environment                = "${var.environment}"
  name                       = "${var.aws-api-gateway-name}"
  description                = "${var.description}"
  aws_vpc_link               = "${var.aws_vpc_link}"
  lambda_backend_integration = "${var.lambda_backend_integration}"
  swagger-file_path          = "${var.swagger-file_path}"
  integration_connectiontype = "${var.integration_connectiontype}"
  integration_type           = "${var.integration_type}"
  whitelist_ips              = "${var.api_gateway_whitelist_ips}"
  public_domain_name         = "${var.public_domain_name}"
}
