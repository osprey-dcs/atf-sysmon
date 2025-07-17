#!../../bin/linux-x86_64/sysmon

## Register all support components
dbLoadDatabase "../../dbd/sysmon.dbd"
sysmon_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("../../db/linStatHost.db","IOC=MDAS:SYS:DAQM")

dbLoadRecords("../../db/linStatNIC.db","IOC=MDAS:SYS:DAQM,NIC=eno12399np0")

dbLoadRecords("../../db/linStatFS.db","P=MDAS:SYS:DAQM:ROOT,DIR=/")
dbLoadRecords("../../db/linStatFS.db","P=MDAS:SYS:DAQM:DATA,DIR=/data")

dbLoadRecords("../../db/save_restoreStatus.db", "P=MDAS:AS:DAQS:")
save_restoreSet_status_prefix("MDAS:AS:DAQM:")

system "install -d as/DAQM"

set_savefile_path("$(PWD)/as", "/DAQM")
set_requestfile_path("$(PWD)/as", "/DAQM")

set_pass0_restoreFile("atf_settings.sav")
set_pass0_restoreFile("atf_values.sav")
set_pass1_restoreFile("atf_values.sav")
set_pass1_restoreFile("atf_waveforms.sav")

iocInit()

makeAutosaveFileFromDbInfo("$(PWD)/as/DAQM/atf_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("$(PWD)/as/DAQM/atf_values.req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(PWD)/as/DAQM/atf_waveforms.req", "autosaveFields_pass1")

create_monitor_set("atf_settings.req", 10 , "")
create_monitor_set("atf_values.req", 10 , "")
create_monitor_set("atf_waveforms.req", 30 , "")
