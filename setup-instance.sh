#!/bin/bash

main_function() {
USER='ubuntu'
NODE_VERSION='v18.15.0'

# NVM and Node
su -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash" $USER
su -c "source ~/.nvm/nvm.sh; nvm install $NODE_VERSION" $USER

# Webaverse
su -c "git clone --recurse-submodules https://github.com/webaverse/app /home/$USER/webaverse" $USER
su -c "cd /home/$USER/webaverse; PATH=/home/$USER/.nvm/versions/node/$NODE_VERSION/bin:$PATH npm install" $USER

# Webaverse service
cat <<EOT > /etc/systemd/system/webaverse.service
[Unit]
Description=systemd service start webaverse

[Service]
ExecStart=/bin/bash -c "PATH=/home/$USER/.nvm/versions/node/$NODE_VERSION/bin:$PATH exec npm run dev --prefix /home/$USER/webaverse"
User=$USER

[Install]
WantedBy=multi-user.target
EOT

# Code server
su -c "curl -fsSL https://code-server.dev/install.sh | sh" $USER

systemctl daemon-reload
systemctl enable webaverse.service
systemctl enable --now code-server@$USER
systemctl start webaverse.service code-server@$USER
systemctl start code-server@$USER
}

main_function 2>&1 >> /var/log/startup.log
