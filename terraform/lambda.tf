resource "aws_lambda_function" "image_handler" {
  function_name = "imageSignedUrl"
  filename      = "${path.module}/../lambda/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/lambda.zip")
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10

  environment {
    variables = {
      MONGODB_URI = var.mongodb_uri
      S3_BUCKET   = aws_s3_bucket.images.bucket
    }
  }
}
