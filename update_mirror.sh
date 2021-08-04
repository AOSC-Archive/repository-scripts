#!/bin/bash -e

export RUST_LOG=p_vector=info

echo 'Scanning mainline packages ...'
p-vector -c /etc/p-vector/aosc-os.toml full
find /mirror/debs/dists -type d -exec chmod o+x {} \;

echo 'Scanning retro packages ...'
p-vector -c /etc/p-vector/aosc-os-retro.toml full
find /mirror/debs-retro/dists -type d -exec chmod o+x {} \;

date +%s > /mirror/last_update

echo 'Running Topic generator ...'
RUST_LOG=info /usr/local/bin/topic-manifest -d /mirror/debs/ -p 'AOSC-Dev/aosc-os-abbs'
