# 変数nameをstringで設定する
variable "name" {
    type = string
}

# amazonqというVPCを作成する。CIDRを設定する。nameタグにnameを設定する。
resource "aws_vpc" "amazonq" {
    cidr_block = "10.0.0.0/16" # 値は自分で入力
    tags = {
        Name = "${var.name}"
    }
}

# amazonqというVPCにインターネットゲートウェイを作成する。nameタグにnameを設定する。
resource "aws_internet_gateway" "amazonq" {
    vpc_id = aws_vpc.amazonq.id
    tags = {
        Name = "${var.name}"
    }
}

# amazonqというVPCにサブネットを作成する。nameタグにnameを設定する。
resource "aws_subnet" "amazonq" {
    vpc_id = aws_vpc.amazonq.id
    cidr_block = "10.0.1.0/24" # ���は自分で入力
    tags = {
        Name = "${var.name}"
    }
}

# ルートテーブルを作成する。nameタグにnameを設定する。
resource "aws_route_table" "amazonq" {
    vpc_id = aws_vpc.amazonq.id
    tags = {
        Name = "${var.name}"
    }
}

# ルートテーブルにインターネットゲートウェイを紐づける
resource "aws_route" "amazonq" {
    route_table_id = aws_route_table.amazonq.id
    gateway_id = aws_internet_gateway.amazonq.id
    destination_cidr_block = "0.0.0.0/0"
}

# サブネットにルートテーブルを紐付ける。
resource "aws_route_table_association" "amazonq" {
    subnet_id = aws_subnet.amazonq.id
    route_table_id = aws_route_table.amazonq.id
}

