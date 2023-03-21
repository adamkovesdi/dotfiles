#!/bin/bash

echo Source gist
echo "https://gist.github.com/andrebrait/961cefe730f4a2c41f57911e6195e444"
echo
echo xy "Keyboards on Linux use the hid_apple driver (even in Windows/Android mode),"
echo both in Bluetooth and Wired modes. By default, this driver uses the F-keys
echo as multimedia shortcuts and you have to press Fn + the key to get the usual
echo F1 through F12 keys.
echo

echo "Do you want to fix this? (Enter/Ctrl+C)"
read
echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
