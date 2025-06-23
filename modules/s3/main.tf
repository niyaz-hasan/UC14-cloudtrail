resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "var.s3_bucket_name-${random_pet.this.id}"

  versioning {
    enabled = true
  }

}

resource "random_pet" "this" {
  length = 2
}