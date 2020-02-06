data "template_file" "aws_api_swagger" {
  count    = "${var.enable == "true" ? 1 : 0}"
  template = "${file(var.swagger-file_path)}"

  vars = {
    connectionType     = "${var.integration_connectiontype}"
    type               = "${var.integration_type}"
    environment        = "${var.environment}"
    api_name           = "${var.name}"
    description        = "${var.description}"
    public_domain_name = "${var.public_domain_name}"

  }
}


resource "aws_api_gateway_rest_api" "api-gateway" {
  count       = "${var.enable == "true" ? 1 : 0}"
  name        = "${var.name}"
  description = "${var.description}"
  body        = "${data.template_file.aws_api_swagger[0].rendered}"
  policy      = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "arn:aws:execute-api:ap-southeast-2:210043795784:*",
            "Condition": {
              "IpAddress": {"aws:SourceIp": ${jsonencode(keys(var.whitelist_ips))}}
            }
        }
    ]
}
EOF
}

resource "aws_api_gateway_deployment" "aws-api-gateway-deployment" {
  count       = "${var.enable == "true" ? 1 : 0}"
  rest_api_id = "${aws_api_gateway_rest_api.api-gateway[0].id}"
  # stage_name  = "${var.environment}"
  variables = {
    deployed_at = "${timestamp()}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_cloudwatch_log_group" "log_group" {
#   count = "${var.enable == "true" ? 1 : 0}"
#   name  = "API-Gateway-Access-Logs_${aws_api_gateway_rest_api.api-gateway[0].name}/${var.environment}"
# }
#
# resource "aws_api_gateway_stage" "stage" {
#   count         = "${var.enable == "true" ? 1 : 0}"
#   depends_on    = ["aws_cloudwatch_log_group.log_group"]
#   deployment_id = "${aws_api_gateway_deployment.aws-api-gateway-deployment[0].id}"
#   rest_api_id   = "${aws_api_gateway_rest_api.api-gateway[0].id}"
#   stage_name    = "${var.environment}"
#
#   access_log_settings {
#     destination_arn = "${aws_cloudwatch_log_group.log_group[0].arn}"
#     format          = "${file("${path.module}/access_log_format.json")}"
#   }
#
# }
