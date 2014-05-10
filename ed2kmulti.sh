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
# file          : ed2kmulti.sh
# version       : 1.0
# Description   : multiline ed2k adder for amule
# License       : Apache License   Version 2.0, January 2004  
#                 http://www.apache.org/licenses/
# Usage         : before to use
#	1) configure your amulecmd
#	2) create the file userapp-amulecmd.desktop under your 
#      ~/.local/share/applications
#   3) insert this into the file
#          [Desktop Entry]
#          Name=aMuleCmd
#          Name[en_US]=userapp-amulecmd
#          Exec=/home/public/bin/ed2kmulti %u
#          Icon=amule
#          Terminal=true
#          Type=Application
#          Categories=Network;P2P;
#          Comment=A client for the eD2k network
#          MimeType=x-scheme-handler/ed2k
#------------------------------------------------------------------------------
# Release Note	
# 2014-04-04    The beginning
###############################################################################
scriptname="edk2multi"
scriptversion="1.0"
scriptauthor="Uncle Hook"
scriptyear="2014"
###############################################################################
# Functions                                                                   #
###############################################################################

#ed2k://|file|Marvel's.Agents.Of.S.H.I.E.L.D.1x13.Il.Treno.ITA.LD.WEBRip.x264-iGM.[tvu.org.ru].srt|315|966CB685B5017C5A123D26F40B26DD6B|h=JB6432J4PCTDWT7GOASDT6ZS4GAO7FUJ|/
function lp_imprint (){
#------------------------------------------------------------------------------
# Function lp_imprint
#       print the usage of the script
#------------------------------------------------------------------------------
	echo "$scriptname v$scriptversion - $scriptauthor ($scriptyear)"
	echo "-------------------------------------------------------------------------------"
}

function lp_usage (){
#------------------------------------------------------------------------------
# Function lp_usage 
#       print the usage of the script
#------------------------------------------------------------------------------
	echo "Usage:"
	echo "      ed2kmulti.sh \"<links\""
}

function lp_addlinks (){
#------------------------------------------------------------------------------
# Function lp_usage 
#       print the usage of the script
#------------------------------------------------------------------------------
	local file=$1
	while read -r line
	do
		amulecmd --command="add $line"
	done < $file
}
###############################################################################


###############################################################################
# Main Program                                                                #
###############################################################################

lp_imprint

links=$1

if [ "$links" = "" ]; then
	lp_usage
	exit -1
fi 
# store link in a temporary file
tempfile=$(mktemp) 
echo "$links" > $tempfile

# add links
lp_addlinks $tempfile

#delete temporary file
rm $tempfile
###############################################################################
