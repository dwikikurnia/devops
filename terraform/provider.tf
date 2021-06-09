terraform {
    backend "s3" {
        bucket = "antrusd-tfstates"
        key    = "terraform/random/vpclb.tfstate"
        region = "ap-southeast-1"
    }
}

provider "aws" {
    region = "us-east-2"
}
