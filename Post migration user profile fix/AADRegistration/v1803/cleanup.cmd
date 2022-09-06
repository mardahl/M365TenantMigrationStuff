dsregcmd /status >> log.txt
PsExec.exe -is dsregcmd /leave
dsregcmd /status >> log.txt
CleanupWPJ_%PROCESSOR_ARCHITECTURE% >> log.txt
dsregcmd /status >> log.txt
PsExec.exe -is dsregcmd
dsregcmd /status >> log.txt
rem logoff
