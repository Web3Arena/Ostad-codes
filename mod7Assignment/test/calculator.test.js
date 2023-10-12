const { expect } = require("chai");

describe("Calculator", function () {
  let Calculator;
  let calculator;
  let owner;

  beforeEach(async function () {
    Calculator = await ethers.getContractFactory("Calculator");
    [owner] = await ethers.getSigners();
    calculator = await Calculator.deploy();
  });

  describe("Math operations", function () {
    it("Should add two numbers", async function () {
      await calculator.connect(owner).add(5, 5);
      expect(await calculator.getLastResult()).to.equal(10);
    });

    it("Should subtract two numbers", async function () {
      await calculator.connect(owner).subtract(10, 3);
      expect(await calculator.getLastResult()).to.equal(7);
    });

    it("Should multiply two numbers", async function () {
      await calculator.connect(owner).multiply(5, 5);
      expect(await calculator.getLastResult()).to.equal(25);
    });

    it("Should divide two numbers", async function () {
      await calculator.connect(owner).divide(8, 4);
      expect(await calculator.getLastResult()).to.equal(2);
    });

    it("Should not divide by zero", async function () {
      await expect(calculator.connect(owner).divide(10, 0)).to.be.revertedWith(
        "Denominator must be positive and non zero"
      );
    });
  });
});
