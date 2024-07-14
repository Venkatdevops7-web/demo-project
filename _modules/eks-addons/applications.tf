resource "kubernetes_manifest" "instance_project" {
  for_each = var.instances

  field_manager {
    force_conflicts = true
  }

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"
    metadata = {
      name      = "${each.key}"
      namespace = "argocd"
    }
    spec = {
      clusterResourceWhitelist = [
        {
          group = "*"
          kind  = "*"
        },
      ]
      destinations = [
        {
          namespace = "applications-${each.key}"
          server    = "*"
        },
        {
          namespace = "argocd"
          server    = "*"
        },
      ]
      sourceRepos = [
        "*",
      ]
    }
  }
}

resource "kubernetes_manifest" "instance_application" {
  for_each = var.instances

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "base-${each.key}"
      namespace = "argocd"
    }
    spec = {
      destination = {
        namespace = "argocd"
        server    = "https://kubernetes.default.svc"
      }
      project = kubernetes_manifest.instance_project[each.key].manifest.metadata.name
      source = {
        helm = {
          values = <<-EOT
            global:
              instanceDomain: ${try(each.value.root_instance, false) ? var.cluster_domain : join(".", [each.key, var.cluster_domain])}
              baseRepoUrl: ${var.base_repo_url}
              baseRepoRevision: ${each.value.base_repo_revision}
              namespace: applications-${each.key}
              argoProject: ${kubernetes_manifest.instance_project[each.key].manifest.metadata.name}
              instanceName: ${each.key}
              
          EOT
        }
        path           = "applications/base-manifests"
        repoURL        = var.base_repo_url
        targetRevision = each.value.base_repo_revision
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true",
        ]
      }
    }
  }
}