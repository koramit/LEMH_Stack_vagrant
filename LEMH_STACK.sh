echo "*********************************** Preparing ***********************************"
echo "*                                                                               *"
echo "*                                                                               *"
echo "*********************************** Preparing ***********************************"

#set hhvm repo

# siriraj : export http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' && wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -

echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
# ****************************

#set mariadb repo
# *** for specific version use link below***
# https://downloads.mariadb.org/mariadb/repositories/#mirror=nus

#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get install software-properties-common
sudo apt-get install software-properties-common

#keyserver error
#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' add-apt-repository 'deb http://download.nus.edu.sg/mirror/mariadb/repo/10.0/ubuntu trusty main'
sudo add-apt-repository 'deb http://download.nus.edu.sg/mirror/mariadb/repo/10.0/ubuntu trusty main'
# ****************************

#need for db-conf-selections and composer corectly
export LC_ALL=C

#update start here
echo "*********************************** Update ***********************************"
echo "*                                                                            *"
echo "*                                                                            *"
echo "*********************************** Update ***********************************"
#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get update
sudo apt-get update

#git
echo "*********************************** Git ***********************************"
echo "*                                                                         *"
echo "*                                                                         *"
echo "*********************************** Git ***********************************"
#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get install git
sudo apt-get install git -y

#nginx
echo "*********************************** Nginx ***********************************"
echo "*                                                                           *"
echo "*                                                                           *"
echo "*********************************** Nginx ***********************************"
#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get install nginx
sudo apt-get install nginx -y

#hhvm
echo "*********************************** HHVM ***********************************"
echo "*                                                                          *"
echo "*                                                                          *"
echo "*********************************** HHVM ***********************************"
#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get install hhvm
sudo apt-get install hhvm -y

sudo /usr/share/hhvm/install_fastcgi.sh
sudo update-rc.d hhvm defaults
sudo service hhvm restart

#need root folder setting for nginx
sudo cp /var/www/provision/sites-available/homestay.srv /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/homestay.srv /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo service nginx restart

#mariadb
echo "*********************************** MariaDB ***********************************"
echo "*                                                                             *"
echo "*                                                                             *"
echo "*********************************** MariaDB ***********************************"
#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get update
sudo apt-get update

#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get install debconf-utils
sudo apt-get install debconf-utils -y

sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password mdb@dev'
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password mdb@dev'

#siriraj : sudo http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' apt-get install mariadb-server
sudo apt-get install -y mariadb-server

# Composer and Laravel are optional
#composer
echo "*********************************** Composer ***********************************"
echo "*                                                                              *"
echo "*                                                                              *"
echo "*********************************** Composer ***********************************"
# siriraj : export http_proxy='http://matchariya.tac:matchariya@proxy-phy.mahidol:8080' && curl -sS https://getcomposer.org/installer | php
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# # or use "sudo composer create-project laravel/laravel /var/www/Laravel x.x.x" for specific version
# # Name project as Laravel
# #laravel
# echo "*********************************** Lalavel ***********************************"
# echo "*                                                                             *"
# echo "*                                                                             *"
# echo "*********************************** Lalavel ***********************************"
# #we should move to root folder first
# cd /var/www
# sudo composer create-project laravel/laravel Laravel

export PS1="\W#"
#export PS1="\u@\h \w> "

#mysql -uroot -pPASS -e "SET PASSWORD = PASSWORD('');"
# ~/.my.cnf
# [client]
# user = root
# password = s3kr1t