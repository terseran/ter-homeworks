# Create 3 disk 1 Gb
resource "yandex_compute_disk" "storage_disk" {
  count = 3

  name     = "${var.storage_disk[0].name}-${count.index}"
  type     = var.storage_disk[0].type
  zone     = var.default_zone
  size     = var.storage_disk[0].size
}

# Create VM storage
resource "yandex_compute_instance" "storage" {
  name        = var.vm_storage[0].name
  hostname    = var.vm_storage[0].name
  platform_id = var.vm_web_platform

  resources {
    cores         = var.vm_storage[0].cores
    memory        = var.vm_storage[0].memory
    core_fraction = var.vm_storage[0].core_fr
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  # Dynamic block connect disk
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  scheduling_policy { preemptible = var.vm_preemptible }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_nat
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_key}"
  }
}