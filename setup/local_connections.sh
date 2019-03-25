x=$(grep --no-messages --no-filename CONNECTION_PREFIX ~/.profile ~/.bash_profile ~/.bashrc || true)
if [ -n "$x" ] ; then
  eval "$x"
fi
