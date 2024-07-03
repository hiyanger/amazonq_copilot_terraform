# VPCのIDを出力する
output "vpc_id" {
    value = aws_vpc.copilot.id
}

# サブネットIDを出力する
output "subnet_id" {
    value = aws_subnet.copilot.id
}
