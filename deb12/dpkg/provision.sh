
# add wget and vim for ease of use
# add rsyslog to test weewx syslogging
apt-get update
apt install -y wget gnupg vim rsyslog git
#wget -qO - https://weewx.com/keys-old.html | \
wget -qO - https://weewx.com/keys.html | \
    gpg --dearmor --output /etc/apt/trusted.gpg.d/weewx.gpg
echo "deb [arch=all] https://weewx.com/apt/python3 buster main" | tee /etc/apt/sources.list.d/weewx.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y weewx

# install the rsyslogd hook and reset the logging daemon
sudo cp /etc/weewx/rsyslog.d/weewx.conf /etc/rsyslog.d/weewx.conf \
    && sudo systemctl restart rsyslog

# set up logrotate to match
sudo cp /etc/weewx/logrotate.d/weewx /etc/logrotate.d/weewx

# add belchertown skin and restart weewx
git clone https://github.com/poblabs/weewx-belchertown.git
sudo weectl extension install -y weewx-belchertown
sudo systemctl restart weewx


