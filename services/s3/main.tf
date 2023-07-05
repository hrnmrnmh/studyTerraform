resource aws_s3_bucket aohnostatics {
  bucket = "aohnostatics"
}

resource aws_s3_object object {
  for_each = fileset("./services/s3/uploads/", "*")
  bucket   = aws_s3_bucket.aohnostatics.id
  key = "/${each.value}"
  source = "./services/s3/uploads/${each.value}"
  etag = filemd5("./services/s3/uploads/${each.value}")
  content_type = "text/html"
}