#!/usr/bin/env bash
set -exuo pipefail

mkdir -p /opt/cloudera/parcels
chown cloudera-scm:cloudera-scm /opt/cloudera/parcels


touch /tmp/my_log
runuser -u mysql /usr/sbin/mysqld 2>&1 | tee /tmp/my_log &
my_id=$!
( tail -f -n0 /tmp/my_log & ) | grep -m 1 "ready for connections"


echo 'cat ~/.PASSWD | grep "$(echo -e "$1\t$2")" | cut -f3' > /tmp/scm_passwd.sh
chmod +x /tmp/scm_passwd.sh

# dfs.datanode.max.locked.memory

exit 
/etc/init.d/cloudera-scm-server start

tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log &

( tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log & ) | grep -m 1 "Started Jetty server"


echo 'cat ~/.PASSWD | grep "$(echo -e "$1\t$2")" | cut -f3' > /tmp/scm_passwd.sh
chmod +x /tmp/scm_passwd.sh

# https://gist.github.com/azurecube/3bb827db631e9d51c7a2

CMNODE="a.n17.cz"
TARGET="a.n17.cz"
CLUSTER="AoJ"
ROOT_PASS="cloudera"
BASE=http://$CMNODE:7180/api/v18
CDH_VER=5.13.2
CDH_MAJOR=`echo $CDH_VER | cut -d'.' -f1`

curl -u "admin:admin" -i -H "content-type:application/json" -X PUT -d '{ "name": "mgmt" }' $BASE/cm/service

## Assign and Configure Roles
curl -X PUT -u "admin:admin" -i $BASE/cm/service/autoAssignRoles
curl -X PUT -u "admin:admin" -i $BASE/cm/service/autoConfigure


# Startup
curl -X POST -u "admin:admin" -i $BASE/cm/service/commands/start

# Setting Cluster
## Create Cluster
curl -X POST -u "admin:admin" -i \
  -H "content-type:application/json" \
  -d '{ "items": [
          {
            "name": "'$CLUSTER'",
            "version": "CDH'$CDH_MAJOR'"
          }
      ] }'  \
$BASE/clusters


## Assign Hosts
host_ids=`curl -sS -X GET -u "admin:admin" -i $BASE/hosts | grep '"hostId" :' | cut -d'"' -f 4`
for i in $host_ids
do 
  curl -X POST -u "admin:admin" -i \
    -H "content-type:application/json" \
    -d '{ "items": [ {"hostId": "'$i'"} ]}'  \
  $BASE/clusters/$CLUSTER/hosts
done


## Assign Service
curl -X POST -u "admin:admin" -i \
  -H "content-type:application/json" \
  -d '{ "items": [  {"name": "hive"     , "type": "HIVE"},
                    {"name": "sqoop"    , "type": "SQOOP"},
                    {"name": "yarn"     , "type": "YARN"},
                    {"name": "hdfs"     , "type": "HDFS"},
                    {"name": "impala"     , "type": "IMPALA"}
      ] }'  \
$BASE/clusters/$CLUSTER/services


## Assign and Configure Roles
curl -X PUT -u "admin:admin" -i $BASE/clusters/$CLUSTER/autoAssignRoles
curl -X PUT -u "admin:admin" -i $BASE/clusters/$CLUSTER/autoConfigure

## Configuring Hive metastore DB
curl -X PUT -u "admin:admin" -i \
  -H "content-type:application/json" \
  -d '{ "items": [{"name": "hive_metastore_database_host",     "value": "'$CMNODE'"},
                  {"name": "hive_metastore_database_name",     "value": "metastore"},
                  {"name": "hive_metastore_database_password", "value": "'$(/tmp/scm_passwd.sh mysql hive)'"},
                  {"name": "hive_metastore_database_port",     "value": "3306"},
                  {"name": "hive_metastore_database_type",     "value": "mysql"}
      ]}'  \
$BASE/clusters/$CLUSTER/services/hive/config

curl -X POST -u "admin:admin" -i $BASE/clusters/$CLUSTER/commands/firstRun

sleep 180

#  chown -R cloudera-scm:cloudera-scm /opt/cloudera/parcel*
/etc/init.d/cloudera-scm-server stop
# end mysql
timeout 30s kill $my_id || kill -9 $my_id || true




exit

[root@a /]# mkdir -p /var/dfs/dn
[root@a /]# chown hdfs:hdfs /var/dfs/dn
[root@a /]# mkdir -p /var/dfs/nn
[root@a /]# chown hdfs:hdfs /var/dfs/nn
[root@a /]# chown hdfs:hdfs /var/dfs/snn
chown: cannot access ‘/var/dfs/snn’: No such file or directory
[root@a /]# mkdir -p /var/dfs/snn
[root@a /]# chown hdfs:hdfs /var/dfs/snn
[root@a /]# mkdir -p impala/impalad^C
[root@a /]# chown hdfs:hdfs /var/dfs/^Cn
[root@a /]# mkdir -p /var/impala/impalad
[root@a /]# chown impala:impala impala/impalad
chown: cannot access ‘impala/impalad’: No such file or directory
[root@a /]# chown impala:impala /var/impala/impalad
[root@a /]# mkdir -p /var/yarn/nm
[root@a /]# chown hdfs:hdfs /var/yarn/nm
[root@a /]# ls /var


