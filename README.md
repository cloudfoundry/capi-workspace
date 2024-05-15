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

## CAPI Commands

This table is generated from `assets/capidoc.yml`. It is dynamically available
in your terminal using the `capi` command.

```
auth
    load-key            		 Loads the an ssh key in the currently logged in lastpass called "github-private-key".  Run eval $(ssh-agent) if it fails
backup-restore
    compare_db_rows     		 Compares counts of two db's rows to validate backup & restore
bosh-deploy
    create_and_deploy   		 Create a capi release, upload to current bosh target, and deploy with default ops files (interactive)
    create_and_upload   		 Create a capi release and upload to current bosh target
    deploy              		 Create a capi release, upload to current bosh target, and deploy with default ops files (non interactive)
    deploy_only_new_capi 		 Deploy just the current CAPI to current bosh target
    quick_deploy        		 Quickly upload changes in cloud_controller_ng to relevant vms and restart"
bosh-lite-pool
    attach_debugger     		 Attaches the rubymine debugger to your bosh lite
    bootstrap_cf        		 Target a CF, creates an org, space, and targets them
    cf_admin_password   		 Get the CF admin password for a current bosh target (requires credhub)
    cfu                 		 Alias for seed_users
    claim_bosh_lite     		 Claim an available bosh lite CF
    gcs_to_claimed      		 Convert bosh-lite environment files stored in gcs to a claimed bosh-lite
    mysql_bosh_lite     		 Connect to current bosh target's MySQL DB
    print_env_info      		 List all the claimed bosh-lites in the pool
    psql_bosh_lite      		 Connect to current bosh target's MySQL DB
    rebootstrap_cf      		 Delete the 'org' org then call bootstrap_cf. For cleaning the slate.
    seed_users          		 Add users of every role to the current org and space
    target_bosh         		 Target a bosh environment from the pool
    target_cf           		 Change cf cli target to the cloud foundry deployed on currently targeted bosh (hint: use "target_bosh" first).
    target_uaa          		 Change uaac target to currently targeted bosh and login as admin
    unclaim_bosh_lite   		 Return a bosh lite CF back to the pool
    which_bosh          		 Print which bosh environment is currently targeted
capi-release-author
    sync_package_specs  		 Add go submodule dependencies to bosh package specs
    sync_submodule_config 		 Sync git submodules with go dependencies using gosub
    unused_blobs        		 Detects unused blobs from the blobs.yml file
ci
    set_capi_pipeline   		 Set the capi pipeline to your local config file (fly set-pipeline)
    watch_cc_units      		 Watch CAPI CI unit tests. For a specific run, -b build_number (fly watch)
file-system
    v                   		 Open matching location in vim (fasd -e vim)
    z                   		 Change current directory to directory matching provided pattern (ex: z ng)
git
    commit_with_shortlog 		 Git commit with a staged_shortlog
    fixcommitter        		 Cleans up committer/author after a rebase
    g                   		 git status
    gd                  		 git diff
    gdc                 		 git diff --cached
    pullify             		 Pull down all PRs for current git repo as branches
    staged_shortlog     		 Get commit shortlogs and authors from submodule changes
    update              		 Update all the git submodules
    which_capi          		 Given a cloud_controller_ng commit, print which version of capi-release it first appears in
ruby-dev
    b                   		 bundle exec
    bake                		 bundle exec rake
    gi                  		 gem install
    mybake              		 DB=mysql bundle exec rake
    pgbake              		 DB=postgres bundle exec rake
testing
    baras               		 Runs baras with local integration_config
    cats                		 Runs cats with local integration_config
    cats_cleanup        		 Deletes builpacks, orgs, quotes, and service brokers in a targeted CF
    check_certificate_expirations 		 Reads YAML files, checks for expired (or premature) certs. Useful for pipeline troubleshooting
    delete_orgs         		 Delete all orgs for current cf target
    run_bridge_tests    		 Run Bridge unit tests
    sits                		 Runs sits against a bosh lite
workspaces
    capi-workspaces     		 List and connect to existing K8s CAPI workspaces
    create-capi-workspace 		 Create a CAPI workspace in K8s cluster
```
