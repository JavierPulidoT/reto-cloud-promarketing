# VPC
output "vpc_cidr" {
  description = "VPC_CIDR "
  value       = module.quickstart_networking.vpc_cidr
}
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.quickstart_networking.vpc_id
}
output "NAT1EIP" {
  description = "NAT 1 IP address"
  value       = module.quickstart_networking.NAT1EIP
}

output "PrivateSubnetCIDR" {
  description = " Private subnet 1A CIDR in Availability Zone 1"
  value       = module.quickstart_networking.PrivateSubnetCIDR
}

output "PrivateSubnetID" {
  description = " Private subnet 1A ID in Availability Zone 1"
  value       = module.quickstart_networking.PrivateSubnetID
}

output "PublicSubnetCIDR" {
  description = " Public subnet 1 CIDR in Availability Zone 1"
  value       = module.quickstart_networking.PublicSubnetCIDR
}

output "PublicSubnetID" {
  description = " Public subnet 1 ID in Availability Zone 1"
  value       = module.quickstart_networking.PublicSubnetID
}

output "S3VPCEndpoint" {
  description = " S3 VPC Endpoint"
  value       = module.quickstart_networking.S3VPCEndpoint
}

output "PrivateSubnetRouteTable" {
  description = " Private subnet 1A route table"
  value       = module.quickstart_networking.PrivateSubnetRouteTable
}

output "PublicSubnetRouteTable" {
  description = " Public subnet route table"
  value       = module.quickstart_networking.PublicSubnetRouteTable
}


