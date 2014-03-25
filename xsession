/usr/bin/xscreensaver -no-splash &
##gkrellm &
#xbindkeys &
/usr/bin/dropbox start &
#/usr/bin/enlightenment_start

export PATH="/opt/efl/bin:$PATH"
export XDG_DATA_DIRS="/opt/efl/share:$XDG_DATA_DIRS"
export PYTHONPATH="/opt/efl/lib/python2.7/site-packages:$PYTHONPATH"
gnome-settings-daemon &
/usr/bin/dropbox start &
exec /usr/bin/i3
#exec /opt/efl/bin/enlightenment_start
