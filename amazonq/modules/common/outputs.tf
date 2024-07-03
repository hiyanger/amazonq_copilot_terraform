# VPCIDを出力する
output "vpc_id" {
    value = aws_vpc.amazonq.id # 自分で入力
}

# サブネットIDを出力する
output "subnet_id" {
    value = aws_subnet.amazonq.id # 自分で入力
}

