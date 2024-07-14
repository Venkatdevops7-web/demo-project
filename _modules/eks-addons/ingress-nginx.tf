resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.1"
  create_namespace = true

  set {
    name  = "controller.extraArgs.enable-ssl-passthrough"
    value = true
  }

  set {
    name  = "controller.allowSnippetAnnotations"
    value = true
  }  
  
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.config.use-proxy-protocol"
    value = true
  }

  set {
    name  = "controller.config.auth-tls-secret"
    value = "basic-auth"
  }     

  set {
    name  = "controller.config.real-ip-header"
    value = "X-Forwarded-For"
  }

  set {
    name  = "controller.config.set-real-ip-from"
    value = "0.0.0.0/0"
  }

  set {
    name  = "controller.config.use-forwarded-headers"
    value = true
  }
   
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }  

}
