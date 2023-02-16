#!/bin/bash

sudo su
#cd && echo '*/5 * * * *  root cd && /usr/bin/sh shardeum_check.sh' >> /etc/crontab && /etc/init.d/cron restart

cat <<EOF > shardeum_check.sh

docker exec shardeum-dashboard operator-cli status | grep stopped
if [ \$? -eq 0 ]; then
        echo "START SHARDEUM"
        docker exec shardeum-dashboard operator-cli start
fi
EOF

chmod +x shardeum_check.sh

cd && echo '*/5 * * * *  root cd && /usr/bin/sh shardeum_check.sh' >> /etc/crontab && /etc/init.d/cron restart

# remove autostart
# gawk -i inplace '!/shardeum_check.sh/' /etc/crontab
# /etc/init.d/cron restart
