output "webhook_url" {
  value = "${aws_api_gateway_deployment.lambda.invoke_url}/${var.hook_path}"
}
