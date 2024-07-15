# Infrastructure with Terragrunt and Terraform
The deployment of the infrastructure is made on AWS and automated using [Terraform](https://www.terraform.io/)   

## Components
It a complete automated infrastrutre build where argocd and kubernetes are tightly integrate for seamlesss deployment

## Prerequisite

1. AWS Account Access and Secret Key.
2. Github account and PAT Token.
3. Working Domain in AWS Route53 or Delegation for Route53 if third party registrar.
4. Azure Service Connection for Git and AWS to use in Pipeline for build the infra.
5. OpenLens Installed to access kubernetes cluster in Graphic way (https://github.com/MuhammedKalkan/OpenLens/releases)

## Hierarchy to used to create resources 
1. vpc --> eks --> argocd --> eks-addons --> cluster_issuer --> ecr --> rds


## Technology Used
1. AWS EKS Cluster
2. AWS ECR for docker images
3. ArgoCD for Deployment
4. External DNS for Route53 record creation on ingress
5. Cert Manager and Let's Encrypt to Generate Certificate on Ingress Domain
6. Azure DevOps for Build Pipeline
  
## Code Repo
1. terraform branch --- having all terraform scripts
2. main branch --- having the api deployemt helm charts for argocd


## Config Changes required for build Infra
1. Replace your aws account id and region in env.hcl file (environments\dev\env.hcl)
2. Replace the github path in base_repo_url in env.hcl for argocd project base (environments\dev\env.hcl)
3. Replace the base-manifest git path for argocd project, line 15-16 (applications\base-manifests\templates\frontend.yaml)
4. Replace instance accoridng your need (environments/dev/eks/terragrunt.hcl)
5. t2.medium is mandetory because there are many pods creating in eks-addons for multiple service and it will avoid pod scheduling due to eni restriction (https://github.com/aws/amazon-vpc-cni-k8s/blob/master/misc/eni-max-pods.txt)
6. Azure DevOps Service connection and AWS Service connection create manaully
7. Adjust AzurePipeline yml file with Service connection name only


## Post Steps of Above config
1. After run build infra pipeline please create NS record for route53 from top level domain
2. After DNS delegation it will generate cert automatically
3. OpenLens install and retrieve the Argocd credentials
4. Login to ArgoCD and create repository connection for GitHub Repo with your secure PAT.
5. Refresh the ArgoCD base and now nginx app is deployed automatically

ex : argocd.dev.exmaple.com

## Exception Step for Destroy infra
 We have used the external dns to create route53 records from ingress by using argocd helm chart, so when destroy the infra then it will fail on eks-addon due to multi records created, so once its get failed we need to delete CNAME records manully and then run the destroy pipeline
