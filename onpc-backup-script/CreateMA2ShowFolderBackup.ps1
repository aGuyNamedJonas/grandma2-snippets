<#
        Original Version by: Philipp Börner
        Source: https://freshblog.azurewebsites.net/2016/03/28/backup-you-work-with-powershell/

        Adapted by @aGuyNamedJonas for MA2 onPC

        ---------------------------------------------
        SUBSCRIBE      >>> youtube.com/aGuyNamedJonas
        QA & COMMUNITY >>> fb.com/aGuyNamedJonas
        GET IN TOUCH   >>> hi@aGuyNamedJonas.com
        ---------------------------------------------

        HOW TO USE:
        - Make sure $source points to your PC's showfolder
        - Change $dest to point to your harddrive / cloud storage folder (=backup folder)

#>
 
#Define source and destination folders
$source = 'C:\ProgramData\MA Lighting Technologies\grandma'
$dest = 'F:\Google Drive\2019\Showfolder Backups\'
 
#Getting the current date
$date = Get-Date -UFormat _%d_%m_%Y
 
#Building ZIP file name and complete backup path
$ZipFile = 'MA2ShowFolderBackup'+$date+'.zip'
$BackupPath = $dest+$ZipFile
 
#creating GUID if ZIP archive already exist, to rename the pre existing file
$GUID = [GUID]::NewGuid().ToString()
$doubleBackup = $ZipFile+$GUID
if (Test-Path $BackupPath) {Rename-Item $BackupPath -NewName $doubleBackup}
 
#Creating ZIP archive
Get-Item -Path $source | Compress-Archive -DestinationPath $BackupPath -CompressionLevel Optimal -Verbose