#!/bin/bash


echo "=============================Dashboard============================================================="
- VM_NAME="VM01"
- CPU="1"
- MEMORY="4G"
- DISK="5G"
- CLOUD_INIT_FILE="config/cloud-init.yaml"
- ls -l /var/snap/multipass/common/multipass_socket #
- |
  if [ "$( sudo multipass list | grep -c "$VM_NAME")"   -ne 0  ] 2>/dev/null; then
    echo "VM: $VM_NAME is Provisioned"
  else
    echo "VM: $VM_NAME Yet To Be Provisioned."
  fi
- echo "$VM_NAME  provision started"
- start=$(date +%s)
- sudo multipass launch -c"$CPU" -m"$MEMORY" -d"$DISK" -n "$VM_NAME" lts --cloud-init "$CLOUD_INIT_FILE"
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
- sudo multipass list
# - sudo multipass shell "$VM_NAME"
- sudo multipass delete "$VM_NAME" && sudo multipass purge
- echo "$VM_NAME destroyed"
- sudo multipass list
echo "=============================Dashboard============================================================="
