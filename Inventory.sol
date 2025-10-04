// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleInventory {
    struct Item {
        string name;
        uint256 quantity;
    }

    mapping(uint256 => Item) private items;
    uint256 public itemCount;
    address public owner;

    event ItemAdded(uint256 itemId, string name, uint256 quantity);
    event QuantityUpdated(uint256 itemId, uint256 newQuantity);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addItem(string memory _name, uint256 _quantity) public onlyOwner {
        itemCount++;
        items[itemCount] = Item(_name, _quantity);
        emit ItemAdded(itemCount, _name, _quantity);
    }

    function updateQuantity(uint256 _itemId, uint256 _quantity) public onlyOwner {
        require(_itemId > 0 && _itemId <= itemCount, "Invalid item ID");
        items[_itemId].quantity = _quantity;
        emit QuantityUpdated(_itemId, _quantity);
    }

    function getItem(uint256 _itemId) public view returns (string memory name, uint256 quantity) {
        require(_itemId > 0 && _itemId <= itemCount, "Invalid item ID");
        Item storage item = items[_itemId];
        return (item.name, item.quantity);
    }
}
