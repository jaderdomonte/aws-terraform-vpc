variable "company" {}

variable "subnets_a_config" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    APP-A = {
      cidr_block        = "10.1.0.0/22"
      availability_zone = "sa-east-1a"
    },
    INFRA-A = {
      cidr_block        = "10.1.12.0/22"
      availability_zone = "sa-east-1a"
    },
    DBA-A = {
      cidr_block        = "10.1.24.0/22"
      availability_zone = "sa-east-1a"
    },
    LAMBDA-A = {
      cidr_block        = "10.1.48.0/22"
      availability_zone = "sa-east-1a"
    }
  }
}

variable "subnets_b_config" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    APP-B = {
      cidr_block        = "10.1.4.0/22"
      availability_zone = "sa-east-1b"
    },
    INFRA-B = {
      cidr_block        = "10.1.16.0/22"
      availability_zone = "sa-east-1b"
    },
    DBA-B = {
      cidr_block        = "10.1.28.0/22"
      availability_zone = "sa-east-1b"
    },
    LAMBDA-B = {
      cidr_block        = "10.1.52.0/22"
      availability_zone = "sa-east-1b"
    }
  }
}

variable "subnets_c_config" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    APP-C = {
      cidr_block        = "10.1.8.0/22"
      availability_zone = "sa-east-1c"
    },
    INFRA-C = {
      cidr_block        = "10.1.20.0/22"
      availability_zone = "sa-east-1c"
    },
    DBA-C = {
      cidr_block        = "10.1.32.0/22"
      availability_zone = "sa-east-1c"
    },
    LAMBDA-C = {
      cidr_block        = "10.1.56.0/22"
      availability_zone = "sa-east-1c"
    }
  }
}

variable "subnets_dmz_config" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    DMZ-A = {
      cidr_block        = "10.1.36.0/22"
      availability_zone = "sa-east-1a"
    },
    DMZ-B = {
      cidr_block        = "10.1.40.0/22"
      availability_zone = "sa-east-1b"
    },
    DMZ-C = {
      cidr_block        = "10.1.44.0/22"
      availability_zone = "sa-east-1c"
    }
  }
}