output "web_bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "web_bucket_bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}