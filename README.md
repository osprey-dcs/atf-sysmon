# Computer monitoring IOCs

## Requires

- [EPICS Base](https://github.com/epics-base/epics-base)
- [linStat](https://github.com/mdavidsaver/linStat) driver
- [autosave](https://github.com/epics-modules/autosave)
- [PVXS](https://github.com/epics-base/pvxs) (optional)

## Building

```sh
git clone https://github.com/epics-base/epics-base.git
git clone https://github.com/epics-base/pvxs.git
git clone https://github.com/epics-modules/autosave
git clone https://github.com/mdavidsaver/linStat
git clone https://github.com/osprey-dcs/atf-sysmon

cat <<EOF > autosave/RELEASE.local
EPICS_BASE=$(TOP)/../epics-base
EOF

cat <<EOF > pvxs/RELEASE.local
EPICS_BASE=$(TOP)/../epics-base
EOF

cat <<EOF > linStat/RELEASE.local
AUTOSAVE=$(TOP)/../autosave
PVXS=$(TOP)/../pvxs
EPICS_BASE=$(TOP)/../epics-base
EOF

cat <<EOF > atf-sysmon/RELEASE.local
AUTOSAVE=$(TOP)/../autosave
PVXS=$(TOP)/../pvxs
EPICS_BASE=$(TOP)/../epics-base
EOF

make -C epics-base
make -C pvxs
make -C autosave
make -C linStat
make -C atf-sysmon
```

## Running

IOC instance start scripts are `iocBoot/ioc*/st.cmd`.  eg.

```sh
cd atf-sysmon/iocBoot/iocmisc
./st.cmd
```

Running with `systemd` and `procServ` is recommended.
See [`atf-sysmon@.service`](atf-sysmon@.service). eg.

```sh
systemctl start atf-sysmon@iocmisc
```
