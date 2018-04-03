## capi workstation setup 🐋

Hello there! This repo is meant to replace the CAPI team [sprout-wrap](https://www.github.com/cloudfoundry/sprout-capi) with some new, lighter-weight tooling.

![capi](https://im-01.gifer.com/9Y0s.gif)

### Dependencies
* Mac OSX High Sierra

### Goals:
* Tooling is clear and easy to understand - where things are, what they do, how to modify them.
* Bash scripts are small, pretty and well-commented.
* Provide guidance or ability to clean up if you switch teams, or if installation fails
* Keep setup minimal - only include packages and tools that are useful on a regular or daily basis.
* It should be easy to add new things and modify this tooling.
* Users should feel safe running this tooling. Users include: OSS Foundation members, new
  CAPI teammates, visiting pairs, and remote team members with personal laptops
* Idempotent
* Able to be run nightly, without human intervention

### Installation:
```
    mkdir -p ~/workspace && cd ~/workspace
    git clone git@github.com:cloudfoundry/capi-workspace.git && cd capi-workspace
    ./install.sh
```

### Manual steps (to be automated later)
* Open `flycut` and set it to start at login
* Open up Rubymine manually and select `License Server` and copy in the the rubymine license from the labs license server (http://omaha.pivotallabs.com:8080/licenseServer in the SF office)
  - If you are not on a Pivotal Network, you need to VPN into one in order to access this server.
* Install the `mine` cli shortcut (RubyMine -> Tools -> Create Command-line Launcher...)

### Contributing to this repo
* [bash-it](https://github.com/Bash-it/bash-it) We use bash-it to organize and streamline our bash settings. This includes stuff like color schemes, aliases, shell settings, and the shell prompt formatting. Adding "plugins" to `custom-bash-it-plugins` will cause them to be installed in every new shell.

TODO: add more instructions on adding to different parts of this setup, e.g. aliases, iterm config etc.

#### Nice-To-Haves / Future Goals:
* Cross-platform compatibility (for teammates who run Linux at home)
* Ability to select with parts to install
