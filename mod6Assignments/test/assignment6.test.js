const { expect } = require("chai");

describe("Assignment6", function () {
  let Assignment6, assignment6, owner, addr1;

  // This runs before any test and sets up the environment
  beforeEach(async function () {
    Assignment6 = await ethers.getContractFactory("Assignment6");
    [owner, addr1] = await ethers.getSigners();
    assignment6 = await Assignment6.deploy();
  });

  it("Should return initial name 'Hello World!'", async function () {
    expect(await assignment6.getName()).to.equal("Hello World!");
  });

  it("Should allow owner to set name", async function () {
    await assignment6.setName("Hello New World!");
    expect(await assignment6.getName()).to.equal("Hello New World!");
  });

  it("Should revert if non-owner tries to set name", async function () {
    await expect(
      assignment6.connect(addr1).setName("Another Name!")
    ).to.be.revertedWith("Ownable: caller is not the owner");
  });
});
