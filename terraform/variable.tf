variable "vpc_subnet_details" {
    type    = object({
        vpc_cidr = string
        vpc_name = string
        public_subnet_cidr = string
        public_subnet_name = string
        private_subnet_cidr = string
        private_subnet_name = string
    })

    default = {
        vpc_cidr = ""
        vpc_name = ""
        public_subnet_cidr = ""
        public_subnet_name = ""
        private_subnet_cidr = ""
        private_subnet_name = ""
    }
}

variable "vpc_ednsh" {
    type = bool
    default = true
}

variable "vm_name" {
    type = string
}
