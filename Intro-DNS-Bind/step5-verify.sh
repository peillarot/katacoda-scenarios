grep -q mondomaine.local /etc/bind/named.conf.local && named-checkconf && named-checkzone mondomaine.local /etc/bind/db.mondomaine.local && echo "done"
