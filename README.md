# node-xmr-pool
========================================

Base on repo https://github.com/Cideg/cryptonote-variant-pool

## How to deploy on ubuntu 18.04

* install dependences
```
sudo apt-get update
sudo apt-get install git redis-server build-essential libboost-all-dev cmake python screen
```

* install nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

* install npm and use npm version 0.11
```
nvm i 0.11.16
nvm use 0.11.16
```

* deploy node-xmr-pool
```
git clone https://github.com/mutalisk999/node-xmr-pool

cd node-xmr-pool
npm i
```

* modify config.json and run
```
screen -S pool node init.js
```

* deploy frontend
```
sudo apt-get install nginx
sudo cp -Rf website/* /var/www/html/
```


## Test on regtest chain

* fetch release from xmr repo `https://github.com/monero-project/monero`

* run monerod to start regtest chain
```
./monerod --data-dir=xmr_regtest_data --rpc-bind-ip=127.0.0.1 --rpc-bind-port=18081 --confirm-external-bind --allow-local-ip --disable-rpc-ban --regtest --offline --fixed-difficulty 100000
```

* run `./monero-wallet-cli` and follow the instructions to create a new wallet

* run monero-wallet-rpc to start wallet rpc service
```
./monero-wallet-rpc --wallet-file=MyWallet --password=12345678 --disable-rpc-login --rpc-bind-port=4020 --daemon-address=127.0.0.1:18081 --trusted-daemon
```
