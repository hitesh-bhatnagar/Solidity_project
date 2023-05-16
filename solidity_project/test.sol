// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Ownable {
    address public owner;

    constructor() {
        owner =msg.sender;

    }
    modifier onlyOwner() {
        require(msg.sender == owner, "only the contract owner can call this function");
        _;
    }
}
contract Mycontract is Ownable{
    mapping(address => uint256) public balances;
    constructor() {}
    function deposit() public payable{
        balances[msg.sender] +=msg.value;

    }
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >=_amount, "Insufficient balance");
        require(msg.sender == owner || balances[msg.sender] == _amount, "Only the full balance can be withdraw by the depositor");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

    }
    function balanceOf(address _depositor) public view returns (uint256) {
        return balances[_depositor];

    }
}