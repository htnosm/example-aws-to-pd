resource "null_resource" "list_bucket_call_count" {
  count = var.trigger_list_bucket_call_count ? 1 : 0

  provisioner "local-exec" {
    command = "aws s3 ls s3://${aws_s3_bucket.example.id}"
  }
}
