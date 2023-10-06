const hre = require("hardhat");

async function main() {
  const voteContract = await hre.ethers.deployContract("VotingContract");

  await voteContract.waitForDeployment();

  console.log(`VotingContract deployed to: ${voteContract.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
