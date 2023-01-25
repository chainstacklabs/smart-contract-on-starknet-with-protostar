<img width="1200" alt="Labs" src="https://user-images.githubusercontent.com/99700157/213291931-5a822628-5b8a-4768-980d-65f324985d32.png">

<p>
 <h3 align="center">Chainstack is the leading suite of services connecting developers with Web3 infrastructure</h3>
</p>

<p align="center">
  <a target="_blank" href="https://chainstack.com/build-better-with-ethereum/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Ethereum.svg" /></a>&nbsp;  
  <a target="_blank" href="https://chainstack.com/build-better-with-bnb-smart-chain/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/BNB.svg" /></a>&nbsp;
  <a target="_blank" href="https://chainstack.com/build-better-with-polygon/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Polygon.svg" /></a>&nbsp;
  <a target="_blank" href="https://chainstack.com/build-better-with-avalanche/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Avalanche.svg" /></a>&nbsp;
  <a target="_blank" href="https://chainstack.com/build-better-with-fantom/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Fantom.svg" /></a>&nbsp;
</p>

<p align="center">
  • <a target="_blank" href="https://chainstack.com/">Homepage</a> •
  <a target="_blank" href="https://chainstack.com/protocols/">Supported protocols</a> •
  <a target="_blank" href="https://chainstack.com/blog/">Chainstack blog</a> •
  <a target="_blank" href="https://docs.chainstack.com/quickstart/">Chainstack docs</a> •
  <a target="_blank" href="https://docs.chainstack.com/quickstart/">Blockchain API reference</a> •
  <a target="_blank" href="https://console.chainstack.com/user/account/create">Start for free</a> •
</p>

# Create and deploy a smart contract on StarkNet

This tutorial will show you how to create a simple smart contract in Cairo to save and retrieve a variable and then deploy it on the StarkNet testnet using ProtoStar.

Cairo is a relatively new language that powers StarkNet's smart contracts; it is worth learning more about it! 

In this repo you will find the project with the smart contract and the compiled files in the `protostar-project` directory.

See [Deploy a simple storage smart contract on StarkNet](https://chainstack.com/deploy-a-simple-storage-contract-on-starknet/) for the entire tutorial.

## Quick start

To use this Protostar project:

* [Install Protostar](https://github.com/software-mansion/protostar#installation)
```sh
curl -L https://raw.githubusercontent.com/software-mansion/protostar/master/install.sh | bash
```

* Clone this repository:
```sh
https://github.com/soos3d/Create-and-deploy-a-smart-contract-on-StarkNet.git
```

* Go into the Protostar project's directory:
```sh
cd protostar-project
```

* Compile the smart contract
```sh
protostar build
```

* Deploy the smart contract
```sh
protostar deploy ./build/main.json --network testnet
```

Now the smart contract is deployed and you can interact with it. See the [interact with the deployed contract](https://chainstack.com/deploy-a-simple-storage-contract-on-starknet/#interact-with-the-deployed-contract) section of the tutorial for instructions.

## Requirements

* Linux or macOS
* [Protostar](https://github.com/software-mansion/protostar#installation) development tool
