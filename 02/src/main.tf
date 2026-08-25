resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_network" "develop_b" {
  name = var.vpc_name_b
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.vpc_name_b
  zone           = var.zone_b
  network_id     = yandex_vpc_network.develop_b.id
  v4_cidr_blocks = var.cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_os
}
resource "yandex_compute_instance" "platform" {
  name        = local.web
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fr
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.vm_metadata["for_all"]

}

resource "yandex_compute_instance" "platform_b" {
  name        = local.db
  platform_id = var.vm_db_platform
  zone        = var.zone_b
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fr
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = true
  }

  metadata = var.vm_metadata["for_all"]

}