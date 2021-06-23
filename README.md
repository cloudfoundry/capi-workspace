## capi workstation setup 🐋

Hello there! This repo is intended to provide light-weight setup to developing on CAPI projects.

![capi](https://im-01.gifer.com/9Y0s.gif)

## Dependencies
* Mac OSX Sierra
* pip

## Installation

```
    mkdir -p ~/workspace && cd ~/workspace
    git clone git@github.com:cloudfoundry/capi-workspace.git && cd capi-workspace
```

You can now either install via `./install.sh` or `./install-core.sh`.

Or curl the bootstrap script, which will create the `workspace` directory and clone this repo for you.
This is primarily intended for quickly setting up virtual workstations.

```
bash <(curl -s https://raw.githubusercontent.com/cloudfoundry/capi-workspace/main/bootstrap.sh)
```
**Make sure you ssh in as the "pivotal" user** 

## Manual steps (to be automated later)
* Open System Preferences / Users & Groups / <user> / Login Items
    * Add `flycut` from Applications
    * Add `spectacle` from Applications
* Log out/Log in
    * This will cause Flycut and Spectacle to run and ask for permissions
* Open up Rubymine manually and select `License Server` and copy in the the rubymine license from the labs license server (http://omaha.pivotallabs.com:8080/licenseServer in the SF office)
  - If you are not on a Pivotal Network, you need to VPN into one in order to access this server.
* Install the `mine` cli shortcut (RubyMine -> Tools -> Create Command-line Launcher...)
* If you are using Goland do the same two previous steps for Goland
* If you have access to the private CAPI backlog, add a secure note called `tracker_api_token` to LastPass with your Pivotal Tracker API token. This token will be used in scripts such as `claim_bosh_lite` to pull story titles currently in flight.

## Contributing to this repo

* kindly consider when a change is worth making to `install-core.sh` versus `install.sh`.
* [bash-it](https://github.com/Bash-it/bash-it) We use bash-it to organize and streamline our bash settings. This includes stuff like color schemes, aliases, shell settings, and the shell prompt formatting. Adding "plugins" to `custom-bash-it-plugins` will cause them to be installed in every new shell.

## What this installation does

`install-core.sh`: intended to be more friendly for developers who don't want this repository to take over their machine. This is intended to be the minimal set of things required for working with a CAPI repository.
* Only installs core utilities, languages, services, and binaries.
* Is NOT responsible for installing & configuring any editors (nvim/vscode/intellij)
* Is NOT responsible for installing tools for improving developer workflows (jq/rg)
* Is NOT responsible for applying any git configuration
* Is NOT responsible for loading in scripts that need to be `source`'d.
* Is NOT responsible for modifying your `$PATH` to include `script`

`./install.sh`: runs `install-core.sh` and configures the machine with many more packages/preferences

## install.sh or install-core.sh ?

`install-core.sh` is a subset of `install.sh` and is intended to be less invasive to the machine, without compromising on provisioning a workstation suitable to working on CAPI projects.

For fresh workstations && full-time CAPI developers, install.sh might make more sense.

For folks working on multiple projects, `install-core.sh` might make more sense.

For folks with existing workstations & configuration, `install-core.sh` might make more sense.

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
