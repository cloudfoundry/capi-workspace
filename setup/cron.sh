#!/bin/bash

TARGET=/Library/LaunchAgents/io.pivotal.capi-workspace.install.plist

cat << EOF | sudo tee $TARGET
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>io.pivotal.capi-workspace.install</string>
<key>ProgramArguments</key>
<array>
  <string>$HOME/workspace/capi-workspace/install.sh</string>
</array>
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

launchctl unload $TARGET
launchctl load $TARGET
