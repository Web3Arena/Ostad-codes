const hre = require("hardhat");

async function main() {
  const calculator = await hre.ethers.deployContract("Calculator");

  await calculator.waitForDeployment();

  console.log(`Calculator deployed to: ${calculator.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
