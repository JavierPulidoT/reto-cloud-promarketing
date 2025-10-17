locals {
  max_subnet_length = max(
    length(var.private_subnets),
  )
  nat_gateway_count = local.max_subnet_length

  # Usar `local.vpc_id` para dar una pista a Terraform de que las subredes deben eliminarse antes de que los bloques CIDR secundarios puedan estar libres.
  vpc_id = element(
    concat(
      aws_vpc.main.*.id,
      [""],
    ),
    0,
  )
}
