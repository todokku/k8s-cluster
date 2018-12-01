#!/bin/bash
iptables -I INPUT  -p tcp --dport 111  -j REJECT
iptables -I INPUT  -p udp --dport 111  -j REJECT
iptables -I INPUT -s node-IP -p udp --dport 111  -j ACCEPT
iptables -I INPUT -s node-IP -p tcp --dport 111  -j ACCEPT
