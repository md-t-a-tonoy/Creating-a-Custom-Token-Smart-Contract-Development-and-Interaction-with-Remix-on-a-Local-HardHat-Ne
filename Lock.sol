//SPDX-License-Identifier: GPL-3.0
pragma solidity>=0.7.0<0.9.0;
contract ALAMS {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint8 decimalUnits,
        uint256 initialSupply
    ) {
        name = tokenName;
        symbol = tokenSymbol;
        decimals = decimalUnits;
        owner = msg.sender;
        minting_token(msg.sender, initialSupply); // Mint initial supply to the contract creator
    }

    modifier only_Owner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    function minting_token(address to, uint256 amount) public only_Owner {
        require(amount > 0, "Amount must be greater than zero");
        balanceOf[to] += amount;
        totalSupply += amount;
    }

    function burning_token(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
    }

    function transfering_token(address to, uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}
