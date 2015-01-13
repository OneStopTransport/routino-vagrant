# Ubuntu updates + Language pack for apt
apt-get update
apt-get install -y language-pack-en
# Requirements for Routino
apt-get install -y acl gcc make libc6-dev libz-dev libbz2-dev wget zip unzip apache2
apt-get install -y libwww-perl liburi-perl libjson-pp-perl
# Routino install
wget http://www.routino.org/download/routino-2.7.3.tgz && tar xzf routino-2.7.3.tgz
cd routino-2.7.3/ && make && cp -a web/* /var/www/ && mv /var/www/www/* /var/www/html/ && chown -R www-data:www-data /var/www/html/
# Openlayers bugfix and setup
cd /var/www/html/openlayers && \
sed -r -i -e 's/openlayers.org\/download\/OpenLayers-\$version.tar.gz/github.com\/openlayers\/openlayers\/releases\/download\/release-\$version\/OpenLayers-\$version.tar.gz/g' install.sh && \
sh -x install.sh
# Leaflet setup
cd /var/www/html/leaflet && sh -x install.sh
# Replace Great Britain with Portugal OSM and create database with it
cd /var/www/data/ && \
rm -rf temp && mkdir temp && \
sed -i -e 's/great-britain-latest.osm.bz2 europe\/ireland-and-northern-ireland-latest/portugal-latest/g' create.sh && \
sed -i -e 's/planetsplitter --error/planetsplitter --keep --tmpdir=temp --error/g' create.sh && \
sh -x create.sh && \
cd /var/www/html/routino && \
# Replace Openlayers with leaflet and change the bounds to Portugal's ones
sed -i -e 's/library: "openlayers",/\/\/library: "openlayers",/g' mapprops.js && \
sed -i -e 's/\/\/library: "leaflet",/library: "leaflet",/g' mapprops.js && \
sed -i -e 's/westedge:  -11.0,/westedge:  -9.52,/g' mapprops.js && \
sed -i -e 's/eastedge:    2.0,/eastedge:    -6.18,/g' mapprops.js && \
sed -i -e 's/southedge:  49.5,/southedge:  36.96,/g' mapprops.js && \
sed -i -e 's/northedge:  61.0,/northedge:  42.15,/g' mapprops.js
# Apache2 configuration
sed -r -i -e 's/#<Directory \/srv\/>/ \
<Directory \/var\/www\/html\/routino> \
    AllowOverride All \
    Options +ExecCGI \
<\/Directory> \
\
#<Directory \/srv\/>/g' /etc/apache2/apache2.conf
chown -R www-data:www-data /var/www/
a2enmod cgi && service apache2 restart
echo "All set, open your browser with the URL http://localhost:8080/routino/router.html and have fun! :)"