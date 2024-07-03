# AWSプロバイダを設定する
provider "aws" {
  region = "ap-northeast-1"
}

# バックエンドのS3を設定する
terraform {
  backend "s3" {
    bucket = "copilot0629"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    }
}

# 変数nameにcopilotを格納する
variable "name" {
  type = string
  default = "copilot"
}

# moduleのcommonを取得する
module "common" {
  source = "./modules/common"
  name = var.name
}

# セキュリティグループを作成する。SSHを許可する。タグにnameを設定する。
resource "aws_security_group" "copilot" {
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

# EC2インスタンスを作成する。タグにnameを設定する。パブリックIPを付与する。
resource "aws_instance" "copilot" {
  ami = "ami-061a125c7c02edb39" #AMI IDは自分で変更
  instance_type = "t2.micro"
  security_groups = [aws_security_group.copilot.id]
  associate_public_ip_address = true
  tags = {
    Name = var.name
  }
  key_name = "copilot"
  subnet_id = module.common.subnet_id
}
