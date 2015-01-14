To enable logging add the following to your /usr/share/xsessions/i3.desktop when i3 is started by your desktop manager like gdm.
    Exec=i3 -V -d > $HOME/.i3/log-$(date + '%F-%k-%M-%S') 2>&1
