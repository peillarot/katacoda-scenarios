grep -q moi.local /etc/bind/named.conf.local && named-checkconf && dig @127.0.0.1 www.moi.local && dig @127.0.0.1 intranet.moi.local &&  echo "done"
