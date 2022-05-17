const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SupplyChain", function () {


  let contract;
  beforeEach(async function () {
    const Contract = await ethers.getContractFactory("SupplyChain");
    contract = await Contract.deploy();
    await contract.deployed();
  });
  
  it("Should add product", async function () {

	await contract.addProduct("Cheese - Mix");
	
    expect(await contract.getProductName(0)).to.equal("Cheese - Mix");
  });
  
  it("Should make purshase", async function () {
  
	await contract.addProduct("Cheese - Mix");
	await contract.purshase(0);
    
    expect(await contract.isRequested(0)).to.equal(true);

  });
  
  it("Should start delivery", async function () {
  
	await contract.addProduct("Cheese - Mix");
	await contract.purshase(0);
    await contract.setOnDelivery(0);
    
    expect(await contract.isRequested(0)).to.equal(false);
	expect(await contract.isOnDelivery(0)).to.equal(true);

  });
  
  it("Should deliver", async function () {
  
	await contract.addProduct("Cheese - Mix");
	await contract.purshase(0);
    await contract.setOnDelivery(0);
    await contract.setDelivered(0);
    
    expect(await contract.isRequested(0)).to.equal(false);
	expect(await contract.isOnDelivery(0)).to.equal(false);
	expect(await contract.isDelivered(0)).to.equal(true);

  });
  
  describe("Should Not", async function () {
  
  	it("Start delivery after product is delivered", async function(){
  		
		await contract.addProduct("Cheese - Mix");
		await contract.purshase(0);
		await contract.setOnDelivery(0);
		await contract.setDelivered(0);
		
		await expect(contract.setOnDelivery(0)).be.revertedWith("purshase is not requested");
  	});
  
  	it("deliver before it start", async function(){
  		
		await contract.addProduct("Cheese - Mix");
		await contract.purshase(0);
		
		await expect(contract.setDelivered(0)).be.revertedWith("purshase is not on delivery");
  	});

  });
  
  
  
});
