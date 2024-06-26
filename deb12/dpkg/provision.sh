
#------------------------------------------------------
# this script calls 'sudo' below to do the privileged
# tasks required to do a weewx installation. Afterward
# weewx will run as user 'weewx'.  You may need to use
# sudo to view the log in /var/log/weewx/weewxd.log
# after weewx creates it....
#------------------------------------------------------

# install some possibly missing packages depending on your base os
#  - wget and gnupg for the dpkg key
#  - git and vim for ease of use
#  - rsyslog for simpler weewx syslogging
#  - nginx for a simple to configure webserver

echo "...installing other packages..."
sudo apt-get update
sudo apt install -y wget gnupg vim rsyslog git nginx

echo "...setting up to use weewx repo..."
wget -qO - https://weewx.com/keys.html | \
    sudo gpg --dearmor --output /etc/apt/trusted.gpg.d/weewx.gpg
echo "deb [arch=all] https://weewx.com/apt/python3 buster main" | sudo tee /etc/apt/sources.list.d/weewx.list

echo "...installing weewx in simulator mode..."
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y weewx

# uncomment to set debug=1
   echo "...setting debug=1..."
   sudo sed -i -e s:debug\ =\ 0:debug\ =\ 1: /etc/weewx/weewx.conf

# uncomment to add belchertown skin
   echo "...installing belchertown skin..."
   sudo weectl extension install -y https://github.com/poblabs/weewx-belchertown/releases/download/weewx-belchertown-1.3.1/weewx-belchertown-release.1.3.1.tar.gz

# install the rsyslogd hook and reset the logging daemon
echo "...configuring rsyslog and logrotate..."
sudo cp /etc/weewx/rsyslog.d/weewx.conf /etc/rsyslog.d/weewx.conf \
    && sudo systemctl restart rsyslog
sudo cp /etc/weewx/logrotate.d/weewx /etc/logrotate.d/weewx

# make weewx output directory and set permissions to be able to write to it
echo "...setting up the webserver directory..."
sudo mkdir -p /var/www/html/weewx
sudo chown -R weewx:weewx /var/www/html/weewx

echo "...restarting weewx..."
# restart weewx to make weewx.conf edits take effect
sudo systemctl restart weewx

echo "...done..."

