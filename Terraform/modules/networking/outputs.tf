# VPC
output "vpc_cidr" {
  description = "VPC_CIDR "
  #value       = aws_vpc.main[count.index].cidr_block
  value = concat(aws_vpc.main.*.cidr_block, [""])[0]
}
output "vpc_id" {
  description = "The ID of the VPC"
  #value       = aws_vpc.main[count.index].id
  value = concat(aws_vpc.main.*.id, [""])[0]
  #value = aws_vpc.main.id
}
output "private_subnets" {
  description = "List of IDs of privateA subnets"
  value       = aws_subnet.private.*.id
}

output "public_subnets" {
  description = "List of IDs of privateB subnets"
  value       = aws_subnet.public.*.id
}
output "NAT1EIP" {
  description = "NAT 1 IP address"
  value       = try(aws_eip.nat[0].public_ip, "")
}

output "PrivateSubnetCIDR" {
  description = "Private subnet 1A CIDR in Availability Zone 1"
  value       = try(aws_subnet.private[0].cidr_block, "")
}

output "PrivateSubnetID" {
  description = "Private subnet 1A ID in Availability Zone 1"
  value       = try(aws_subnet.private[0].id, "")
}

output "PublicSubnetCIDR" {
  description = "Public subnet 1 CIDR in Availability Zone 1"
  value       = try(aws_subnet.public[0].cidr_block, "")
}

output "PublicSubnetID" {
  description = "Public subnet 1 ID in Availability Zone 1"
  value       = try(aws_subnet.public[0].id, "")
}

output "S3VPCEndpoint" {
  description = "S3 VPC Endpoint"
  value       = aws_vpc_endpoint.s3.*.id
}

output "PrivateSubnetRouteTable" {
  description = "Private subnet 1A route table"
  value       = try(aws_route_table.private[0].id, "")
}

output "PublicSubnetRouteTable" {
  description = "Public subnet route table"
  value       = aws_route_table.public.*.id
}

