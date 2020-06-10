#!/bin/bash
#
################################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	ZeroName.sh
#	https://https://github.com/Headbolt/ZeroName
#
#   This Script is designed for use in JAMF as an Extension Attribute
#		with a type set of "Integer"
#
#   - This script will ...
#       Search for the current logged in User.
#		Then Check to see if iCloud Drive is Enabled.
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.1 - 15/01/2020
#
#   - 06/01/2018 - V1.0 - Created by Headbolt
#   - 15/01/2020 - V1.1 - Updated by Headbolt
#							Split down to get Build Number
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
# Variables used by this script.
#
# Grab the current logged in username
Current_User=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')


################################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Check Logged in User Function
#
CurrentUser(){
#
if [[ $Current_User == "root" ]]
	then
		Result=$(echo "No User Logged In")
	else
		Result=$(echo "$Current_User is Logged In")
fi
#       
}
#
###############################################################################################################################################
#
# Check Logged in Users iCloud Drive Status Function
#
iCloudDrive(){
#
MOBILE_DOCUMENTS_RAW=$(defaults read /Users/$Current_User/Library/Preferences/MobileMeAccounts.plist | grep -B 1 "MOBILE_DOCUMENTS")
MOBILE_DOCUMENTS=$(echo $MOBILE_DOCUMENTS_RAW | cut -c -11)
#
if [[ $MOBILE_DOCUMENTS == "Enabled = 1" ]]
	then
		Result=$(echo "Enabled")
	else
		Result=$(echo "Disabled")
fi
#       
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
CurrentUser
#
iCloudDrive
#
/bin/echo "<result>$PortalBuildNumber</result>" # Return Result
