#変数nameをstringで設定する
variable "name" {
    type = string
}

# copilotというVPCを作成する。nameタグにnameを設定する。
resource "aws_vpc" "copilot" {
    cidr_block = "10.0.0.0/16" # 自分で入力
    tags =  {
        Name = "${var.name}"
    }
}

# copilotというVPCにインターネットゲートウェイを作成する。nameタグにnameを設定する。
resource "aws_internet_gateway" "copilot" {
    vpc_id = aws_vpc.copilot.id
    tags =  {
        Name = "${var.name}"
    }
}

# copilotというVPCにサブネットを作成する。nameタグにnameを設定する。
resource "aws_subnet" "copilot" {
    vpc_id = aws_vpc.copilot.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
        Name = "${var.name}"
    }
}

# copilotというVPCにルートテーブルを作成する。nameタグにnameを設定する。
resource "aws_route_table" "copilot" {
    vpc_id = aws_vpc.copilot.id
    tags =  {
        Name = "${var.name}"
    }
}

# copilotというVPCのルートテーブルにインターネットゲートウェイを紐付ける。
resource "aws_route" "copilot" {
    route_table_id = aws_route_table.copilot.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.copilot.id
}

# copilotというVPCにサブネットにルートテーブルを紐付ける。
resource "aws_route_table_association" "copilot" {
    subnet_id = aws_subnet.copilot.id
    route_table_id = aws_route_table.copilot.id
}

