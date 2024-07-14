resource "helm_release" "argocd" {
  for_each = var.argo_instances
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.51.6"
  create_namespace = true
  verify           = false

  set {
    name  = "controllor.containerSecurityContext.runAsNonRoot"
    value = true
  }
  set {
    name  = "server.containerSecurityContext.runAsNonRoot"
    value = true
  }

  set {
    name = "server.rootpath"
    value = "/"
  } 


  values = [
    <<-EOT
      server:
        ingress:
          enabled: true
          annotations:
            kubernetes.io/ingress.class: nginx
            cert-manager.io/cluster-issuer: letsencrypt-prod
            nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
            external-dns.alpha.kubernetes.io/ttl: "60"
          hosts:
            - "${try(each.value.root_instance, false) ? "argocd.${var.cluster_domain}" : join(".", ["argocd", each.key, var.cluster_domain])}"
          tls:
            - hosts:
                - "${try(each.value.root_instance, false) ? "argocd.${var.cluster_domain}" : join(".", ["argocd", each.key, var.cluster_domain])}"
              secretName: argocd-tls
          https: true
      securityContext: 
        runAsNonRoot: true
        runAsUser: 999
        runAsGroup: 999
        fsGroup: 999          
    EOT
  ]
}
