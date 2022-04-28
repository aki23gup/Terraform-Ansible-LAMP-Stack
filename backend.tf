# This file contains backend for the tf.state file, held in an s3 bucket for configuration backup
terraform {
    backend "s3" {
        bucket = "ontarioskills-backend" // Storing the state file in the s3 bucket
        key = "TF/terraform.tfstate"
        region = "us-east-1"
    }
}