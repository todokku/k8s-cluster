# 1 - How to add new node to your kubernetes cluster
Edit hosts file in node-add directory and replace master with your k8s master IP.

Replace new node/nodes IP in newnodes section.

Replace your currently running GlusterFS IP in glusters section.
# 2 - Iptables configuration
Update IP list with newly added nodes.

Stop and start iptables-portmapper.service on existing nodes.

Create iptables-portmapper.service on new nodes with updated IP list.

Iptables related files should be placed in /etc/iptables path.
