module "resource_group" {
  source = "./modules/resource_group"
}

module "networking" {
  source         = "./modules/networking"
  resource_group = module.resource_group.object
}

module "load_balancer" {
  source         = "./modules/load_balancer"
  resource_group = module.resource_group.object
  web_subnet     = module.networking.object.web_subnet
}

module "cloud-init" {
  source               = "./modules/cloud-init"
  frontend_config_file = "${path.root}/deployment/frontend.yml"
  app_config_file      = "${path.root}/deployment/app.yml"
  database_config_file = "${path.root}/deployment/database.yml"
}

module "scale_set_web" {
  source                          = "./modules/scale_set"
  resource_group                  = module.resource_group.object
  web_subnet                      = module.networking.object.web_subnet
  load_balancer_backend_addr_pool = module.load_balancer.object.load_balancer_backend_addr_pool
  custom_data                     = module.cloud-init.object.frontend
  desired_instances               = 2
  scale_set_name                  = "web"

}