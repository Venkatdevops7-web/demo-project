resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "kube-system"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.14.4"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.irsa_role_cert_manager.iam_role_arn
  }

  set {
    name  = "securityContext.fsGroup"
    value = "1001"
  }

  set {
    name  = "installCRDs"
    value = true
  }
}



module "irsa_role_cert_manager" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.11"

  role_name                     = "${var.name_prefix}-cert-manager"
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = local.route53_arns
  oidc_providers = {
    ex = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cert-manager"]
    }
  }
}