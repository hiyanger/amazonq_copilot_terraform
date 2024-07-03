# AWSプロバイダを設定する
provider "aws" {
    region = "ap-northeast-1" # 自分で入力
}

# amazonq0628というバケット名のS3にtfstateを配置する
terraform {
    backend "s3" {
        bucket = "amazonq0629" # 自分で入力
        key    = "tfstate"
        region = "ap-northeast-1"
    }
}

# amazonqというS3バケットを作成
resource "aws_s3_bucket" "amazonq" {
    bucket = "amazonq20240701"
}

# amazonqというVPCを作成
resource "aws_vpc" "amazonq" {
    cidr_block = "172.31.0.0/16"
    tags = { # =を追加
        Name = "amazonq" # amazonqにする
    }
}

# amazonqというサブネットを作成
resource "aws_subnet" "amazonq" {
    vpc_id = aws_vpc.amazonq.id
    cidr_block = "172.31.0.0/24"
    tags = {
        Name = "amazonq"
    }
}

# amazonqというセキュリティグループを作成
resource "aws_security_group" "amazonq" {
    name = "amazonq"
    vpc_id = aws_vpc.amazonq.id
    tags = {
        Name = "amazonq"
    }
}

# amazonqというEC2を作成
resource "aws_instance" "amazonq" {
    instance_type = "t2.micro"
    ami = "ami-061a125c7c02edb39"
    tags = {
        Name = "amazonq"
    }
}