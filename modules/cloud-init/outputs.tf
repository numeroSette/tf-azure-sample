output "object" {
  description = "(optional) describe your variable"

  # data.cloudinit_config.custom-data
  # {
  #   base64_encode = bool
  #   boundary = string
  #   gzip = bool
  #   id = string
  #   part = list of object
  #   rendered = string
  # }
  # object
  value = {
    frontend = data.cloudinit_config.frontend
    app = data.cloudinit_config.app
    database = data.cloudinit_config.database
  }
}
