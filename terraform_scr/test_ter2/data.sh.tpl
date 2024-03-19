#!/bin/bash

apt update
apt install -y nginx

PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

cat <<EOF > /var/www/html/index.html
<html>
<h2> Build by Power of terraform <font color="red"> v0.2</font></h2><br>
Owner ${l_name} ${f_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br> 
%{ endfor ~}

</html>
EOF

sudo service nginx restart
