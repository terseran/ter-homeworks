# Creane 2 VM DB
resource "yandex_compute_instance" "db" {
    for_each = { for vm in var.each_vm : vm.vm_name => vm }
  
  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = var.vm_web_platform

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fr
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_key}"
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_nat
  }
}