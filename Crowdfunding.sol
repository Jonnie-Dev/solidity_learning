// Time to put our newly learnt Solidity skills to the test. Let’s try creating our own smart contract from scratch!

// We will be creating a smart contract that facilitates crowdfunding - the owner creates the smart contract and other people can donate to the owner. Once enough donations have been collected, the owner can withdraw the funds from the smart contract. Let’s go!

// In the file explorer, create a new empty file called Crowdfunding.sol
// Declare the solidity version as 0.8.3
// Create a new contract called SolidityFundamentals2
// Define an enum named State with the following states: IN_PROGRESS and ENDED
// Declare a state variable owner of type address and set its visibility to public. Make it payable as well
// Declare a state variable currentState of type State and set its visibility to public
// Define a constructor() function that does not take in any parameters nor does it have any function modifiers. In the body of the constructor() function, assign owner to payable(msg.sender)
// Declare a modifier called stillInProgress(). It does not take in any parameters. In the modifier, add a require()statement that checks if currentState == State.IN_PROGRESS, throwing an error message of "donation phase is no longer in progress" if the check fails
// Declare a function called donate. The function takes on the following modifiers: external, payable and stillInProgress(). Leave the body of the function empty
// Declare a function called checkAmountCollected. Set the function visibility to public view and also add the stillInProgress() modifier to it. The function returns a uint256 value
// In the body of the function, there is only 1 line of code - return address(this).balance;. This returns the amount of donations that’s been received thus far
// Lastly, declare a function called withdraw() and give it the external modifier
// In the function, there are 3 lines of codes. The first is a require() statement that checks if msg.sender == owner, throwing an error message of "only the owner can withdraw" if the check fails
// The second line of code is owner.transfer(address(this).balance);. This transfers the contract’s entire balance to owner
// Finally, the third line of code is to change the state of currentState to State.ENDED

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract SolidityFundamentals2 {
    enum State {
        IN_PROGRESS,
        ENDED
    }

    State public currentState;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier stillInProgress() {
        require(
            currentState == State.IN_PROGRESS,
            "donation phase is no londer in progress"
        );
        _;
    }

    function donate() external payable stillInProgress {}

    function checkAmountCollected()
        public
        view
        stillInProgress
        returns (uint256)
    {
        return address(this).balance;
    }

    function withdraw() external {
        require(msg.sender == owner, "only the owner can withdraw");
        owner.transfer(address(this).balance);
        currentState = State.ENDED;
    }
}
