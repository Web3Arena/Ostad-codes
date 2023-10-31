const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with account:", deployer.address);

  // Deploy FactoryStorage
  const FactoryStorage = await hre.ethers.deployContract("FactoryStorage");
  await FactoryStorage.waitForDeployment();

  console.log("FactoryStorage deployed to:", FactoryStorage.target);

  // Deploy TokenStorage
  const TokenStorage = await hre.ethers.deployContract("TokenStorage");
  await TokenStorage.waitForDeployment();

  console.log("TokenStorage deployed to:", TokenStorage.target);

  // Deploy TokenFactory with FactoryStorage address
  const TokenFactory = await hre.ethers.deployContract("TokenFactory", [
    FactoryStorage.target,
  ]);
  await TokenFactory.waitForDeployment();

  console.log("TokenFactory deployed to:", TokenFactory.target);

  // Deploy TokenContract with TokenStorage address
  const TokenContract = await hre.ethers.deployContract("TokenContract", [
    TokenStorage.target,
  ]);
  await TokenContract.waitForDeployment();

  console.log("TokenContract deployed to:", TokenContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
