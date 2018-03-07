#!/usr/bin/env bash
set -exuo pipefail


function gen_passwd() {
    set +x
    local name=$1
    local user=$2
    local new_passwd=$(</dev/urandom tr -dc '12345!@,./%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c12)
    echo -e "${name}\t${user}\t${new_passwd}" >> ~/.PASSWD
    echo "$new_passwd"
}

ssh-keygen -t rsa -b 2048 -f /root/.ssh/id_rsa -N ""
cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys


touch /tmp/my_log
runuser -u mysql /usr/sbin/mysqld 2>&1 | tee /tmp/my_log &
my_id=$!

( tail -f -n0 /tmp/my_log & ) | grep -m 1 "ready for connections"


my_passwd=$(gen_passwd mysql root)
echo -e "\nY\n${my_passwd}\n${my_passwd}" | mysql_secure_installation

cat << SQL | mysql -uroot "-p${my_passwd}"
create database amon DEFAULT CHARACTER SET utf8;
grant all on amon.* TO 'amon'@'%' IDENTIFIED BY '$(gen_passwd mysql amon)';

create database hue DEFAULT CHARACTER SET utf8;
grant all on hue.* TO 'hue'@'%' IDENTIFIED BY '$(gen_passwd mysql hue)';

create database sentry DEFAULT CHARACTER SET utf8;
grant all on sentry.* TO 'sentry'@'%' IDENTIFIED BY '$(gen_passwd mysql sentry)';

create database oozie DEFAULT CHARACTER SET utf8;
grant all on oozie.* TO 'oozie'@'%' IDENTIFIED BY '$(gen_passwd mysql oozie)';

create database metastore DEFAULT CHARACTER SET utf8;
grant all on metastore.* TO 'hive'@'%' IDENTIFIED BY '$(gen_passwd mysql hive)';

grant all on scm.* TO 'scm'@'%' IDENTIFIED BY '$(gen_passwd mysql scm)';

SQL


echo 'cat ~/.PASSWD | grep "$(echo -e "$1\t$2")" | cut -f3' > /tmp/scm_passwd.sh
chmod +x /tmp/scm_passwd.sh


echo "$(/tmp/scm_passwd.sh mysql scm)" | /usr/share/cmf/schema/scm_prepare_database.sh mysql -h localhost -uroot "-p${my_passwd}" -v --force --scm-host localhost scm scm 
# echo -e "* hard nofile 65536\n* soft nofile 65536" > /etc/security/limits.d/50-open-files.conf

# in docker with centos there is error with permission denied within su
rm /etc/security/limits.d/cloudera-scm.conf

/etc/init.d/cloudera-scm-server start

tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log &

# ( tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log & ) | grep -m 1 "Started Jetty server"
( tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log & ) | grep -m 1 "INFO ParcelUpdateService:com.turn.ttorrent.common.Torrent: Hashed"

/etc/init.d/cloudera-scm-server stop

# end mysql
timeout 30s kill $my_id || kill -9 $my_id || true


systemctl enable cloudera-scm-server
systemctl enable cloudera-scm-agent

