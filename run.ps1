
echo "⚙️ CONFIGURE"
# configure
wsl bash -c 'cd /home && \
git clone https://github.com/microhobby/wsl-benchmark.git && \
cd wsl-benchmark && \
sudo ./install.sh'

echo "📴 TURNING OFF"
# shutdown
wsl --shutdown
wsl --shutdown

echo "🧪 TESTING"
# runs
wsl cat '/home/$(uname -r).log'

echo "🧼 CLEANUP"
# cleanup
wsl bash -c 'sudo cp /etc/wsl.conf.back /etc/wsl.conf'
