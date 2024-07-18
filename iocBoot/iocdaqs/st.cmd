#!../../bin/linux-x86_64/sysmon

#- You may have to change sysmon to something else
#- everywhere it appears in this file

#< envPaths

## Register all support components
dbLoadDatabase "../../dbd/sysmon.dbd"
sysmon_registerRecordDeviceDriver(pdbbase) 

## Load record instances
#dbLoadRecords("../../db/sysmon.db","user=atf")

iocInit()

## Start any sequence programs
#seq sncsysmon,"user=atf"
