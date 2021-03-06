Scheme finder frontend
======

[![Build Status](https://travis-ci.org/bitzesty/scheme-finder-frontend.svg)](https://travis-ci.org/bitzesty/scheme-finder-frontend)

## Hosted on Rackspace

## Deploy

### Staging

Deploys master branch

```
cap staging deploy
```

### Production

Deploys production branch

```
cap production deploy
```

### VAGRANT

Deploys master branch

```
cd <..>/bis-chef/chef
v up
v provision

# bind domain name to vagrant VM ip
sudo vim /etc/hosts
10.0.100.15       schemer_vagrant.app

cd <..>/scheme-finder-frontend
cap vangrat deploy
```

## SSH

### Staging

```
ssh schemer@
```

### Production

```
ssh schemer@
```

## Rackspace API

### Staging

```
Username:  API.user
Api key:   ask guys for the key
```

### Production

```
Username:
Api key:  ask guys for the key
```

Servers are at the UK endpoint

### SMTP Authentication:

#### Staging

```
Hostname : smtp.mailgun.org
Login    : postmaster@
Password :
```

#### Production

```
Hostname : smtp.mailgun.org
Login    : postmaster@
Password :
```

## Provision

Please read
https://github.com/bitzesty/cookbooks#to-provision-a-real-server and
copy your ssh key

### Staging

```bash
bundle exec knife solo cook 162.13.152.96 nodes/staging.json -x root
ask guys for password
```

### Production

```bash
bundle exec knife solo cook <ip> nodes/production.json -x root
ask guys for password
```
