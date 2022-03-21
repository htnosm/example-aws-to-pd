resource "null_resource" "list_bucket_call_count" {
  count = var.trigger_list_bucket_call_count ? 1 : 0

  triggers = {
    enabled = timestamp()
  }

  # s3:ListBuckets
  provisioner "local-exec" {
    command = "aws s3 ls"
  }
}
