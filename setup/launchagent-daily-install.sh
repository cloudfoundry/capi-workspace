#!/bin/bash

# do not run in non-interactive contexts
if [ ! -t 1 ] ; then
  return
fi

# to run manually in the background for debugging:
# launchctl start io.pivotal.capi-workspace.install

# install.sh at midnight and log to capi-workspace/launchagent-daily-install.log

TARGET=/Library/LaunchAgents/io.pivotal.capi-workspace.install.plist

cat << EOF | sudo tee $TARGET
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>io.pivotal.capi-workspace.install</string>
<key>Program</key>
<string>$HOME/workspace/capi-workspace/install.sh</string>
<key>StandardErrorPath</key>
<string>$HOME/workspace/capi-workspace/launchagent-daily-install.log</string>
<key>StandardOutPath</key>
<string>$HOME/workspace/capi-workspace/launchagent-daily-install.log</string>
<key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>0</integer>
    <key>Minute</key>
    <integer>1</integer>
  </dict>
</dict>
</plist>
EOF

sudo chmod 655 $TARGET

launchctl unload $TARGET
launchctl load -w -F $TARGET
