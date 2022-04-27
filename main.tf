module "vpc" {
    source = "./modules/vpc"
}

module "sg" {
    source = "./modules/securitygroups"
    vpc_id = module.vpc.vpc_id
}

module "instances" {
    source = "./modules/instances"
    websubid = module.vpc.websubid
    websgid = module.securitygroups.websgid
}

module "loadbalancer" {
    source = "./modules/loadbalancer"
    vpc_id = module.vpc.vpc_id
    lbsgid = module.securitygroups.lbsgid
    websubidlb = module.securitygroups.websgid
    lampserverid = module.instances.lampserverid

}

module "database" {
    source  = "./modules/database"
    dbsgid  = module.securitygroups.dbsgid
    db_name = module.vpc.db_name
}
