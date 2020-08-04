#!/usr/bin/bash
curl -I localhost:7800 && \
curl --unix-socket /tmp/lmap.socket http://localhost/admin/ready | grep "OK" && \
curl -I -s -L --unix-socket /tmp/lcp.socket http://dummyHostname/admin/ready | grep "OK"
