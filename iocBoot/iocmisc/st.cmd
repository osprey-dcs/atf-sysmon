#!../../bin/linux-x86_64/sysmon

## Register all support components
dbLoadDatabase "../../dbd/sysmon.dbd"
sysmon_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("../../db/linStatHost.db","IOC=FDAS:SYS:MISC")

dbLoadRecords("../../db/linStatNIC.db","IOC=FDAS:SYS:MISC,NIC=MISCeth0")
dbLoadRecords("../../db/linStatNIC.db","IOC=FDAS:SYS:MISC,NIC=eno8403")

dbLoadRecords("../../db/linStatFS.db","P=FDAS:SYS:MISC:ROOT,DIR=/")
dbLoadRecords("../../db/linStatFS.db","P=FDAS:SYS:MISC:DATA,DIR=/data")

iocInit()
