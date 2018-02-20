## capi workstation setup 🐋

Hello there! This repo is meant to replace the CAPI team [sprout-wrap](https://www.github.com/cloudfoundry/sprout-capi) with some new, lighter-weight tooling.

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
    git clone https://github.com/cloudfoundry/capi-workspace && cd capi-workspace
    ./install.sh
```

#### Nice-To-Haves / Future Goals:
* Cross-platform compatibility (for teammates who run Linux at home)
* Ability to select with parts to install
