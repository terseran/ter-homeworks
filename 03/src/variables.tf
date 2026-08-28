###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

# VM vars

variable "vm_web_os" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
}

variable "vm_nat" {
  type        = bool
  default     = true
}

variable "vm_preemptible" {
  type        = bool
  default     = true
}

variable "vm_web" {
  type = list(object({
    name     = string
    cores    = number
    memory   = number
    core_fr  = number
  }))
  default = [
    {
      name    = "web"
      cores   = 2
      memory  = 1
      core_fr = 5
    }
  ]
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, core_fr=number, disk_volume=number }))
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 2
      core_fr     = 20
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 1
      core_fr     = 5
      disk_volume = 15
    }
  ]
}

locals {
  public_key = file("/home/administrator/.ssh/tsa_ter.pub")
}

# Vars for task 3

variable "storage_disk" {
  type = list(object({
    name     = string
    type     = string
    size     = number
  }))
  default = [
    {
      name    = "storage-disk"
      type    = "network-hdd"
      size    = 1
    }
  ]
}

variable "vm_storage" {
  type = list(object({
    name     = string
    cores    = number
    memory   = number
    core_fr  = number
  }))
  default = [
    {
      name    = "storage"
      cores   = 2
      memory  = 1
      core_fr = 5
    }
  ]
}