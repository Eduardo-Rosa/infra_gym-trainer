resource "aws_s3_bucket" "images" {
  bucket = "secure-image-store-1234"
  force_destroy = true

  tags = {
    Environment = "dev"
  }
}

resource "aws_s3_bucket_policy" "private_access" {
  bucket = aws_s3_bucket.images.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "DenyPublicAccess",
      Effect    = "Deny",
      Principal = "*",
      Action    = "s3:*",
      Resource = [
        "${aws_s3_bucket.images.arn}/*",
        "${aws_s3_bucket.images.arn}"
      ],
      Condition = {
        Bool = {
          "aws:SecureTransport" = "false"
        }
      }
    }]
  })
}
