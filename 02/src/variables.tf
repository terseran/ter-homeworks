###cloud vars


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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGK0r7yWn7q/CCvBDgbl2KIhTzF4PEJLNvRDY4dpw23P administrator@nix-tsa"
  # default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSPOWUOiBFgxi99ATVVm6C6SCCnfqo9L3/DVgsa6SXp administrator@nl-vm"
  description = "ssh-keygen -t ed25519"
}
