####################################
#Author:  Philipp Kogler           #
#E-Mail:  pkogler@student.tgm.ac.at#
#Date:    2.04.2016                #
#version: 0.8                      #
####################################


# !/bin/sh
# Dieses Script ladet alle notwendigen Packages/Programme
# Welche notwendig sind um psysmon erfolgreich zu installieren
# Anschließend wird psysmon aus dem parent Ordner installiert
# Dafuer muss das ganze GitHub Repository gepullt werden

# Defining Variables
COLS=`tput cols`
LIST_OF_APT_PROGRAMS="python python-dev python-pip mysql-server python-scipy python-matplotlib python-mpltoolkits.basemap python-lxml python-mysqldb python-sqlalchemy python-imaging python-cairo python-wxgtk3.0"
LIST_OF_PIP_PROGRAMS="obspy Pyro4 pymysql"

# Defining Methods
# LineBreak with specified Character for Formatting
line_break () {
        a=0
        while [ $a -lt $COLS ]
        do
                printf =
                a=`expr $a + 1`
        done
}

#Pythonwxgtk version check
apt-cache search python-wxgtk | grep 'python-wxgtk3.0'
if [ $? -eq 1 ]
then
	line_break
	echo "Using pthon-wxgtk2.8"
	line_break
	LIST_OF_APT_PROGRAMS="python python-dev python-pip mysql-server python-scipy python-matplotlib python-mpltoolkits.basemap python-lxml python-mysqldb python-sqlalchemy python-imaging python-cairo python-wxgtk2.8"	
	
else
	line_break
	echo "Using python-wxgtk3.0"
	line_break
	LIST_OF_APT_PROGRAMS="python python-dev python-pip mysql-server python-scipy python-matplotlib python-mpltoolkits.basemap python-lxml python-mysqldb python-sqlalchemy python-imaging python-cairo python-wxgtk3.0"
fi

# Check if root
if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root" 1>&2
   exit 1
fi


# Welcome Text
# Foramtierung des Welcome Textes
# Zaehler Variable a
# Invoking line_break()
apt-cache search python-wxgtk | grep 'python-wxgtk3.0'
if [ $? -eq 1 ]
        then
        echo "Using pthon-wxgtk2.8"
        LIST_OF_APT_PROGRAMS="python python-dev python-pip mysql-server python-scipy python-matplotlib python-mpltoolkits.basemap python-lxml python-mpltoolkits.basemap python-lxml python-mysqldb python-sqlalchemy python-imaging python-cairo python-wxgtk2.8"
$

        else
        echo "Using python-wxgtk3.0"
        LIST_OF_APT_PROGRAMS="python python-dev python-pip mysql-server python-scipy python-matplotlib python-mpltoolkits.basemap python-lxml python-mpltoolkits.basemap python-lxml python-mysqldb python-sqlalchemy python-imaging python-cairo python-wxgtk3.0"
$

fi



########
#INHALT#
########
echo \> SCRIPT TO INSTALL PSYSMON
echo \> Script is starting now... 
echo \>\> 1.Install all required Packages available from apt-get Package Installer
echo \>\> 2.Install seperate Libraries with pip install
echo \>\> 3.Start the setip.py Install script

# Invoking line_break ()
line_break

##########################################################################
#1.Install all required Packages available from apt-get Package Installer#
##########################################################################

echo \>\> 1.Install all required Packages available from apt-get Package Installer
line_break
echo

# apt-get update to get the latest versions
apt-get update -y 

# Installing Required Packages
apt-get install -f -y $LIST_OF_APT_PROGRAMS --assume-yes

if [[ $? > 0 ]]
then
	line_break
	echo "The command failed. Probably a package Error This Script takes python-wxhtk3.0"
	echo "Type apt-cache search python-wxgtk and check version"
	line_break
   	read -n1 -r -p "Press key to exit..." key
	exit
else
	line_break
  	echo "The command ran succesfuly, continuing with script."
	line_break
fi

# Invoking line_break ()
line_break

###############################################
#2.Install seperate Libraries with pip install#
###############################################

echo \>\> 2.Install seperate Libraries with pip install
line_break
echo

pip install $LIST_OF_PIP_PROGRAMS

# Invoking line_break ()
line_break

###############################################
#3.Install seperate Libraries with pip install#
###############################################

echo \>\> 3.Installing psysmon
line_break
echo

cd psysmon
python setup.py install

##################
#ENDED INSTALLING#
##################
line_break
echo ENDED INSTALLING
echo start psysmon by typing psysmon anywhere in console [-.-]
line_break
