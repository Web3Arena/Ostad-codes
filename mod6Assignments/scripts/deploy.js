const hre = require("hardhat");

async function main() {
  const Assignment6 = await hre.ethers.deployContract("Assignment6");

  await Assignment6.waitForDeployment();

  console.log(`VotingContract deployed to: ${Assignment6.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
