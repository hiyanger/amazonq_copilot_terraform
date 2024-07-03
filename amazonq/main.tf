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

# 変数nameにdefault値でamazonqを格納する。型も設定する。
variable "name" {
    type = string
    default = "amazonq"
}

# moduleのcommonを取得する
module "common" {
    source = "./modules/common"
    name = var.name
}

# amazonqというセキュリティグループを作成する。SSHを許可する。タグに変数nameを設定する。VPCをmodulesから取得する。
resource "aws_security_group" "amazonq" {
    name = var.name
    vpc_id = module.common.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["XXXXX/32"]
    }
    tags = {
        Name = var.name
    }
}

# amazonqというEC2作成する。amazonqというセキュリティグループに紐づける。パブリックIPを付与する。amazonqというキーペアを使う。Nameタグを変数nameにする。
resource "aws_instance" "amazonq" {
    instance_type = "t2.micro"
    ami = "ami-061a125c7c02edb39" #AMI IDは自分で変更
    key_name = "amazonq"
    vpc_security_group_ids = [aws_security_group.amazonq.id]
    associate_public_ip_address = true
    subnet_id = module.common.subnet_id
    tags = {
        Name = var.name
    }
}