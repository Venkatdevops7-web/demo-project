include "root" {
  path = find_in_parent_folders()
}

include "modules" {
  path = "${dirname(find_in_parent_folders())}/_modules/vpc/vpc.hcl"
}

inputs = {
  cidr               = "172.18.0.0/16"
  azs                = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets    = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
  public_subnets     = ["172.18.4.0/24", "172.18.5.0/24", "172.18.6.0/24"]
  single_nat_gateway = true


}
