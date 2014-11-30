# Ubuntu updates + Language pack for apt
apt-get update
apt-get install -y language-pack-en
# Requirements for Routino
apt-get install -y gcc make libc6-dev libz-dev libbz2-dev wget zip unzip apache2
# Routino install
wget http://www.routino.org/download/routino-2.7.3.tgz && tar xzf routino-2.7.3.tgz
cd routino-2.7.3/ && make && cp -a web/* /var/www/html/routino && chown -R www-data:www-data /var/www/html/routino
# Openlayers bugfix and setup
cd /var/www/html/routino/www/openlayers && \
sed -r -i -e 's/openlayers.org\/download\/OpenLayers-\$version.tar.gz/github.com\/openlayers\/openlayers\/releases\/download\/release-\$version\/OpenLayers-\$version.tar.gz/g' install.sh && \
sh -x install.sh
# Leaflet setup
cd /var/www/html/routino/www/leaflet && sh -x install.sh
# Apache2 configuration
sed -r -i -e 's/#<Directory \/srv\/>/ \
        <Directory \/var\/www\/routino> \
            AllowOverride All \
            Options +ExecCGI \
        <\/Directory> \
  \
#<Directory \/srv\/>/g' /etc/apache2/apache2.conf
service apache2 restart
echo "All set, open your browser with the URL http://localhost:8080/routino/www/routino/router.html and have fun! :)"