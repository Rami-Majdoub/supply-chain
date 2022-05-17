//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract SupplyChain {

/*
	requested [user]
	onDelivery [shop]
	delivered [express]
*/

/*
	list of grocery products (src: https://www.mockaroo.com/)
	Pepper - Green
	Green Scrubbie Pad H.duty
	Cleaner - Comet
	Browning Caramel Glace
	Tea - Decaf Lipton
	Carbonated Water - Blackcherry
	Pork Casing
	Apricots Fresh
	Pasta - Canelloni
*/

	enum State { Requested, OnDelivery, Delivered }
	
	struct Product {
		uint id;
		string name;
	}
	struct ProductPurshase{
		uint id;
		uint productId;
		State state;
	}
	
    constructor() {}
    
    uint ProductMaxId;
    mapping(uint => Product) products;
    
    function addProduct(string memory productName) external {
    	products[ProductMaxId] = Product(ProductMaxId, productName);
    	ProductMaxId ++;
    }
    
    function getProductName(uint ProductId) external view returns (string memory) {
    	return products[ProductId].name;
    }
    
    uint ProductPurshaseMaxId;
    mapping(uint => ProductPurshase) purshases;
    
    function purshase(uint productId) external {
    	purshases[ProductPurshaseMaxId] = ProductPurshase(
    		ProductPurshaseMaxId,
    		productId,
    		State.Requested
    	);
    	ProductPurshaseMaxId ++;
    }
    
    function setOnDelivery(uint purshaseId) external {
    	require(isRequested(purshaseId), "purshase is not requested");
    	purshases[purshaseId].state = State.OnDelivery;
    }
    
    function setDelivered(uint purshaseId) external {
    	require(isOnDelivery(purshaseId), "purshase is not on delivery");
    	purshases[purshaseId].state = State.Delivered;
    }
    
    function isRequested(uint purshaseId) public view returns (bool) {
    	return purshases[purshaseId].state == State.Requested;
    }
    function isOnDelivery(uint purshaseId) public view returns (bool) {
    	return purshases[purshaseId].state == State.OnDelivery;
    }
    function isDelivered(uint purshaseId) public view returns (bool) {
    	return purshases[purshaseId].state == State.Delivered;
    }
    
    
    
}
