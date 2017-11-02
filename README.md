Testing terraform, digital ocean and chef
---
I wanted to test creating resources on digital ocean using terraform and provision software using chef.

First step is to create a vm (or droplet) on digital ocean with terraform (from hashicorp).

I cloned this repo and used that file as a base:

`https://github.com/terraform-providers/terraform-provider-digitalocean/tree/master/examples/droplet`

I am also experimenting running terraform in a docker container locally instead of installing the binary on my computer. I am a geek. I have experimented doing the same with other tools, even `chef-client` and `chefdk`.

- I have exported a digital ocean token and stored it in `~/keys/keys/terraform-digitalocean.token`.
- I have created a RSA key without password and stored it in `.ssh/.ssh/id_rsa_terraform`
- I have created a executable script in `~/.local/bin/terraform`. I will include the script here and just name it `terraform.sh` if you want to have a look at it: `https://github.com/haugom/terraform/blob/master/bin/terraform.sh`
- Need to also provide certificate to talk to chef-server.
- The tags I am adding to the droplet, I have created manually firewall rules which look for these tags. Maybe I can provision firewall rules with terraform as well.
