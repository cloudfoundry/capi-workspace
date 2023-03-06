## capi workstation setup 🐋

Hello there! This repo is intended to provide light-weight setup to developing on CAPI projects.

![capi](https://im-01.gifer.com/9Y0s.gif)

## Dependencies
* pip

## Installation

```
    mkdir -p ~/workspace && cd ~/workspace
    git clone git@github.com:cloudfoundry/capi-workspace.git && cd capi-workspace
```

You can now set up by doing the following:
1. create gcp machine `gcloud compute instances create capi-ws-<your-ws-name> --zone 'us-central1-a' --source-machine-image 'capi-ws-image-latest' --project 'cf-capi-arya'`
1. ssh onto said machine `gcloud compute ssh --zone "us-central1-a" "pivotal@capi-ws-<your-ws-name>" --project "cf-capi-arya"  --ssh-flag="-A"`
1. when you're done delete you gcp machine `gcloud compute instances delete capi-ws-<your-ws-name> --zone "us-central1-a" --project "cf-capi-arya" -q`

**Make sure you ssh in as the "pivotal" user** 

## Adding nvim plugins
We use vimPlug to manage our plugins. Add the plugin to init.vim. Declare your plugin in the top section between plug#begin and plug#end. Add configuration for your plugin in the lua section between lua <<EOF and EOF.


## Modifying general vim behavior
Add configuration in the Standard Vim Config section of init.vim


## Contributing to this repo

* [bash-it](https://github.com/Bash-it/bash-it) We use bash-it to organize and streamline our bash settings. This includes stuff like color schemes, aliases, shell settings, and the shell prompt formatting. Adding "plugins" to `custom-bash-it-plugins` will cause them to be installed in every new shell.

## What this installation does

Stuff, important stuff.  Stuff that makes a difference.

## Directory Overview

Description of the folders in this project:

Folder           | Description
---------------- | -----------
assets           | random static files
bash-it          | all the bash-it stuff, only bash-it stuff
helpers          | random helper files
lib              | scripts that could be sourced into your shell
bin              | scripts that can be added to your `$PATH`
install-scripts  | executable scripts that install a thing or two

Why is `lib` separate from `bash-it`? Not everyone uses bash-it, so `lib` is similar to `scripts`, giving people a way to manually load the things they care about in. For example, one may manually (and minimally) load in capi-workspace content by sourcing a file like this in their `.bash_profile`:

```bash
❯ bat bash_sources/load_capi_workspace.zsh
───────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
       │ File: bash_sources/load_capi_workspace.zsh
───────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1   │
   2   │ source ~/workspace/capi-workspace/lib/pullify.bash >/dev/null
   3   │ source ~/workspace/capi-workspace/lib/target-bosh.bash >/dev/null
   4   │ source ~/workspace/capi-workspace/lib/claim-bosh-lite.bash >/dev/null
   5   │ source ~/workspace/capi-workspace/lib/unclaim-bosh-lite.bash >/dev/null
   6   │ source ~/workspace/capi-workspace/lib/deploy_only_new_capi.bash >/dev/null
   7   │
   8   │ export PATH="$PATH:$HOME/workspace/capi-workspace/bin"
───────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```
