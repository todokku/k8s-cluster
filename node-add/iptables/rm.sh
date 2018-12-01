#!/bin/bash
iptables -D INPUT  -p tcp --dport 111  -j REJECT
iptables -D INPUT  -p udp --dport 111  -j REJECT
iptables -D INPUT -s node-IP -p udp --dport 111  -j ACCEPT
iptables -D INPUT -s node-IP -p tcp --dport 111  -j ACCEPT
