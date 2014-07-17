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
# file          : pdf2cb.sh
# version       : 1.0
# Description   : convert pdf to cbr/cbz
# License       : Apache License   Version 2.0, January 2004
#                 http://www.apache.org/licenses/
# Usage         : before to use
#  1) install poppler-utils or xpdf-utils to obtain pdfimages
#------------------------------------------------------------------------------
# Rease Note
# 2014-07-17    The beginning
###############################################################################
scriptname="pdf2cb"
scriptversion="1.0"
scriptauthor="Uncle Hook"
scriptyear="2014"
###############################################################################
# Functions                                                                   #
###############################################################################

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
	echo "      pdf2cb.sh \"<file>\" [format] "
	echo ""
	echo "<file> the tile to convert"
	echo "[format]: the destination format CBR or CBZ"
	echo "          optional if omitted CBR"
	echo ""
}


function lp_error (){
#------------------------------------------------------------------------------
# Function lp_error
#       manage error message
#------------------------------------------------------------------------------
        echo "ERROR! - $1"
        echo "-------------------------------------------------------------------------------"
        echo ""
	if [ "$2" != "" ] || [ "$2" != "0" ];then
		exit $2
	fi
}

###############################################################################
# Main Program                                                                #
###############################################################################

lp_imprint

file=$(basename "$1")
dirname=$(dirname "$1")
format=${2,,}
cbfile="${file%.*}"

if [ "$file" = "" ]; then
	lp_error "missing filename" 1
fi


if [ "$format" = "" ]; then
	format="cbr"
fi

if [ "$format" != "cbr" ] && [ "$format" != "cbz" ]; then
	lp_error "wrong destination format" 2
fi

#if filename not contains full path use the current
if [ "$dirname" = "" ] || [ "$dirname" = "." ] ; then
	dirname=$(pwd)
fi

# create temporary folder
tempfile=$(mktemp -d)

#extract jpegs
echo "Images Extraction...."
pdfimages -j "$file" "$tempfile/page"

if [ $? != 0 ]; then
{
	lp_error "unknow error during images extration" 3
} fi

echo ""
echo "Images Extracted"
ls $tempfile

#
if [ "$format" = "cbr" ]; then
	rar a -m5 -ep "$dirname/$cbfile.$format" "$tempfile/page*"
fi

if [ "$format" = "cbz" ]; then
	zip -j -9 "\"$dirname/$cbfile.$format\"" "$tempfile/page*"
fi



#delete temporary folder
rm -r $tempfile

###############################################################################
