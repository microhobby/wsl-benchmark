
# create kernel entry
If ($null -ne $args[0]) {
    Write-Output "🔙 BACKUP .wslconfig"
    Copy-Item ~\.wslconfig ~\.wslconfig.back
    Write-Output "🐱‍🐉 ADDING KERNEL ENTRY"
    
    $path = [regex]::escape($args[0])
    Write-Output "kernel=$path" >> ~\.wslconfig
}

Write-Output "⚙️ CONFIGURE"
# configure with password input
If ($null -ne $env:WSL_PASSWORD) {
    wsl bash -c 'cd /home && \
wslvar WSL_PASSWORD | sudo -S git clone https://github.com/microhobby/wsl-benchmark.git && \
cd wsl-benchmark && \
wslvar WSL_PASSWORD | sudo -S ./install.sh'
} else {
    wsl bash -c 'cd /home && \
sudo git clone https://github.com/microhobby/wsl-benchmark.git && \
cd wsl-benchmark && \
sudo ./install.sh'
}

Write-Output "📴 TURNING OFF"
# shutdown
wsl --shutdown
wsl --shutdown

# clear screen
Clear-Host

Write-Output "🧪 TESTING"
Write-Output "-----------------------------------------------------------------------------------------------------------------"
# runs
wsl cat '/home/$(uname -r).log'

wsl bash -c 'echo "----------------------------------------------------------------------------------------" && \
/usr/bin/wslfetch -c && \
echo "----------------------------------------------------------------------------------------"'

Write-Output "💾 LOGGING"
# creating log file
$month = (Get-Date).Month
$day = (Get-Date).Day
$year = (Get-Date).Year
$hour = (Get-Date).Hour
$minutes = (Get-Date).Minute
$seconds = (Get-Date).Second

wsl cat '/home/$(uname -r).log' > "$month-$day-$year-$hour-$minutes-$seconds.log" 

Write-Output "🧼 CLEANUP"
# cleanup
If ($null -ne $env:WSL_PASSWORD) {
    wsl bash -c 'wslvar WSL_PASSWORD | sudo -S cp /etc/wsl.conf.back /etc/wsl.conf && wslvar WSL_PASSWORD | sudo -S rm -r /home/wsl-benchmark'
} else {
    wsl bash -c 'sudo cp /etc/wsl.conf.back /etc/wsl.conf && sudo rm -r /home/wsl-benchmark'
}

If ($null -ne $args[0]) {
    Copy-Item ~\.wslconfig.back ~\.wslconfig
}
