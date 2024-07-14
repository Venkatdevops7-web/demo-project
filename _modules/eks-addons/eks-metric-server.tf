  resource "helm_release" "metric_server"  {
  name       = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.12.1"

  set {
    name  = "apiService.insecureSkipTLSVerify"
    value = true
  }
  
}