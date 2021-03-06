#!/bin/bash
###############################################################################
#      ____ ___             .__             ___ ___                __         #
#     |    |   \____   ____ |  |   ____    /   |   \  ____   ____ |  | __     #
#     |    |   /    \_/ ___\|  | _/ __ \  /    ~    \/  _ \ /  _ \|  |/ /     #
#     |    |  /   |  \  \___|  |_\  ___/  \    Y    (  <_> |  <_> )    <      #
#     |______/|___|  /\___  >____/\___  >  \___|_  / \____/ \____/|__|_ \     #
#                  \/     \/          \/         \/                    \/     #
#                                                                             #
#                                                           Uncle Hook (2014) #
###############################################################################
# file          : custom-issue.sh
# version       : 1.0
# Description   : a --maybe-- simple /etc/issue generator
# Usage         : save it on /etc/network/if-up.d/ and make it executable
# License       : Apache License   Version 2.0, January 2004  
#                 http://www.apache.org/licenses/
#------------------------------------------------------------------------------
# Release Note	
# 2014-04-04    The beginning
###############################################################################

###############################################################################
# Functions                                                                   #
###############################################################################

function lp_gen_issue() {
#------------------------------------------------------------------------------
# Function lp_gen_issue:
# This is the part you have to edit for customizing
#        Parameters: Those who serve
#------------------------------------------------------------------------------
    local d="/etc/issue"
         #         1         2         3         4         5         6         7         8
         #12345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo "::::::::::;@@#@@+@@@         Ubuntu 12.04.4 LTS"   > $d 
    echo "::::::::::'@@@+@@@+'         (\s \r \m)"          >> $d
    echo ":::::::::::,++@@+#@@ "                            >> $d
    echo "::::::::::'#@@+++++@         $1"                  >> $d
    echo "::::@,:::@@+@+@@@@#+         $2"                  >> $d
    echo ":::@@@:::@@+#@,@@ @+ "                            >> $d
    echo "::,@@@::::::;@  @,@+ "                            >> $d
    echo "::,@@@::::::@ @@@ @# "                            >> $d
    echo ":::@@,:::::#@@   .@+ "                            >> $d
    echo ":::,,:::::+@+#@@@@#+ "                            >> $d
    echo "::::::::::+@@++++++@ "                            >> $d
    echo "::::::::::,@@@@@@@#+ "                            >> $d	
    echo ":::::::::+@@@#@@@++@ "                            >> $d
    echo "::@,::::@@@@@++@@@#@ "                            >> $d
    echo ":'@:::::,@@+#@       "                            >> $d
    echo ":@@:::::::#@  + @@ @ "                            >> $d
    echo ";;@@@,:::,@.  @@@ @  "                            >> $d
    echo "::::@@@@@@@@@@:.'    "                            >> $d
    echo ":::::::+#',@ ;   @@  "                            >> $d
    echo "::::::::::::'@@@##@+         \n: \l"              >> $d
    echo ""                                                 >> $d
}

function lf_get_ip() { 
#------------------------------------------------------------------------------
# Function int_ip 
#       Parameters:
#           <device>: nic name (eth0, ecc.)
#           <IPv>   : tcp/ip version 
#                       - empty for IPv4
#                       - 6 for IPv6
#       Return: the ip address
#------------------------------------------------------------------------------
    local d="$1"
    /sbin/ip addr show $d | grep "inet$2 " | awk -F/ '{print $1}'| awk '{print $2}';
}
###############################################################################


###############################################################################
# Main Program                                                                #
###############################################################################
if [ "$METHOD" = loopback ]; then
    exit 0
fi

# Only run from ifup.
if [ "$MODE" != start ]; then
    exit 0
fi

# /etc/issue generation
lp_gen_issue "eth0: $(lf_get_ip eth0)" "eth0: $(lf_get_ip eth0 6)"
###############################################################################
