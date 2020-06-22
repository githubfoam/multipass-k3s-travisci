#!/bin/bash


echo "=============================Dashboard============================================================="
- export VM_NAME="VM01"
- export CPU="1"
- export MEMORY="4G"
- export DISK="5G"
- export CLOUD_INIT_FILE="config/cloud-init-jenkins.yaml"
- VM_IMAGE="20.04"
- sudo multipass find #listing of all the available Ubuntu images
- ls -l /var/snap/multipass/common/multipass_socket #
- |
  if [ "$( sudo multipass list | grep -c "$VM_NAME")"   -ne 0  ] 2>/dev/null; then
    echo "VM: $VM_NAME is Provisioned"
  else
    echo "VM: $VM_NAME Yet To Be Provisioned."
  fi
- echo "$VM_NAME  provision started"
- start=$(date +%s)
- sudo multipass launch -c"$CPU" -m"$MEMORY" -d"$DISK" -n "$VM_NAME" "$VM_IMAGE" --cloud-init "$CLOUD_INIT_FILE"
- end=$(date +%s) &&  runtime=$((end-start))
- echo $runtime
- |
  while :
  do
      status=$(sudo multipass ls | grep "$VM_NAME"  |  awk '{print $2}')
      [ ! $status = "Running"  ] || break
      sleep 5
      echo "Waiting $VM_NAME VM to be running"
  done
- sudo multipass exec "$VM_NAME" -- tail  -n 20  /var/log/cloud-init-output.log
# - sudo multipass exec "$VM_NAME" -- service jenkins status #Verify Jenkins is running using the service command
- sudo multipass exec "$VM_NAME" -- sudo cat /var/lib/jenkins/secrets/initialAdminPassword #View the initialAdminPassword for Jenkins install
- MULTIPASS_VM_IP=$(multipass info $VM_NAME | grep 'IPv4' | awk '{print $2}') && echo $MULTIPASS_VM_IP
- sudo multipass list
# - sudo multipass shell "$VM_NAME"
- sudo multipass delete "$VM_NAME" && sudo multipass purge
- echo "$VM_NAME destroyed"
- sudo multipass list
echo "=============================Dashboard============================================================="
