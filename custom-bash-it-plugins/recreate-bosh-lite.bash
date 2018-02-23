#!/bin/bash

recreate_bosh_lite() {
  (
    set -e
    sudo true

    usage() {
      >&2 cat <<EOF
SYNOPSIS:
  Recreates your local virtualbox bosh-lite Director.
OPTIONAL ARGUMENTS:
  --keep-disk  Re-attach the existing Director's disk to new VM.
  -h           Prints this usage text.
EOF
      exit 1
    }

    green='\033[32m'
    yellow='\033[33m'
    red='\033[31m'
    nc='\033[0m'

    keep_disk=false
    set +u
    while true ; do
      if [ "$#" = 0 ]; then
        break
      fi
      case "$1" in
        --keep-disk) keep_disk=true; shift ;;
        -h)
          usage
          ;;
        *)
          >&2 echo -e "${red}Unrecognized argument '$1'!${nc}"
          usage
          ;;
      esac
    done
    set -u

    hour="$(date +%H)"
    if [ "${hour}" -lt 12 ]; then
      greeting="morning"
    elif [ "${hour}" -lt 17 ]; then
      greeting="afternoon"
    else
      greeting="evening"
    fi
    echo -e "\n${green}Good ${greeting}, let's get you a new bosh-lite!${nc}"

    old_bosh_lite_dir="$HOME/workspace/bosh-lite"

    if [ -d "${old_bosh_lite_dir}/.vagrant" ]; then
      pushd "${old_bosh_lite_dir}" > /dev/null
        set +e
        vagrant --machine-readable status | grep -q 'state,running'
        is_running="$?"
        set -e
      popd > /dev/null

      if [ "${is_running}" = "0" ]; then
        echo -e "\n${red}ERR: Looks like you have a running vagrant bosh-lite at ${old_bosh_lite_dir}. Please 'vagrant suspend' it before continuing.${nc}"
        exit 1
      fi
    fi

    deployment_repo="$HOME/workspace/bosh-deployment"
    if [ ! -d "${deployment_repo}" ]; then
      echo -e "\n${green}Fetching bosh-deployment...${nc}"
      git clone https://github.com/cloudfoundry/bosh-deployment.git \
        "${deployment_repo}"
    fi

    pushd "${deployment_repo}" > /dev/null
      git pull
    popd > /dev/null

    state_dir="$HOME/deployments/vbox"
    mkdir -p "${state_dir}"

    cat << EOF > "${state_dir}/more_memory.yml"
---
# increase RAM to give better CATs performance
# increase ephemeral_disk to untar cf-release without running out of space
- type: replace
  path: /resource_pools/name=vms/cloud_properties?
  value:
    cpus: 2
    memory: 8192
    ephemeral_disk: 32_000
EOF

    pushd "${state_dir}" > /dev/null
      bosh interpolate "${deployment_repo}/bosh.yml" \
        -o "${deployment_repo}/virtualbox/cpi.yml" \
        -o "${deployment_repo}/virtualbox/outbound-network.yml" \
        -o "${deployment_repo}/bosh-lite.yml" \
        -o "${deployment_repo}/bosh-lite-runc.yml" \
        -o "${deployment_repo}/jumpbox-user.yml" \
        -o "${deployment_repo}/uaa.yml" \
        -o "${deployment_repo}/credhub.yml" \
        -o "${state_dir}/more_memory.yml" \
        -v director_name="bosh-lite" \
        -v admin_password="admin" \
        -v credhub_cli_password="admin" \
        -v internal_ip=192.168.50.6 \
        -v internal_gw=192.168.50.1 \
        -v internal_cidr=192.168.50.0/24 \
        -v network_name=vboxnet0 \
        -v outbound_network_name=NatNetwork \
        > ./director.yml

      if [[ -f "${state_dir}/state.json" && "${keep_disk}" = "false" ]]; then
        echo -e "\n${yellow}Destroying current Bosh-Lite...${nc}"
        bosh delete-env \
           --state=./state.json \
           --vars-store ./creds.yml \
          ./director.yml
      fi

      echo -e "\n${green}Deploying new Bosh-Lite...${nc}"
      bosh create-env \
         --state=./state.json \
         --vars-store ./creds.yml \
        ./director.yml

      echo -e "\n${green}Setting up route table entries...${nc}"
      sudo route delete -net 10.244.0.0/16 192.168.50.6
      sudo route add -net 10.244.0.0/16 192.168.50.6

      echo -e "\n${green}Setting up vbox alias...${nc}"
      bosh -e 192.168.50.6 alias-env vbox \
        --ca-cert="$( bosh int ./creds.yml --path /director_ssl/ca )" \
        --client=admin \
        --client-secret=admin

      echo -e "\n${green}Uploading stemcell...${nc}"
      bosh -e vbox upload-stemcell \
        https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent
    popd > /dev/null

    echo -e "\n${green}Another successful deployment, have a nice day!${nc}"
  )
}
export -f recreate_bosh_lite
