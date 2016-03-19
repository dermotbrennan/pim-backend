#!/bin/bash
# start vagrant and the vagrant sync tool
vagrant up
echo "⚡⚡ TIME TO BUILD COOL STUFF ⚡⚡"
vagrant gatling-rsync-auto
