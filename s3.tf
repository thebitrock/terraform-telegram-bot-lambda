resource "aws_s3_bucket" "source_code" {
  bucket = lower(local.identifier_name)
}

resource "aws_s3_object" "source_code" {
  key    = "${local.identifier_name}.zip"
  bucket = aws_s3_bucket.source_code.id

  source = data.archive_file.source_code.output_path
  etag   = data.archive_file.source_code.output_md5
}

resource "aws_s3_bucket_acl" "bot" {
  bucket = aws_s3_bucket.source_code.id
  acl    = "private"
}
