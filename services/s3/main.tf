resource aws_s3_bucket bucket {
  bucket = "aohnostatics"
}

resource aws_s3_object object {
  for_each     = fileset("./services/s3/uploads/", "*")
  bucket       = aws_s3_bucket.bucket.id
  key          = "/${each.value}"
  source       = "./services/s3/uploads/${each.value}"
  etag         = filemd5("./services/s3/uploads/${each.value}")
  content_type = endswith(each.value, ".html") ? "text/html" : endswith(each.value, ".js") ? "text/javascript" : endswith(each.value, ".css") ? "text/css" : "text/plain"
}