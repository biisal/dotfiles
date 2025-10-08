#!/bin/bash

SSID=$(iwgetid -r)
IP=$(hostname -i)

echo "$SSID::$IP"

