function Get-PingStatus ($ip=$args)
{
((New-Object system.net.networkinformation.ping).send($ip)).status
}
