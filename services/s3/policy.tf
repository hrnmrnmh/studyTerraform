variable "cloudfront_iam_arn" {}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.static-www.json
}

data "aws_iam_policy_document" "static-www" {
  statement {
    sid = "Allow CloudFront"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [var.cloudfront_iam_arn]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}
