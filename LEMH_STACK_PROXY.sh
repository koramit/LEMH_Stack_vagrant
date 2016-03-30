echo "*********************************** Preparation ***********************************"
echo "*                                                                                 *"
echo "*                                                                                 *"
echo "*********************************** Preparation ***********************************"

# set HHVM repo.
export http_proxy='http://username:password@proxy-si.mahidol:8080' && wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list

# set mariadb repo.
# *** for specific version use link below. ***
# https://downloads.mariadb.org/mariadb/repositories/#mirror=nus
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get install software-properties-common
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' add-apt-repository 'deb [arch=amd64,i386] http://mirrors.bestthaihost.com/mariadb/repo/10.0/ubuntu trusty main'

# Set locale for db-conf-selections and composer work corectly.
export LC_ALL=C

# Update start here.
echo "*********************************** Update ***********************************"
echo "*                                                                            *"
echo "*                                                                            *"
echo "*********************************** Update ***********************************"
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get update

# Install git.
echo "*********************************** Git ***********************************"
echo "*                                                                         *"
echo "*                                                                         *"
echo "*********************************** Git ***********************************"
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get install git -y


# Install nginx.
echo "*********************************** Nginx ***********************************"
echo "*                                                                           *"
echo "*                                                                           *"
echo "*********************************** Nginx ***********************************"
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get install nginx -y

# Install hhvm.
echo "*********************************** HHVM ***********************************"
echo "*                                                                          *"
echo "*                                                                          *"
echo "*********************************** HHVM ***********************************"
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get install hhvm -y

# Config HHVM.
sudo /usr/share/hhvm/install_fastcgi.sh
sudo update-rc.d hhvm defaults
sudo service hhvm restart

# Install Mariadb.
echo "*********************************** MariaDB ***********************************"
echo "*                                                                             *"
echo "*                                                                             *"
echo "*********************************** MariaDB ***********************************"
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get update
sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get install debconf-utils -y

# assign MariaDB root password for automation.
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password mdb@dev'
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password mdb@dev'

sudo http_proxy='http://username:password@proxy-si.mahidol:8080' apt-get install -y mariadb-server

# Install composer.
echo "*********************************** Composer ***********************************"
echo "*                                                                              *"
echo "*                                                                              *"
echo "*********************************** Composer ***********************************"
export http_proxy='http://username:password@proxy-si.mahidol:8080' && curl -sS https://getcomposer.org/installer | php
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#need root folder setting for nginx
#sudo cp /var/www/provision/sites-available/homestay.srv /etc/nginx/sites-available/
#sudo ln -s /etc/nginx/sites-available/homestay.srv /etc/nginx/sites-enabled/
#sudo rm /etc/nginx/sites-enabled/default
#sudo service nginx restart

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