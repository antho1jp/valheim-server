#!/bin/bash
#
# author: crunchprank
# version: 0.1
# date: Mar 05 2021
# 

#!/bin/bash
WORLD_DIR=/home/janthony/.config/unity3d/IronGate/Valheim/worlds_local
while $(true); do
  find $WORLD_DIR | entr -s ./valheim-backup.sh
done;
