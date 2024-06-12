## CAPI Workstation Helpers 🐋

Hello there! This repo is intended to help with development work on CAPI
projects.

![capi](https://im-01.gifer.com/9Y0s.gif)


## Directory Overview

Description of the folders in this project:

Folder           | Description
---------------- | -----------
assets           | random static files
bash-it          | all the [bash-it](https://github.com/Bash-it/bash-it) stuff, only bash-it stuff
helpers          | random helper files
lib              | scripts that could be sourced into your shell
bin              | scripts that can be added to your `$PATH`
install-scripts  | executable scripts that install a thing or two

Why is `lib` separate from `bash-it`? Not everyone uses bash-it, so `lib` is
similar to `scripts`, giving people a way to manually load the things they care
about in.

## Minimal Install

One may manually (and minimally) load in capi-workspace content by including
the following in their `~/.zshrc` (or equivalent):

```bash
source <(cat $HOME/workspace/capi-workspace/lib/*) > /dev/null
path+=("$HOME/workspace/capi-workspace/bin")
```

## CAPI Helper Commands

This table is generated from `assets/capidoc.yml`. It is dynamically available
in your terminal using the `capi` command.

```
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
file-system
    v                   		 Open matching location in vim (fasd -e vim)
    z                   		 Change current directory to directory matching provided pattern (ex: z ng)
git
    fixcommitter        		 Cleans up committer/author after a rebase
    g                   		 git status
    gd                  		 git diff
    gdc                 		 git diff --cached
    git-open            		 Open a git repo in your browser, courtesy of Paul Irish.
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
    generate_integration_config 		 Create an integration_config.json for running CATS against current bosh target.
    run_bridge_tests    		 Run Bridge unit tests
    sits                		 Runs sits against a bosh lite
workspaces
    capi-workspaces     		 List and connect to existing K8s CAPI workspaces
    create-capi-workspace 		 Create a CAPI workspace in K8s cluster
```

## Using the Bosh Lite Pool

As a perk, [CAPI
approvers](https://github.com/cloudfoundry/community/blob/main/toc/working-groups/app-runtime-interfaces.md)
get access to a pool of cf-deployment environments, deployed on bosh lites in a
CFF-managed IaaS account. These environments are displosable, and are only
intended for development use.

Though it is technically possible to use the pool without them, there are a
number of convenience scripts provided by capi-workspace that make the pool
usable by humans.

### Prerequisites

- git
- Clone capi-workspace (this repo)
- Add capi-workspace scripts/functions to your shell (see installation instructions above (or below))
- Clone https://github.com/cloudfoundry/capi-env-pool

### Example Pool Dev Workflow

Claim an environment from the pool:
```
❯ claim_bosh_lite
Claiming 'distaffs'...
Writing out .envrc...
Pushing reservation to capi-env-pool...
Use 'target_bosh distaffs' to set bosh environment variables.
```

Observe that you successfully claimed the environment:
```
❯ print_env_info
Rounding up claimed environments...

* ENV *      * CLAIMED BY *  * CLAIMED ON *                  * CLAIMED SINCE *
apologia     Tim Downey      tdowney.hostname                3 weeks ago
distaffs     Greg Cobb       gcobb.hostname                  2 minutes ago
riskier      Greg Cobb       gcobb.hostname                  13 days ago
zoned        Seth Boyles     capi-ws-cc-203                  3 weeks ago
```

Set bosh environment variables in your shell to "target" that environment:
```
❯ target_bosh distaffs

Refreshing bosh lite pool state...
Already up to date.

Sourcing /.../capi-env-pool/bosh-lites/claimed/distaffs to set bosh environment variables...

Writing a capi-specific integration_config.json...
Generated /.../capi-env-pool/distaffs/integration_config.json. Enjoy!

Writing a bosh gateway ssh key...
Generated /.../capi-env-pool/distaffs/bosh.pem. Enjoy!

Setting BOSH_GW_PRIVATE_KEY, BOSH_ALL_PROXY, and CONFIG environment variables...
Success!
```

Log in to the environment with the `cf` CLI:
```
❯ target_cf
Getting CF admin password from credhub...
Setting API endpoint to https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org...
OK

API endpoint:   https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org
API version:    3.166.0

Not logged in. Use 'cf login' or 'cf login --sso' to log in.
API endpoint: https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org

Authenticating...
OK

Use 'cf target' to view or set your target org and space.
```

Create a default Organization and Space:
```
❯ bootstrap_cf
Getting CF admin password from credhub...
Setting API endpoint to https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org...
OK

API endpoint:   https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org
API version:    3.166.0

Not logged in. Use 'cf login' or 'cf login --sso' to log in.
API endpoint: https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org

Authenticating...
OK

Use 'cf target' to view or set your target org and space.
Creating org org as admin...
OK

TIP: Use 'cf target -o "org"' to target new org
API endpoint:   https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org
API version:    3.166.0
user:           admin
org:            org
No space targeted, use 'cf target -s SPACE'
Creating space space in org org as admin...
OK

Assigning role SpaceManager to user admin in org org / space space as admin...
OK

Assigning role SpaceDeveloper to user admin in org org / space space as admin...
OK

TIP: Use 'cf target -o "org" -s "space"' to target new space
API endpoint:   https://api.distaffs.app-runtime-interfaces.ci.cloudfoundry.org
API version:    3.166.0
user:           admin
org:            org
space:          space
```

Deploy the cf-deployment and capi-release versions from your dev machine:
```
❯ deploy
Uploading new release to 35.185.252.196.

Syncing bosh blobs...
bosh sync-blobs
...

Creating bosh release...
create-release --force --name capi
...

Uploading release to bosh director...
bosh upload-release --rebase
...

Deploying uploaded release...
bosh deploy cf-deployment.yml -o...
...
Succeeded
```

Make local changes and deploy a new CAPI version:
```
❯ deploy_only_new_capi
Building a new CAPI from local filesystem and deploying to 35.185.252.196.
bosh deploy <(bosh manifest) -o ...use-created-capi.yml ...
...
Succeeded
```

Release the environment for deletion, once you are done with it:
```
❯ unclaim_bosh_lite riskier
Refreshing bosh lite pool state...
Hit enter to release 'riskier'
rm 'riskier/.envrc'
Pushing the release commit to capi-env-pool...
Done!
```

## Automated Workstation Setup

If you want, there are also some opinionated scripts you can run to set up a
new computer for CAPI development. These may be useful if you are dynamically
provisioning remote workstations, or something like that.

### Dependencies
* MacOS
* pip

### Running the Installer

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

## Manual steps (to be automated later)
* Open System Preferences / Users & Groups / <user> / Login Items
    * Add `flycut` from Applications
    * Add `spectacle` from Applications
* Log out/Log in
    * This will cause Flycut and Spectacle to run and ask for permissions
* Open up Rubymine manually and enter a `License Server`
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
