
sudo vi /etc/pf.conf
sudo pfctl -vnf /etc/pf.conf
sudo pfctl -E

cat <<-EOF >> /etc/pf.conf

# Restrict MINIO (backup node) access
block return in proto tcp from any to any port 9000
pass in inet proto tcp from 192.168.96.0/19 to any port 9000 no state
pass in inet proto udp from 192.168.96.0/19 to any port 9000 no state
EOF

