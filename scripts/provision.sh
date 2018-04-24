#!/bin/bash
sudo mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt && \
sudo /mnt/VBoxLinuxAdditions.run --nox11 && \
sudo umount /mnt && \
sudo rm -rf /home/vagrant/VBoxGuestAdditions.iso

# Oracle Java
curl -sSLj -H "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jdk-10.0.1_linux-x64_bin.rpm http://download.oracle.com/otn-pub/java/jdk/10.0.1+10/fb4372174a714e6b8c52526dc134031e/jdk-10.0.1_linux-x64_bin.rpm && \
sudo yum install -y /tmp/jdk-10.0.1_linux-x64_bin.rpm && \
rm -rf /tmp/jdk-10.0.1_linux-x64_bin.rpm

# Visual Studio Code
curl -sSLj -o /tmp/code-1.22.2-1523551168.el7.x86_64.rpm https://go.microsoft.com/fwlink/?LinkID=760867 && \
sudo yum install -y /tmp/code-1.22.2-1523551168.el7.x86_64.rpm && \
rm -rf /tmp/code-1.22.2-1523551168.el7.x86_64.rpm
read -d '' EXTENSIONS <<-EOF
redhat.java
vscjava.vscode-maven
mgmcdermott.vscode-language-babel
dbaeumer.vscode-eslint
esbenp.prettier-vscode
ms-python.python
mkloubert.vs-deploy
alexdima.copy-relative-path
rubbersheep.gi
donjayamanne.githistory
KnisterPeter.vscode-github
christian-kohler.npm-intellisense
formulahendry.code-runner
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
HookyQR.beautify
vilicvane.es-quotes
Rubymaniac.vscode-paste-and-indent
Tyriar.sort-lines
konstantin.wrapSelection
alefragnani.project-manager
mattn.Runner
cssho.vscode-svgviewer
ryu1kn.text-marker
lukasz-wronski.ftp-sync
msjsdiag.debugger-for-chrome
EOF
for EXTENSION in ${EXTENSIONS}; do
code --install-extension ${EXTENSION} --user-data-dir=/home/vagrant/.vscode
done

curl -sSLj -o /tmp/node-v8.11.1-linux-x64.tar.xz https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.xz && \
sudo tar -xf /tmp/node-v8.11.1-linux-x64.tar.xz -C /opt && \
sudo cp -s /opt/node-v8.11.1-linux-x64/bin/* /usr/bin/ && \
rm -rf /tmp/node-v8.11.1-linux-x64.tar.xz


curl -sSLj -o /tmp/google-chrome-stable_current_x86_64.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
sudo yum install -y /tmp/google-chrome-stable_current_x86_64.rpm && \
rm -rf /tmp/google-chrome-stable_current_x86_64.rpm

curl -sSLj -o /tmp/Postman-linux-x64-6.0.10.tar.gz https://dl.pstmn.io/download/latest/linux64 && \
sudo tar -xf /tmp/Postman-linux-x64-6.0.10.tar.gz -C /opt && \
sudo cp -s /opt/Postman/Postman /usr/bin/ && \
rm -rf /tmp/Postman-linux-x64-6.0.10.tar.gz && \
cat <<-EOF | sudo tee /usr/share/applications/postman.desktop > /dev/null
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=Postman
Icon=/opt/Postman/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF

sudo yum remove -y python-requests
sudo pip install --upgrade pip
sudo pip install docker-compose
