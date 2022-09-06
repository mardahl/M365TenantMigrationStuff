# Profile reset post migration of custom domain

Script that can be deployed as GPO User login script (executing fixMe.bat and including all the files in the GPO's loginscripts folder). 
It will clear the users Azure AD Registration so the tokens are removed (not hybrid join - use DSREGCMD /leave for that)
