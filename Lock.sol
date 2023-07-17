// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YourToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    constructor(string memory tokenName, string memory tokenSymbol, uint8 decimalUnits, uint256 initialSupply) {
        name = tokenName;
        symbol = tokenSymbol;
        decimals = decimalUnits;
        totalSupply = initialSupply * 10**uint256(decimals);
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Only the contract owner can mint tokens");
        balanceOf[to] += amount;
        totalSupply += amount;
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}
