resource "aws_s3_bucket" "source_code" {
  bucket = var.identifier
}

resource "aws_s3_object" "source_code" {
  key    = "${var.identifier}.zip"
  bucket = aws_s3_bucket.source_code.id

  source = data.archive_file.source_code.output_path
  etag   = data.archive_file.source_code.output_md5
}

resource "aws_s3_bucket_acl" "bot" {
  bucket = aws_s3_bucket.source_code.id
  acl    = "private"
}
