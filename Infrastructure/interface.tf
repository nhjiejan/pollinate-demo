# AKS


# Postgres
output "postgres_fqdn" {
  value = azurerm_postgresql_server.postgresdb.fqdn
}

output "kube_host" {
  value = module.aks.host
}

output "kube_config_raw" {
  value = module.aks.kube_config_raw
  sensitive = true
}

// output "client_key" {
//   value = "${module.aks.client_key}"
// }

// output "client_certificate" {
//   value = "${module.aks.client_certificate}"
// }

// output "cluster_ca_certificate" {
//   value = "${module.aks.cluster_ca_certificate}"
// }


