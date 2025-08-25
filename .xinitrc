setxkbmap -layout us,ara -option grp:shifts_toggle,caps:swapescape
doas mount /dev/sda6 /mnt/disk
sxhkd &
$HOME/bin/dwmstatus &
dwm
