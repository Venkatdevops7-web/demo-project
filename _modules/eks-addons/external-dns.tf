  resource "helm_release" "external_dns"  {
  name       = "external-dns"
  namespace  = "kube-system"
  repository = "https://charts.bitnami.com/bitnami/"
  chart      = "external-dns"
  version    = "6.28.4"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.irsa_role_external_dns.iam_role_arn
  }

  set {
    name  = "domainFilters[0]"
    value = var.cluster_domain
  }

  set {
    name  = "aws.preferCNAME"
    value = "true"
  } 

  set {
    name  = "registry"
    value = "noop"
  }

  set {
    name  = "policy"
    value = "create-only"
  }

}


module "irsa_role_external_dns" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.11"

  role_name                     = "${var.name_prefix}-external-dns"
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = local.route53_arns
  oidc_providers = {
    ex = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }
}