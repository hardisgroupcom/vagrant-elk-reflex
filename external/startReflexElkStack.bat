ECHO OFF

REM Define here the path to your vagrant-elk-reflex project
set location=""

ECHO " ******************************** "
ECHO " *   Reflex Monitoring server   * "
ECHO " ******************************** "
ECHO ""
ECHO " - Starting Reflex Monitoring server from 'vagrant-elk-reflex' project"
ECHO "        PATH : %location%"
ECHO ""

cd /d %location%
vagrant up

if errorlevel 1 (
  ECHO FAILURE! Vagrant VM unresponsive...
  pause
)

