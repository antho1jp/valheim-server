uthor: crunchprank
# version: 0.1
# date: Mar 05 2021
# 
# Credit to https://github.com/Wdrussell1/Valheim-Backup-Script for the
# framework of this script.
#

# Valhalla Server Directory
# Example: /home/steam/.config/unity3d/IronGate/Valheim
VAL_DIR=/home/janthony/.config/unity3d/IronGate/Valheim

# Worlds Save Directory
# Example: /home/steam/.config/unity3d/IronGate/Valheim/worlds
WORLD_DIR=/home/janthony/.config/unity3d/IronGate/Valheim/worlds_local

# Backup Directory
# Example: /home/steam/valheim-backups
BACKUP_DIR=/home/janthony/projects/valheim-server/valheim-backups

# World Save File Retention
# This is how many files you want to retain in your backups directory. Please
# take note that as of Valheim v0.147.3, a world save file is saved every 20
# minutes. That means that if you wanted to cover an entire 24 hour period,
# this value would need to be set to 72. Also keep in mind that each world
# save file is 28M in size. That math suggests that for a 24 hour time frame,
# or a value of 72, you should have at least 2GB of disk space available on
# your server.
RETENTION=72

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#     Do not edit below this line unless you understand what you're doing     #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Check for existing backup directory, if not, make one
if [[ ! -d $BACKUP_DIR ]]
then
        echo "The backup directory you specified does not exist. Creating it for you."
        mkdir -p $BACKUP_DIR
fi

# Variables
DATE=$(date +'%Y-%d-%m-%H_%M_%S') # e.g. 2021-04-03-17_34_15
SUM=$((RETENTION+1))

# Remove old world save files
rm -f $WORLD_DIR/*.old

# Create backup of world save files
tar -czf $BACKUP_DIR/world-backups-$DATE.tgz -C $VAL_DIR worlds/

# Remove world save files greater than the retention value
ls -dt $BACKUP_DIR/* | tail -n +$SUM | xargs rm -rf

# Error Handling
exit_status=$?
if [ $exit_status -eq 0 ]; then
  echo "World save file successfully saved at $(date +'%Y-%d-%m %H:%M:%S %Z')"
elif [ $exit_status -ge 1 ]; then
  echo "There was an error with the backup script"
fi
