#!/bin/bash

# Define here the path to your vagrant-elk-reflex project
location=""

echo " ******************************** "
echo " *   Reflex Monitoring server   * "
echo " ******************************** "
echo ""
echo " - Starting Reflex Monitoring server from 'vagrant-elk-reflex' project"
echo "        PATH : $location"
echo ""

cd %location%
vagrant up

if errorlevel 1 (
  echo "FAILURE! Vagrant VM unresponsive..."
)

