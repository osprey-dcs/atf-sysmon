#!../../bin/linux-x86_64/sysmon

## Register all support components
dbLoadDatabase "../../dbd/sysmon.dbd"
sysmon_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("../../db/linStatHost.db","IOC=MDAS:SYS:DISWS3")

dbLoadRecords("../../db/linStatNIC.db","IOC=MDAS:SYS:DISWS3,NIC=eno8303")

dbLoadRecords("../../db/linStatFS.db","P=MDAS:SYS:DISWS3:ROOT,DIR=/")
dbLoadRecords("../../db/linStatFS.db","P=MDAS:SYS:DISWS3:SEC,DIR=/mnt/secondary")

iocInit()
