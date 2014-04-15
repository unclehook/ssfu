#!/bin/bash
#shutdown script
#source: http://bbs.archbang.org/viewtopic.php?id=2137

title="EXIT: What do you want to do ?"
exit_type=`zenity  --width="530" --height="220" --title="$title" --list --radiolist --column="Click Here" \
    --column="Exit Type" --column="Description" \
    FALSE "Exit" "Close Windows Manager and return to CommandLine" \
    FALSE "Logout" "Log Current User out and return to Login Screen"\
    FALSE "Reboot" "Reboot the PC"\
    TRUE "Shutdown" "Shutdown the PC"\
    | sed 's/ max//g' `
#    FALSE "Cancel" "Cancel the Exit" \

#user must select a target type (Check if they cancelled)
if [ -z "$exit_type" ]; then
    exit_type="Cancel" 
    exit
fi

echo "$exit_type" > "$EXITFILE"

######### This part takes the selection and applies it!  #############
fluxbox-remote "Exit" && sleep 1 | zenity --progress --percentage=95 --title=Logout --auto-close --auto-kill --no-cancel --width=300

