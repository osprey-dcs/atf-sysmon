#!../../bin/linux-x86_64/sysmon

## Register all support components
dbLoadDatabase "../../dbd/sysmon.dbd"
sysmon_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("../../db/linStatHost.db","IOC=FDAS:SYS:DAQS")

dbLoadRecords("../../db/linStatNIC.db","IOC=FDAS:SYS:DAQS,NIC=DAQeth0")

dbLoadRecords("../../db/linStatFS.db","P=FDAS:SYS:DAQS:ROOT,DIR=/")
dbLoadRecords("../../db/linStatFS.db","P=FDAS:SYS:DAQS:DATA,DIR=/data")

dbLoadRecords("../../db/save_restoreStatus.db", "P=FDAS:AS:DAQS:")
save_restoreSet_status_prefix("FDAS:AS:DAQS:")

system "install -d as/DAQS"

set_savefile_path("$(PWD)/as", "/DAQS")
set_requestfile_path("$(PWD)/as", "/DAQS")

set_pass0_restoreFile("atf_settings.sav")
set_pass0_restoreFile("atf_values.sav")
set_pass1_restoreFile("atf_values.sav")
set_pass1_restoreFile("atf_waveforms.sav")

iocInit()

makeAutosaveFileFromDbInfo("$(PWD)/as/DAQS/atf_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("$(PWD)/as/DAQS/atf_values.req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(PWD)/as/DAQS/atf_waveforms.req", "autosaveFields_pass1")

create_monitor_set("atf_settings.req", 10 , "")
create_monitor_set("atf_values.req", 10 , "")
create_monitor_set("atf_waveforms.req", 30 , "")
