mkdir ./certbotdir
cd ./certbotdir
sudo wget -r --no-parent -A 'epel-release-*.rpm' https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
sudo yum-config-manager --enable epel*
sudo yum repolist all
sudo yum install -y certbot python-certbot-nginx
sudo yum install -y ./epel.rpm

#MAIN
sudo certbot -i nginx -a manual --preferred-challenges dns -d *.crayonpapers.in -d crayonpapers.in -d *.crayonpapers.com -d crayonpapers.com -d *.fastholidayz.com -d fastholidayz.com

#UPLOAD NEW CERT
sudo aws s3 sync "/etc/letsencrypt/" "s3://cloud-workspace/WEB_LIPI_FBT/\!Certbot/letsencrypt/"
sudo aws s3 cp "/etc/nginx/nginx.conf" "s3://cloud-workspace/WEB_LIPI_FBT/nginx.conf"

#DOWNLOAD NEW CERTIFICATE
sudo aws s3 sync "s3://cloud-workspace/WEB_LIPI_FBT/\!Certbot/letsencrypt/" "/etc/letsencrypt/" 
sudo aws s3 cp "s3://cloud-workspace/WEB_LIPI_FBT/nginx.conf" "/etc/nginx/nginx.conf" 

# Download Local
aws s3 sync "s3://cloud-workspace/WEB_LIPI_FBT/\!Certbot/letsencrypt/" ./letsencrypt
aws s3 cp "s3://cloud-workspace/WEB_LIPI_FBT/nginx.conf" "nginx.conf" 