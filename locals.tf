/*

locals {
  subnet_tiers = [
    { name = "Public-Web", cidr_az1 = "172.20.1.0/24", cidr_az2 = "172.20.2.0/24", map_public = true },
    { name = "Private-App", cidr_az1 = "172.20.10.0/24", cidr_az2 = "172.20.11.0/24", map_public = false },
    { name = "Private-DB", cidr_az1 = "172.20.12.0/24", cidr_az2 = "172.20.13.0/24", map_public = false }
  ]

  # Flatten all subnets into a single list for easy looping
  all_subnets = flatten([
    for tier in local.subnet_tiers : [
      { name = tier.name, cidr = tier.cidr_az1, az_index = 0, map_public = tier.map_public },
      { name = tier.name, cidr = tier.cidr_az2, az_index = 1, map_public = tier.map_public }
    ]
  ])
}
*/