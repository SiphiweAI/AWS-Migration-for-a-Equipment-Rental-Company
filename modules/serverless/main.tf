resource "aws_iam_role" "lambda_exec" {
  name = "${var.project_name}-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "business_logic" {
  function_name = "${var.project_name}-business-logic"
  handler       = "index.handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_exec.arn
  s3_bucket     = var.lambda_artifacts_bucket
  s3_key        = var.lambda_artifacts_key
  tags          = var.tags
}
