#! /bin/bash

# 
#            --------------------------------------------------
#                            Ehtools Framework          
#            --------------------------------------------------
#                  Copyright (C) <2015>  <Ehtools Team>
#
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        any later version.
#
#        This program is distributed in the hope that it will be useful,
#        but WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#        GNU General Public License for more details.
#
#        You should have received a copy of the GNU General Public License
#        along with this program.  If not, see <http://www.gnu.org/licenses/>.
#    
#    
#    About Author :
#    Founder   : Ehtools Team
#    Site      : https://ehtools.pro/
#    Instagram : @ehtools_framework
#    Twitter   : @ehtools
#

CE="\e[0m"
RS="\e[1;31m"
YS="\e[1;33m"

if [[ $EUID -ne 0 ]]
then
   echo "["$RS"*"$CE"] "$RS"This script must be run as "$YS"root"$CE"" 1>&2
   exit
fi

{
chattr -i /tmp/config
chattr -i /tmp/config/config.txt
chattr -i /tmp/config/configure.txt
} &> /dev/null

{
mkdir /tmp/config
echo 0 >> /tmp/config/config.txt
echo 1 >> /tmp/config/configure.txt
} &> /dev/null

{
chattr +i /tmp/config
chattr +i /tmp/config/config.txt
chattr +i /tmp/config/configure.txt
} &> /dev/null


{
SERSE="$( cat /tmp/config/config.txt | head -n 1 )"
ESRES="$( cat /tmp/config/configure.txt | head -n 1 )"
} &> /dev/null

if [[ "$SERSE" != "$ESRES" ]]
then

{
ASESR="$( timeout -s SIGTERM 40 curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' )"
KEYEK="$( cat /etc/ehtools/root/service/ehtkey.txt )"
} &> /dev/null

if [[ "$ASESR" != "" ]]
then 

KEYKE="$( timeout -s SIGTERM 40 curl "https://raw.githubusercontent.com/dj-mobley/ehtools-config/master/ehtools.cfg" 2>/dev/null )"

if [[ "$KEYEK" != "$KEYKE" ]]
then

sleep 1
echo -e "["$RS"*"$CE"] "$RS"Failed to open session for l131.sh!"$CE""

sleep 1
exit

fi

else
sleep 1
echo -e "["$RS"*"$CE"] "$RS"Can't connect to server: There is no connection!"$CE""
sleep 1
exit
fi
fi

cd /root
git clone https://github.com/LeonardoNve/dns2proxy
cd dns2proxy
python /root/dns2proxy/dns2proxy.py
read
