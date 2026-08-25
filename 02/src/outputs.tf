output "all_vm" {

  value = [
    { vm_web = ["instance_name = ${yandex_compute_instance.platform.name}", "external_ip = ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", "fqdn = ${yandex_compute_instance.platform.fqdn}"] },
    { vm_db = ["instance_name = ${yandex_compute_instance.platform_b.name}", "external_ip = ${yandex_compute_instance.platform_b.network_interface[0].nat_ip_address}", "fqdn = ${yandex_compute_instance.platform_b.fqdn}"] }

  ]
}