variable "aws_access_key" {}
variable "aws_secret_key" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6.2"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-northeast-1"
}

module "s3" {
  source = "./services/s3"
  cloudfront_iam_arn = module.cloudfront.cloudfront_iam_arn
}

module "cloudfront" {
  source = "./services/cloudfront"
  web_bucket_id = module.s3.web_bucket_id
  web_bucket_bucket_regional_domain_name = module.s3.web_bucket_bucket_regional_domain_name
}