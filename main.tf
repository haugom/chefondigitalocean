provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  #
}

resource "digitalocean_droplet" "mywebserver" {
  # Obtain your ssh_key id number via your account. See Document https://developers.digitalocean.com/documentation/v2/#list-all-keys
  ssh_keys           = [13006297]         # Key example
  image              = "${var.ubuntu}"
  region             = "${var.do_lon1}"
  size               = "512mb"
  private_networking = true
  backups            = false
  ipv6               = true
  name               = "mywebserver"

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install nginx",
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa_terraform")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}

resource "digitalocean_domain" "mywebserver" {
  name       = "myweb2.cloud.haugom.org"
  ip_address = "${digitalocean_droplet.mywebserver.ipv4_address}"
}

resource "digitalocean_record" "mywebserver" {
  domain = "${digitalocean_domain.mywebserver.name}"
  type   = "A"
  name   = "mywebserver"
  value  = "${digitalocean_droplet.mywebserver.ipv4_address}"
}
