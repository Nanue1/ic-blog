mv templates templates-dev

zola -c config-pro.toml build

dfx identity use manue1

dfx deploy --network=ic --with-cycles 400000000000 --wallet tfsfh-haaaa-aaaah-qagdq-cai

rm -rf public
