output "webhook_url" {
  value = "${aws_api_gateway_stage.api_gateway.invoke_url}/${var.hook_path}"
}

output "lambda_role_name" {
  value = aws_iam_role.lambda.name
}
