resource "aws_iam_role" "lambda" {
  name = format("iam_for_lambda_%s", var.identifier)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_lambda_function" "sltb" {
  s3_bucket        = aws_s3_bucket.source_code.bucket
  s3_key           = aws_s3_object.source_code.key
  function_name    = local.identifier_name
  role             = aws_iam_role.lambda.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = data.archive_file.source_code.output_base64sha256

  environment {
    variables = merge({
      BOT_TOKEN     = var.bot_token
      BOT_HOOK_PATH = format("/%s", var.hook_path)
    }, var.environment_variables)
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
  ]
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_policy" "lambda_logging" {
  name        = format("lambda_logging_for_%s", local.identifier_name)
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}
