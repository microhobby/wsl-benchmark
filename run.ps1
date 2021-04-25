
# configure
wsl cd ~ && `
    git clone https://github.com/microhobby/wsl-benchmark.git && `
    cd wsl-benchmark && `
    ./install.sh

# shutdown
wsl --shutdown
wsl --shutdown

# runs
wsl cat '/home/root/$(uname -r).log'
