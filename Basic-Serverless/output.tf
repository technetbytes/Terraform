output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.image_api.id}.execute-api.${var.region}.amazonaws.com/v1/upload"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.image_upload_bucket.bucket
}
