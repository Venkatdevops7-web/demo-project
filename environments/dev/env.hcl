 locals {
  environment_name = "dev"
  aws_account_id   = "211125729272"
  aws_region       = "ap-south-1"
  project_name     = "webdemo"
  name_prefix      = "${local.project_name}-${local.environment_name}"
  eks_cluster_name = "${local.name_prefix}-eks-cluster"
  cluster_domain   = "devopsdesire.com"
  base_repo_url    = "https://github.com/Venkatdevops7-web/demo-project.git"




# Instance config for argoproj and nginx ingress for env
  instances = {
    dev = {
      //  root_instance = true
      base_repo_revision = "main"
    }        
  }
  
  argo_instances = {
    "${local.environment_name}"  = {
       root_instance = false
       base_repo_revision = "main"
    }
  }


  repositories = [
    "frontend"
  ]
}
