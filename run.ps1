
# create kernel entry
If ($args[0] -ne $null) {
    echo "🔙 BACKUP .wslconfig"
    cp ~\.wslconfig ~\.wslconfig.back
    echo "🐱‍🐉 ADDING KERNEL ENTRY"
    
    $path = [regex]::escape($args[0])
    echo "kernel=$path" >> ~\.wslconfig
}

echo "⚙️ CONFIGURE"
# configure with password input
If ($env:WSL_PASSWORD -ne $null) {
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

echo "📴 TURNING OFF"
# shutdown
wsl --shutdown
wsl --shutdown

# clear screen
clear

echo "🧪 TESTING"
echo "-----------------------------------------------------------------------------------------------------------------"
# runs
wsl cat '/home/$(uname -r).log'

wsl bash -c 'echo "----------------------------------------------------------------------------------------" && \
/usr/bin/wslfetch -c && \
echo "----------------------------------------------------------------------------------------"'

echo "💾 LOGGING"
# creating log file
$month = (Get-Date).Month
$day = (Get-Date).Day
$year = (Get-Date).Year
$hour = (Get-Date).Hour
$minutes = (Get-Date).Minute
$seconds = (Get-Date).Second

wsl cat '/home/$(uname -r).log' > "$month-$day-$year-$hour-$minutes-$seconds.log" 

echo "🧼 CLEANUP"
# cleanup
If ($env:WSL_PASSWORD -ne $null) {
    wsl bash -c 'wslvar WSL_PASSWORD | sudo -S cp /etc/wsl.conf.back /etc/wsl.conf && wslvar WSL_PASSWORD | sudo -S rm -r /home/wsl-benchmark'
} else {
    wsl bash -c 'sudo cp /etc/wsl.conf.back /etc/wsl.conf && sudo rm -r /home/wsl-benchmark'
}

If ($args[0] -ne $null) {
    cp ~\.wslconfig.back ~\.wslconfig
}
