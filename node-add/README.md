# 1 - Iptables configuration
Update IP list with newly added nodes in add.sh and rm.sh on all servers including gluster.

Stop and start iptables-portmapper.service on existing nodes.

Create iptables-portmapper.service with systemd on new nodes with updated IP list.

Iptables related files (add.sh, rm.sh) should be placed in /etc/iptables path.

create iptables-portmapper.service in /etc/systemd/system/ the run

```bash
systemctl enable iptables-portmapper.service & systemctl daemon-reload & systemctl start iptables-portmapper.service
```
# 2 - How to add new node to your kubernetes cluster
Edit hosts file in node-add directory and replace master with your k8s master IP.

Replace new node/nodes IP in newnodes section.

Replace your currently running GlusterFS IP in glusters section.

Run ansible with
```bash
ansible-playbook -i hosts newnode.yml
```
