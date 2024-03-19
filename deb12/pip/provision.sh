
# edit to change the username this provisioner runs as
# this script assumes their $HOME is /home/${USER}

USER=vagrant

# the Vagrantfile sets privileged: false
# so we need to use sudo occasionall here
# but fortunately this os has vagrant sudo-enabled

# dpkg we'll need, first required packages
# then also some useful utilities and old-school rsyslog
sudo apt-get update \
    && sudo apt-get install -y python3-pip python3-venv \
          sqlite3 wget rsyslog vim git

# tilde expansion is ok here
python3 -m venv ~/weewx-venv \
    && source ~/weewx-venv/bin/activate \
    && pip3 install wheel \
    && pip3 install weewx wheel \
    && weectl station create --no-prompt \
    && sed -i -e s:debug\ =\ 0:debug\ =\ 1: ~/weewx-data/weewx.conf 

# optionally uncomment to add Belchertown skin
git clone https://github.com/poblabs/weewx-belchertown.git
weectl extension install -y weewx-belchertown

# install the rsyslogd hook and reset the logging daemon
sudo cp ~/weewx-data/util/rsyslog.d/weewx.conf /etc/rsyslog.d/weewx.conf \
    && sudo systemctl restart rsyslog

# install and configure nginx and connect it to weewx
sudo apt-get install -y nginx
sudo mkdir /var/www/html/weewx
sudo chown ${USER}:${USER} /var/www/html/weewx
ln -s /var/www/html/weewx /home/${USER}/weewx-data/public_html

# set up logrotate to match
sudo cp ~/weewx-data/util/logrotate.d/weewx /etc/logrotate.d/weewx

# set up systemd and start weewx up
sudo sh /home/${USER}/weewx-data/scripts/setup-daemon.sh
sudo systemctl start weewx

