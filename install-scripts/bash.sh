# do not run in non-interactive contexts
if [ ! -t 1 ] ; then
  return
fi

# use homebrew-provided, updated bash
echo /usr/local/bin/bash | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash
