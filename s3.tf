#Random hex string for uniqueness
resource "random_id" "bucket_suffix" {
    byte_length = 4
}


resource "aws_s3_bucket" "s3bucket" {
    bucket = "terraform-s3-${random_id.bucket_suffix.hex}"  
}

#For printing the bucket name
output "bucket_name" {
    value = aws_s3_bucket.s3bucket.bucket
}