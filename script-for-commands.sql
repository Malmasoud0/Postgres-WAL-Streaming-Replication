steps to create replica: 
1. enter primary server: 

# primary server create replica user: 
CREATE USER replica REPLICATION LOGIN ENCRYPTED PASSWORD 'YouPassword';

2. Edit vim /etc/postgresql/main/14/postgresql.conf: 
listen_addresses = '*'          # what IP address(es) to listen on;
wal_level = replica                     # minimal, replica, or logical
hot_standby = on                        # "off" disallows queries during recovery

4. pg_hba.conf on primary: 
host    replication     replica    SecondaryIP/32           md5  # slave ip address


5. Secondary server: 
sudo -u postgres pg_basebackup -h PrimaryIP -p 5432 -U replica -D /var/lib/postgresql/14/main/ -Fp -Xs -R
