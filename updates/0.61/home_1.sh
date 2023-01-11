#!/bin/bash

pre_update()
{
   print_log $LOG_FILE "INFO" "Executing pre_update()"
}

update()
{
   print_log $LOG_FILE "INFO" "Executing update()"

}

post_update()
{
   print_log $LOG_FILE "INFO" "Executing post_update()"
}

# ******************************************************************************************


LOG_FILE="/roms/logs/retrooz_update_0_61.log"

# Clean the update log file
sudo rm -f $LOG_FILE
touch $LOG_FILE

# Configure ES commons variables
. es-log_scripts 1 $LOG_FILE

UPDATE_MESSAGE_FILE="$ES_HOME_PATH/update_result_message.txt"


exit_execution()
{
    local return=$1
    print_log $LOG_FILE "INFO" "##### Exit executing update, exit code: '$return' #####"
    exit $return
}

pre_update
if [ $? -eq 1 ]; then
   # fail
   print_log $LOG_FILE "INFO" "Execute post_update() failed"
   exit_execution 1
fi

update
if [ $? -eq 1 ]; then
   # fail
   print_log $LOG_FILE "INFO" "Execute update() failed"
   exit_execution 1
fi


post_update
if [ $? -eq 1 ]; then
   # fail
   print_log $LOG_FILE "INFO" "Execute post_update() failed"
   exit_execution 1
fi

exit_execution 0




############################################################################################################################################





   echo "Backup files" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo mv /opt/mupen64plus/ /opt/mupen64plus-update-0_61_beta1.bak/
   sudo cp -f /home/odroid/.config/mupen64plus/mupen64plus.cfg -v /home/odroid/.config/mupen64plus/mupen64plus.cfg.update-0_61_beta1.bak
   sudo cp -f /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update-0_61_beta1.bak

   echo "Remove 'kernel' file per dispositive" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo rm -f /opt/.retrooz/oga/Image
   sudo rm -f /opt/.retrooz/oga1/Image
   sudo rm -f /opt/.retrooz/ogs/Image
   sudo rm -f /opt/.retrooz/rgb10maxtop/Image
   sudo rm -f /opt/.retrooz/rgb10max2top/Image
   sudo rm -f /opt/.retrooz/rgb10maxnative/Image
   sudo rm -f /opt/.retrooz/rgb10max2native/Image

   echo "Remove 'ogage' file per dispositive" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo rm -f /opt/.retrooz/oga/ogage
   sudo rm -f /opt/.retrooz/oga1/ogage
   sudo rm -f /opt/.retrooz/ogs/ogage
   sudo rm -f /opt/.retrooz/rgb10maxtop/ogage
   sudo rm -f /opt/.retrooz/rgb10max2top/ogage
   sudo rm -f /opt/.retrooz/rgb10maxnative/ogage
   sudo rm -f /opt/.retrooz/rgb10max2native/ogage

   echo "Remove 'Moonlight' erroneous rescue path file per dispositive" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo rm -rf /moonlight
   sudo rm -rf /opt/.retrooz/oga/root/moonlight
   sudo rm -rf /opt/.retrooz/oga1/root/moonlight
   sudo rm -rf /opt/.retrooz/ogs/root/moonlight
   sudo rm -rf /opt/.retrooz/rgb10maxtop/root/moonlight
   sudo rm -rf /opt/.retrooz/rgb10maxnative/root/moonlight

   echo "Uncompressing update-wip-unofficial_0.61_beta1.tar.gz" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo tar -xvf /roms/ports/update-wip-unofficial_0.61_beta1.tar.gz -C / --no-same-owner 2>&1 | tee -a /dev/tty1 $LOG_FILE 

   echo "Update file permissions" 2>&1 | tee -a /dev/tty1 $LOG_FILE

   sudo chown -R root:adm /opt/.retrooz/
   sudo chmod -R 775      /opt/.retrooz/

   sudo chown -R root:adm /opt/system/Device/
   sudo chmod -R 775      /opt/system/Device/

   sudo chown -R root:adm /opt/system/Retrorun/
   sudo chmod -R 775      /opt/system/Retrorun/

   sudo chown -R root:adm /opt/system/Rescue/
   sudo chmod -R 775      /opt/system/Rescue/

   sudo chown root:root /etc/emulationstation/es_*.cfg
   sudo chmod 775       /etc/emulationstation/es_*.cfg 

   sudo chmod 755       /usr/local/bin/blink-screen
   sudo chown root:root /usr/local/bin/blink-screen

   sudo chown root:root /usr/local/bin/es-*
   sudo chmod 755       /usr/local/bin/es-*

   sudo chown root:root /usr/local/bin/*.sh
   sudo chmod 755       /usr/local/bin/*.sh

   sudo chown root:root /usr/local/bin/ogage
   sudo chmod 755       /usr/local/bin/ogage

   sudo chown root:root /lib/systemd/system/ogs_events.service
   sudo chmod 644       /lib/systemd/system/ogs_events.service

   sudo chmod -R 775      /opt/.retrooz/bin/
   sudo chown -R root:adm /opt/.retrooz/bin/

   sudo chmod -R 775      /opt/.retrooz/oga/
   sudo chown -R root:adm /opt/.retrooz/oga/

   sudo chmod -R 775      /opt/.retrooz/oga1/
   sudo chown -R root:adm /opt/.retrooz/oga1/

   sudo chmod -R 775      /opt/.retrooz/ogs/
   sudo chown -R root:adm /opt/.retrooz/ogs/

   sudo chmod -R 775      /opt/.retrooz/rgb10max2native/
   sudo chown -R root:adm /opt/.retrooz/rgb10max2native/

   sudo chmod -R 775      /opt/.retrooz/rgb10maxnative/
   sudo chown -R root:adm /opt/.retrooz/rgb10maxnative/

   sudo chmod -R 775      /opt/.retrooz/rgb10max2top/
   sudo chown -R root:adm /opt/.retrooz/rgb10max2top/

   sudo chmod -R 775      /opt/.retrooz/rgb10maxtop/
   sudo chown -R root:adm /opt/.retrooz/rgb10maxtop/

   sudo chmod -R 775      /opt/.retrooz/universal/
   sudo chown -R root:adm /opt/.retrooz/universal/

   sudo chmod 775      /opt/.retrooz/version
   sudo chown root:adm /opt/.retrooz/version

   sudo chmod -R 775      /opt/system/Device/
   sudo chown -R root:adm /opt/system/Device/

   sudo chmod -R 775 /opt/retroarch/
   sudo chown -R root:adm /opt/retroarch/

   sudo chown -R root:root /usr/bin/emulationstation/
   sudo find /usr/bin/emulationstation/ -name "*.svg" -exec chmod 664 {} +
   sudo find /usr/bin/emulationstation/ -name "*.png" -exec chmod 664 {} +
   sudo find /usr/bin/emulationstation/ -name "*.ttf" -exec chmod 664 {} +
   sudo find /usr/bin/emulationstation/ -name "*.xml" -exec chmod 664 {} +
   sudo find /usr/bin/emulationstation/ -name "*.po"  -exec chmod 664 {} +
   sudo chmod 755 /usr/bin/emulationstation/resources/brightness
   sudo chmod 755 /usr/bin/emulationstation/resources/flags
   sudo chmod 755 /usr/bin/emulationstation/resources/network
   sudo chmod 755 /usr/bin/emulationstation/resources/sound

   sudo rm -f /usr/bin/emulationstation/resources/es_preload_vlc.*

   echo "Updating 'Retroarch' settings ..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   
   sudo mkdir "/home/odroid/.config/retroarch/config/MAME 2003 (0.78)"
   sudo mkdir "/home/odroid/.config/retroarch32/config/MAME 2003 (0.78)"
   
   sudo chmod -R 775 /home/odroid/.config/retroarch/
   sudo chown -R odroid:odroid /home/odroid/.config/retroarch/
   sudo chmod -R 775 /home/odroid/.config/retroarch32/
   sudo chown -R odroid:odroid /home/odroid/.config/retroarch32/

   echo "Updating 'ES Systems File' ..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="snes-msu1"]' /etc/emulationstation/es_systems.cfg)" ]; then
      sudo xmlstarlet ed --inplace --update '/systemList/system[name="nintendo - Super Nintendo MSU1"]/name' --value "snes-msu1" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="snes-msu1"]/emulators/emulator[@name="retroarch"]/cores/core[text()="mednafen_supafaust"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="snes-msu1"]/emulators/emulator[@name="retroarch"]/cores/core[text()="snes9x2010"]' -t elem -n core -v "mednafen_supafaust" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="sharpx1"]' /etc/emulationstation/es_systems.cfg)" ]; then
      sudo xmlstarlet ed --inplace --update '/systemList/system[name="x1"]/name' --value "sharpx1" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="Arcade"]' /etc/emulationstation/es_systems.cfg)" ]; then
      sudo xmlstarlet ed --inplace --update '/systemList/system[name="Arcade - Various Platform"]/name' --value "Arcade" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[fullname="SNK - Neogeo MVS"]' /etc/emulationstation/es_systems.cfg)" ]; then
      sudo xmlstarlet ed --inplace --update '/systemList/system[fullname="Arcade - SNK Neogeo MVS"]/fullname' --value "SNK - Neogeo MVS" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace --update '/systemList/system[name="arcade"]/command' --value "perfmax; /usr/local/bin/retroarch.sh %EMULATOR% %CORE% %ROM%; perfnorm" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch-tate"]/cores' --type elem -n core -v "fbneo" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch-tate"]/cores/core[text()="fbneo"]' -t elem -n core -v "mame2003_plus" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch32-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32-tate"]/cores' --type elem -n core -v "mame2003_xtreme" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace --update '/systemList/system[name="cps1"]/command' --value "perfmax; /usr/local/bin/retroarch.sh %EMULATOR% %CORE% %ROM%; perfnorm" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch-tate"]/cores' --type elem -n core -v "fbneo" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch-tate"]/cores/core[text()="fbneo"]' -t elem -n core -v "mame2003_plus" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch32-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32-tate"]/cores' --type elem -n core -v "mame2003_xtreme" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace --update '/systemList/system[name="cps2"]/command' --value "perfmax; /usr/local/bin/retroarch.sh %EMULATOR% %CORE% %ROM%; perfnorm" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch-tate"]/cores' --type elem -n core -v "fbneo" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch-tate"]/cores/core[text()="fbneo"]' -t elem -n core -v "mame2003_plus" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch32-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32-tate"]/cores' --type elem -n core -v "mame2003_xtreme" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace --update '/systemList/system[name="cps3"]/command' --value "perfmax; /usr/local/bin/retroarch.sh %EMULATOR% %CORE% %ROM%; perfnorm" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch-tate"]/cores' --type elem -n core -v "fbneo" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch-tate"]/cores/core[text()="fbneo"]' -t elem -n core -v "mame2003_plus" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch32-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32-tate"]/cores' --type elem -n core -v "mame2003_xtreme" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace --update '/systemList/system[name="neogeo"]/command' --value "perfmax; /usr/local/bin/retroarch.sh %EMULATOR% %CORE% %ROM%; perfnorm" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch-tate"]/cores' --type elem -n core -v "fbneo" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch-tate"]/cores/core[text()="fbneo"]' -t elem -n core -v "mame2003_plus" /etc/emulationstation/es_systems.cfg
   fi
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32-tate"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "retroarch32-tate" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32-tate"]' --type elem -n cores -v "" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace --subnode '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32-tate"]/cores' --type elem -n core -v "mame2003_xtreme" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[platform="psx"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="pcsx_rearmed_peops"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[platform="psx"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="pcsx_rearmed"]' -t elem -n core -v "pcsx_rearmed_peops" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="arcade"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps1"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps2"]/emulators/emulator[@name="retroarch32-tate"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="cps3"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="km_mame2003_xtreme"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[name="neogeo"]/emulators/emulator[@name="retroarch32"]/cores/core[text()="mame2003_xtreme"]' -t elem -n core -v "km_mame2003_xtreme" /etc/emulationstation/es_systems.cfg
   fi

   # Saturn - Yabasanshiro
   echo "Updating 'Saturn - Yabasanshiro' settings ..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo chmod 777 /opt/yabasanshiro
   sudo chown -R root:adm /opt/yabasanshiro
   sudo chmod 755 /opt/yabasanshiro/lib/libglut.so.3
   sudo chmod 755 /opt/yabasanshiro/lib/libibus-1.0.so.5
   sudo chmod 755 /opt/yabasanshiro/lib/libSDL2-2.0.so.0
   sudo chmod 775 /opt/yabasanshiro/yabasanshiro

   echo "Removing 'name' attribute for cores ..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo xmlstarlet ed --inplace -d '/systemList/system/emulators/emulator/cores/core/@name' /etc/emulationstation/es_systems.cfg

   # Nintendo64 - mupen64plus
   echo "Updating 'Mupen64plus' settings ..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo chown -R root:root /opt/mupen64plus/
   sudo chmod -R 777 /opt/mupen64plus/

   sudo rm -f /opt/mupen64plus/libmupen64plus.so.2
   sudo ln -s /opt/mupen64plus/libmupen64plus.so.2.0.0 /opt/mupen64plus/libmupen64plus.so.2

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="glide64mk2-wide"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="glide64mk2"]' -t elem -n core -v "glide64mk2-wide" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="rice-wide"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="rice"]' -t elem -n core -v "rice-wide" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="GLideN64"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="rice-wide"]' -t elem -n core -v "GLideN64" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="GLideN64-wide"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace -a '/systemList/system[platform="n64"]/emulators/emulator[@name="mupen64plus"]/cores/core[text()="GLideN64"]' -t elem -n core -v "GLideN64-wide" /etc/emulationstation/es_systems.cfg
   fi

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="n64dd"]/extension[contains(text(),".n64dd")]' /etc/emulationstation/es_systems.cfg)" ]; then
      N64DD_EXT=$(xmlstarlet sel -t -v '/systemList/system[name="n64dd"]/extension' /etc/emulationstation/es_systems.cfg)
      sudo xmlstarlet ed --inplace --update '/systemList/system[name="n64dd"]/extension' --value ".d64 .D64 .n64dd .N64DD $N64DD_EXT" /etc/emulationstation/es_systems.cfg
   fi

   /opt/system/Rescue/Mupen64plus\ Configuration.sh

   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[name="amigacd32"]/extension[contains(text(),".chd")]' /etc/emulationstation/es_systems.cfg)" ]; then
      echo "Updating 'AmigaCD 32' emulator extensions..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
      AMIGA_EXT=$(xmlstarlet sel -t -v '/systemList/system[name="amigacd32"]/extension' /etc/emulationstation/es_systems.cfg)
      sudo xmlstarlet ed --inplace --update '/systemList/system[name="amigacd32"]/extension' --value ".chd .CHD $AMIGA_EXT .m3u .M3U" /etc/emulationstation/es_systems.cfg
   fi

   echo "Adding 'Duckstation' emulator..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   if [ -z "$(xmlstarlet sel -t -v '/systemList/system[platform="psx"]/emulators/emulator[@name="duckstation-standalone"]' /etc/emulationstation/es_systems.cfg)" ]; then
     sudo xmlstarlet ed --inplace --update '/systemList/system[platform="psx"]/command' --value "perfmax; /usr/local/bin/psx.sh %EMULATOR% %CORE% %ROM%; perfnorm" /etc/emulationstation/es_systems.cfg
     sudo xmlstarlet ed --inplace -a '/systemList/system[platform="psx"]/emulators/emulator[@name="retroarch"]' -t elem -n emulator --var new_node '$prev' --insert '$new_node' --type attr --name name --value "duckstation-standalone" /etc/emulationstation/es_systems.cfg
   fi

   sudo chown -R odroid:odroid /home/odroid/.config/duckstation/
   sudo chmod -R 775           /home/odroid/.config/duckstation/
   sudo chmod -R 775 /opt/duckstation/
   sudo chown -R root:adm /opt/duckstation/

   /opt/system/Rescue/Duckstation\ Configuration.sh

   echo "Copying 'Moonlight' controller file..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   /opt/system/Rescue/Moonlight\ Configuration.sh

   echo "Configuring ports" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo rm -f /roms/ports/descent/gamecontrollerdb.txt
   sudo rm -f /roms/ports/descent2/gamecontrollerdb.txt
   sudo rm -f /roms/ports/devilution/gamecontrollerdb.txt
   sudo rm -f /roms/ports/eduke32/gamecontrollerdb.txt
   sudo rm -f /roms/ports/iortcw/gamecontrollerdb.txt
   sudo rm -f /roms/ports/MalditaCastilla/gamecontrollerdb.txt
   sudo rm -f /roms/ports/quake2/gamecontrollerdb.txt
   sudo rm -f /roms/ports/RigelEngine/gamecontrollerdb.txt
   sudo rm -f /roms/ports/sdlpop/gamecontrollerdb.txt
   sudo rm -f /roms/ports/sonic1/gamecontrollerdb.txt
   sudo rm -f /roms/ports/sonic2/gamecontrollerdb.txt
   sudo rm -f /roms/ports/soniccd/gamecontrollerdb.txt
   sudo rm -f /roms/ports/sm64/controller/gamecontrollerdb.txt
   sudo rm -f /roms/ports/VVVVVV/gamecontrollerdb.txt

   sudo sed -i '/SearchPath2 \=/c\SearchPath2 \= \/home\/odroid\/.config\/CGenius\/.CommanderGenius' /roms/ports/cgenius/cgenius.cfg

   echo "Installing 'dialog' application, please wait ..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo dpkg -i /home/odroid/update/dialog_1.3-20190808-1_arm64.deb 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sleep 1

   echo "Enable OGS Events Service" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo systemctl enable ogs_events.service
   sudo systemctl daemon-reload
   sleep 1

   echo "Setting system version 0.61_beta1" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   echo "0.61_beta1" | sudo tee /opt/.retrooz/version

   echo "Removing Update files" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   rm -f /roms/ports/update-wip-unofficial_0.61_beta1.tar.gz 2>&1 | tee -a /dev/tty1 $LOG_FILE
   rm -f /roms/ports/Update-WIP-Unofficial_0.61_beta1.sh 2>&1 | tee -a /dev/tty1 $LOG_FILE
   rm -f /home/odroid/update/dialog_1.3-20190808-1_arm64.deb 2>&1 | tee -a /dev/tty1 $LOG_FILE

   echo "Updating Boot Kernel Image and dtb" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sleep 1
   device="$(cat /opt/.retrooz/device)"
   sudo cp -f /opt/.retrooz/kernel/Image /boot/Image
   device=$(cat /opt/.retrooz/device)
   if [[ "$device" == "oga" ]]; then
      sudo cp -f /opt/.retrooz/oga/rk3326-odroidgo2-linux.dtb /boot/rk3326-odroidgo2-linux.dtb
   elif [[ "$device" == "oga1" ]]; then
      sudo cp -f /opt/.retrooz/oga1/rk3326-odroidgo2-linux-v11.dtb /boot/rk3326-odroidgo2-linux-v11.dtb
   else # OGS / RGB10 MAX / RGB10 MAX2
      sudo cp -f /opt/.retrooz/"$device"/rk3326-odroidgo3-linux.dtb /boot/rk3326-odroidgo3-linux.dtb
      sudo cp -f /opt/.retrooz/"$device"/rk3326-odroidgo3-linux-oc.dtb /boot/rk3326-odroidgo3-linux-oc.dtb
   fi

   echo "Removing unsused Kernel Modules" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/ath/ath9k/ath9k_htc.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/ath/ath6kl/ath6kl_sdio.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/cw1200/cw1200_wlan_sdio.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/cw1200/cw1200_wlan_spi.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/p54/p54spi.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/mwifiex/mwifiex_sdio.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/libertas/libertas_sdio.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/libertas/libertas_spi.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/rtl8723ds/rtl8723ds.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/rtl8189fs/wlan.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/rtl8723cs/8723cs.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/rtl8189es/8189es.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/rtl8723bs/8723bs.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/mvl88w8977/sd8xxx.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/mvl88w8977/mlan.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/rkwifi/bcmdhd/bcmdhd.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/cywdhd/bcmdhd/cywdhd.ko
   sudo rm -f /lib/modules/4.4.189/kernel/drivers/net/wireless/rockchip_wlan/ssv6xxx/ssv6051.ko

   # Fix Chistian Virtual Machine ES Compilation
   sudo ln -s /usr/local/lib/aarch64-linux-gnu/libmali-bifrost-g31-rxp0-gbm.so /usr/local/lib/aarch64-linux-gnu/libGLES_CM.so
   sudo ln -s /usr/lib/aarch64-linux-gnu/libMali.so /usr/lib/aarch64-linux-gnu/libGLES_CM.so

   echo "Activating the system optimization" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   OPTIMIZE_SYSTEM_CONFIGURED=$(grep \"OptimizeSystem\" /home/odroid/.emulationstation/es_settings.cfg)
   if [ -z "$OPTIMIZE_SYSTEM_CONFIGURED" ]; then
      sed  -i '2i <bool name="OptimizeSystem" value="true" />' /home/odroid/.emulationstation/es_settings.cfg
      /usr/local/bin/es-optimize_system active_optimize_system true
   else
      OPTIMIZE_SYSTEM_ENABLED=$(grep "\"OptimizeSystem\" value=\"true\"" /home/odroid/.emulationstation/es_settings.cfg)
      if [ -z "$OPTIMIZE_SYSTEM_ENABLED" ]; then
         sudo sed -i 's/"OptimizeSystem" value="false"/"OptimizeSystem" value="true"/g' /home/odroid/.emulationstation/es_settings.cfg
         /usr/local/bin/es-optimize_system active_optimize_system true
      fi
   fi

   echo "Activating Alphabetic sort for systems" 2>&1 | tee -a /dev/tty1 $LOG_FILE
   SORT_SYSTEMS_CONFIGURED=$(grep \"SortSystems\" /home/odroid/.emulationstation/es_settings.cfg)
   if [ -z "$OPTIMIZE_SYSTEM_CONFIGURED" ]; then
      sed  -i '2i <string name="SortSystems" value="alpha" />' /home/odroid/.emulationstation/es_settings.cfg
      sed  -i '2i <bool name="SpecialAlphaSort" value="true" />' /home/odroid/.emulationstation/es_settings.cfg
   fi

   echo "Rebooting the system..." 2>&1 | tee -a /dev/tty1 $LOG_FILE
   sleep 5
   reboot 2>&1 | tee -a /dev/tty1 $LOG_FILE

