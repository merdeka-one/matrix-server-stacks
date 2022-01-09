# Matrix Server Stack

Simple, hassle free Matrix server stack For Ubuntu / Debian server. Dockerized using docker-compose, and provisioned using bash scripts.

Included in the stack:

1) Synapse Server
2) Ma1sd Identity Service
3) Synapse Admin (GUI)
4) Application Service Bridge Mautrix Telegram
5) Application Service Beidge Mautrix Whatsapp

# Installation

Make sure Docker is installed in the server. If not, run

``install-docker-ubuntu.sh``



1. Edit Config by running 

``step1-edit-config.sh``

These are needed in order to proceed with the setup:
a) Domain Name (Pay yearly)
b) Cloudflare Account to obscure your server IP (Free)
c) Sendgrid Account (Free)

2. Run automated setup

``step2-run-setup.sh``

3. Run to setup additional server security / port blocking (firewall)

``step3-run-firewall.sh``

4. After added the first account, we may want to promote the account to synapse admin priviledge. Run 

``step4-make-first-user-as-admin.sh``

# Special Thanks

If you like the work and would like to see future improvement on this project or similar refined projects, supports are appreciated. Thanks
