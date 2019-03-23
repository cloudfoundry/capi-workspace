x=$(grep --no-messages --no-filename CONNECTION_PREFIX ~/.profile ~/.bash_profile ~/.bashrc)
if [ -n "$x" ] ; then
  eval "$x"
fi
