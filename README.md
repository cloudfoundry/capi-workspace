## capi workstation setup 🐋

Hello there! This repo is intended to provide light-weight setup to developing on CAPI projects.

![capi](https://im-01.gifer.com/9Y0s.gif)

## Dependencies
* Mac OSX Sierra

## Goals:
* Tooling is clear and easy to understand - where things are, what they do, how to modify them.
* Bash scripts are small, pretty and well-commented.
* Provide guidance or ability to clean up if you switch teams, or if installation fails
* Keep setup minimal - only include packages and tools that are useful on a regular or daily basis.
* It should be easy to add new things and modify this tooling.
* Users should feel safe running this tooling. Users include: OSS Foundation members, new
  CAPI teammates, visiting pairs, and remote team members with personal laptops
* Idempotent
* Able to be run nightly, without human intervention

## What this installation does

When running `./install.sh`:
* We install many packages via brew
* We make a lot of modifications via scripts in `setup`
* We configure bash-it to `source` everything in `bash-it` and `lib`
* `lib/environment-variables.bash` brings in everything in `scripts` by modifying the `$PATH`

`install-core.sh` takes a much different philosophy, ultimately hoping to be more friendly for developers who don't want this repository to take over their machine:
* Only installs core utilities, services, and binaries
* Does NOT install/configure any editors (nvim/vscode/intellij) or binaries that make developers' lives better (jq/rg)
* Does NOT apply any git-author configuration
* Is NOT responsible for loading in scripts that need to be `source`'d.
* Is NOT responsible for modifying your `$PATH` to include `script`

## install.sh or install-core.sh ?

install-core.sh is a subset of install.sh and is intended to be less invasive to the machine, without compromising on provisioning a workstation suitable to working on CAPI projects.

For fresh workstations, install.sh might make more sense.

For folks working on multiple projects, install-core.sh might make more sense.

For folks with existing workstations & configuration, install-core.sh might make more sense.

## Directory Overview

Description of the folders in this project:

Folder      | Description
----------- | -----------
assets      | random static files
bash-it     | all the bash-it stuff, only bash-it stuff
helpers     | random helper files
lib         | scripts that should be sourced into your shell
scripts     | scripts that can be added to your `$PATH`
setup       | executable scripts that install a thing or two

Why is `lib` separate from `bash-it`? Not everyone uses bash-it, so `lib` is similar to `scripts`, giving people a way to manually load these things in.

## Installation

```
    mkdir -p ~/workspace && cd ~/workspace
    git clone git@github.com:cloudfoundry/capi-workspace.git && cd capi-workspace
```

You can now either install via `./install.sh` or `./install-core.sh`.

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

## Contributing to this repo
* [bash-it](https://github.com/Bash-it/bash-it) We use bash-it to organize and streamline our bash settings. This includes stuff like color schemes, aliases, shell settings, and the shell prompt formatting. Adding "plugins" to `custom-bash-it-plugins` will cause them to be installed in every new shell.
