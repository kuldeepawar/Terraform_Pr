resource "aws_s3_bucket" "bucketk1" {
  bucket = "kul-bucket-1"
  
  
}

resource "aws_s3_bucket_public_access_block" "bucketk1" {
  bucket = aws_s3_bucket.bucketk1.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
  
}

resource "aws_s3_object" "index" {
  bucket = "kul-bucket-1"
  key = "index.html"
  source = "index.html"
  content_type = "text/html"
  
}

resource "aws_s3_object" "error" {
  bucket = "kul-bucket-1"
  key = "error.html"
  source = "error.html"
  content_type = "text/html"
  
}

resource "aws_s3_bucket_website_configuration" "bucket1" {
  bucket = aws_s3_bucket.bucketk1.id

  index_document {
    suffix = "index.html"
    
  }

  error_document {
    key = "error.html"
  }
  
}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucketk1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.bucketk1.arn}",
        "${aws_s3_bucket.bucketk1.arn}/*"
      ]
    }
  ]
}
EOF
}
