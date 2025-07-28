#!../../bin/linux-x86_64/sysmon

## Register all support components
dbLoadDatabase "../../dbd/sysmon.dbd"
sysmon_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("../../db/linStatHost.db","IOC=MDAS:SYS:DISWS3")

dbLoadRecords("../../db/linStatNIC.db","IOC=MDAS:SYS:DISWS3,NIC=eno8303")

dbLoadRecords("../../db/linStatFS.db","P=MDAS:SYS:DISWS3:ROOT,DIR=/")
dbLoadRecords("../../db/linStatFS.db","P=MDAS:SYS:DISWS3:SEC,DIR=/mnt/secondary")

dbLoadRecords("../../db/save_restoreStatus.db", "P=MDAS:AS:DISWS3:")
save_restoreSet_status_prefix("MDAS:AS:DISWS3:")

system "install -d as/DISWS3"

set_savefile_path("$(PWD)/as", "/DISWS3")
set_requestfile_path("$(PWD)/as", "/DISWS3")

set_pass0_restoreFile("atf_settings.sav")
set_pass0_restoreFile("atf_values.sav")
set_pass1_restoreFile("atf_values.sav")
set_pass1_restoreFile("atf_waveforms.sav")

iocInit()

makeAutosaveFileFromDbInfo("$(PWD)/as/DISWS3/atf_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("$(PWD)/as/DISWS3/atf_values.req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(PWD)/as/DISWS3/atf_waveforms.req", "autosaveFields_pass1")

create_monitor_set("atf_settings.req", 10 , "")
create_monitor_set("atf_values.req", 10 , "")
create_monitor_set("atf_waveforms.req", 30 , "")
