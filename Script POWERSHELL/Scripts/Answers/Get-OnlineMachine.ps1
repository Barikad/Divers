Filter Get-OnlineMachine
{
if ((Get-PingStatus $_) -ieq "Success") {$_}
}