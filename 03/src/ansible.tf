resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web[*]   # Группа веб-серверов
    databases  = values(yandex_compute_instance.db) # Группа баз данных
    storage    = yandex_compute_instance.storage    # Группа storage
  })
  filename = "${abspath(path.module)}/hosts.ini"
}