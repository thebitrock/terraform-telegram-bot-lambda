
data "archive_file" "source_code" {
  type = "zip"

  source_dir  = var.source_dir
  output_path = "${local.identifier_name}.zip"
}
