// Now that you have learnt how to do a few things in Solidity, let’s try creating our own smart contract from scratch! We will be creating a simple smart contract that allows you to add 2 numbers together, with the addition of a few checks.

// In the file explorer, create a new empty file called Addition.sol
//Declare the solidity version as 0.8.3
// Create a new contract called SolidityFundamentals1
// Declare a state variable owner of type address and set its visibility to public
// Declare another state variable x of type uint256 and set its visibility to public as well. Assign it a value of 5
// Declare a constructor() function that does not take in any parameters. In the function, it assigns owner to msg.sender
// Declare a modifier called onlyOwner(). It does not take in any parameters. In the modifier, add a require()statement that checks if msg.sender == owner, throwing an error message of ”Not owner” if the check fails. Hint: refer to chapter 5.3 if you are unsure.
// Declare a function() called add. Set the function visibility to public and also add the onlyOwner() modifier to it.
// The function has 1 parameter - a uint256 variable named y. The function returns a uint256 value.
// In the function, add a require() statement that checks if y > x, throwing an error message of ”y should be larger than x” if the check fails.
// After the require() statement, create a new variable z of type uint256 and assign it the value of x + y.
// Lastly, return z
//
// And we’re done coding the smart contract!
//
// Solution:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract SolidityFundamentals1 {
    address public owner;
    uint256 public x = 5;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier check(uint256 y) {
        require(y > x, "y should be larger than x");
        _;
    }

    function add(uint256 y) public view onlyOwner check(y) returns (uint256) {
        uint256 z = x + y;
        return z;
    }
}
