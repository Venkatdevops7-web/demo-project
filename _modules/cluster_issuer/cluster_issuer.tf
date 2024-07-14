
resource "kubernetes_manifest" "clusterissuer_letsencrypt_prod" {

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-prod"
    }
    spec = {
      acme = {
        email = "pawan4devops@gmail.com"
        privateKeySecretRef = {
          name = "letsencrypt-prod"
        }
        #server = "https://acme-v02.api.letsencrypt.org/directory"                      #production
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"               #staging, non-prod
        solvers = [
          {
            dns01 = {
              route53 = {
                region = var.aws_region
              }
            }
          },
        ]
      }
    }
  }
}