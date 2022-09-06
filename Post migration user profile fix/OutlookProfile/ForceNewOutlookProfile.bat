@echo off
reg add HKCU\Software\Microsoft\Office\15.0\Outlook\Profiles\o365-Migration /F
reg add "HKCU\Software\Microsoft\Office\15.0\Outlook" /v DefaultProfile /t REG_SZ /d "o365-Migration" /F
reg add HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles\o365-Migration /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook" /v DefaultProfile /t REG_SZ /d "o365-Migration" /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v ZeroConfigExchange /t REG_DWORD /d "1" /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v ExcludeHttpsRootDomain /t REG_DWORD /d "1" /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v ExcludeScpLookup /t REG_DWORD /d "1" /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v ExcludeSrvRecord /t REG_DWORD /d "1" /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v ExcludeLastKnownGoodURL /t REG_DWORD /d "1" /F
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v ExcludeExplicitO365Endpoint /t REG_DWORD /d "0" /F
