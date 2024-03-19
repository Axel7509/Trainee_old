#!/bin/bash

apt update
apt install -y nginx

PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor=“black”>
<h2><font color="gold">Build by Power of Terraform <font color="red"> v0.2</font></h2>
<br>
<p><font color="green">Server PrivateIP: <font color="aqua">$PUBLIC_IP<br><br>

<font color="gold">
<b>Version 1.0</b> 
</body>
</html>
EOF

sudo service nginx restart
 