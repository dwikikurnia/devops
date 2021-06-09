resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_subnet_details.vpc_cidr
    tags = {
        Name = var.vpc_subnet_details.vpc_name
    }

    enable_dns_hostnames = var.vpc_ednsh
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "antrusd-internet-gateway"
    }
}

resource "aws_subnet" "subnet_public" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = var.vpc_subnet_details.public_subnet_cidr

    tags = {
        Name = var.vpc_subnet_details.public_subnet_name
    }
}

resource "aws_subnet" "subnet_private" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = var.vpc_subnet_details.private_subnet_cidr

    tags = {
        Name = var.vpc_subnet_details.private_subnet_name
    }
}

resource "aws_network_interface" "nic" {
    count   = 2

    subnet_id   = aws_subnet.subnet_public.id

    tags = {
        Name = format("antrusd-eth0-%s%d", var.vm_name, count.index+1)
    }
}

resource "aws_instance" "vm" {
    count         = 2
    ami           = "ami-089fe97bc00bff7cc"
    instance_type = "t2.micro"

    network_interface {
        network_interface_id = aws_network_interface.nic[count.index].id
        device_index         = 0
    }

    tags = {
        Name = format("antrusd-%s%d", var.vm_name, count.index+1)
    }
}

resource "aws_elb" "lb" {
    name               = "antrusd-loadbalancer"
    subnets            = [
        aws_subnet.subnet_public.id
    ]

    listener {
        instance_port     = 22
        instance_protocol = "TCP"
        lb_port           = 2222
        lb_protocol       = "TCP"
    }

    instances   = [
        for s in aws_instance.vm : s.id
    ]
}

output "lb_fqdn" {
    value = aws_elb.lb.dns_name
}
