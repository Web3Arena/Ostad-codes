# Assignment 7

## Install
`npm i`
## Env Setup
`
PRIVATE_KEY=""
INFURA_KEY=""
ETHERSCAN_API_KEY=""
`
## Compile
`
npx hardhat compile
`
## Deploy
`
npx hardhat run scripts/deploy.js --network network_name
`
## Verify on Etherscan
`
npx hardhat verify deployed_contract_address --network network_name
`
## Test
`
npx hardhat test
`