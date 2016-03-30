echo "*********************************** Preparing ***********************************"
echo "*                                                                               *"
echo "*                                                                               *"
echo "*********************************** Preparing ***********************************"

# set hhvm repo.
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list

# set mariadb repo for ubuntu 14.04 trusty and MariaDB 10.0.
# *** for specific version use link below***
# https://downloads.mariadb.org/mariadb/repositories/#mirror=nus
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386] http://mirrors.bestthaihost.com/mariadb/repo/10.0/ubuntu trusty main'

# Set locale for db-conf-selections and composer work corectly.
export LC_ALL=C

# Update start here.
echo "*********************************** Update ***********************************"
echo "*                                                                            *"
echo "*                                                                            *"
echo "*********************************** Update ***********************************"
sudo apt-get update

# git.
echo "*********************************** Git ***********************************"
echo "*                                                                         *"
echo "*                                                                         *"
echo "*********************************** Git ***********************************"
sudo apt-get install git -y

# nginx.
echo "*********************************** Nginx ***********************************"
echo "*                                                                           *"
echo "*                                                                           *"
echo "*********************************** Nginx ***********************************"
sudo apt-get install nginx -y

# hhvm.
echo "*********************************** HHVM ***********************************"
echo "*                                                                          *"
echo "*                                                                          *"
echo "*********************************** HHVM ***********************************"
sudo apt-get install hhvm -y

sudo /usr/share/hhvm/install_fastcgi.sh
sudo update-rc.d hhvm defaults
sudo service hhvm restart

# MariaDB.
echo "*********************************** MariaDB ***********************************"
echo "*                                                                             *"
echo "*                                                                             *"
echo "*********************************** MariaDB ***********************************"
sudo apt-get update
sudo apt-get install debconf-utils -y

sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password mdb@dev'
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password mdb@dev'

sudo apt-get install -y mariadb-server

# Composer.
echo "*********************************** Composer ***********************************"
echo "*                                                                              *"
echo "*                                                                              *"
echo "*********************************** Composer ***********************************"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Replace nginx default server block.
# sudo cp /var/www/path/filename /etc/nginx/sites-available/
# sudo ln -s /etc/nginx/sites-available/filename /etc/nginx/sites-enabled/
# sudo rm /etc/nginx/sites-enabled/default
# sudo service nginx restart
