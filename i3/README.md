To enable logging add the following to your /usr/share/xsessions/i3.desktop when i3 is started by your desktop manager like gdm.
```
Exec=i3 -V -d > $HOME/.i3/log-$(date + '%F-%k-%M-%S') 2>&1
```

To have nice customizable notifications remove xfce4-notifyd and add the default dunstrc to `~/.config/dunst/dunstrc'
```
# Remove xfce4-notifyd
sudo apt-get remove xfce4-notifyd
# Install and add config for dunst (http://a0726h77.blogspot.de/2013/10/no-dunstrc-found-skipping.html)
sudo apt-get install dunst
mkdir ~/.config/dunst
zcat /usr/share/doc/dunst/dunstrc.example.gz >> ~/.config/dunst/dunstrc
```
Or link to your own dunstrc.
