#!/bin/bash
# Turn the monitors off after 10 minutes idle. No auto-suspend on the desktop.
swayidle -w \
    timeout 600 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors'
