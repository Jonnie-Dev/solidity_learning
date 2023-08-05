// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// Creates the PersonalBank contract
contract PersonalBank {
    // Creates an address to integer variable names balanxes (for balances held in each addresses)
    mapping(address => uint256) public balances;

    // Checks if the initiator of a transaction has more that the amount he's about to transact in his wallet
    modifier noFraud(uint256 amount) {
        require(balances[msg.sender] >= amount, "Not enough balance");
        _;
    }

    // deposit value to the balance in the initiators address (msg.value), it's payable so it can receive eth
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // check if the initiator is not a fraud, then withdraws (removes) the amount specified from the balance
    function withdraw(uint256 amount) external payable noFraud(amount) {
        balances[msg.sender] -= amount;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // get balance of the initiator's (caller's) address
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // transfer specified amount to specified address
    function transfer(
        address payable _to,
        uint amount
    ) public payable noFraud(amount) {
        // to ensure the sender has enough funds first before sending (the noFraud modifier does this already)
        // require(balances[msg.sender] > amount);
        balances[msg.sender] -= amount;
        balances[_to] += amount;
    }
}
