variable "vpc_cidr_blocks" {
  description = "List of CIDR blocks for the VPCs"
  type        = list(string)
  default     = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

module "seoul"{
    source = "./modules/seoul"
    vpc_cidr_block  = var.vpc_cidr_blocks[0]
}

