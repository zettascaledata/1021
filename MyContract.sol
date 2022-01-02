// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;
contract Bounties {
    // Enums
    enum BountyStatus { CREATED, ACCEPTED, CANCELLED }
    // Storage
    Bounty[] public bounties;
    // Structs
    struct Bounty {
        address issuer;
        uint deadline;
        string data;
        BountyStatus status;
        uint amount;
    }
    //Contructor
    constructor() public {}
    //issueBounty(): instantiates a new bounty
    function issueBounty(
    string memory _data,
    uint64 _deadline
    )
    public
    payable
    hasValue()
    validateDeadline(_deadline)
    returns (uint)
    {
        bounties.push(Bounty(msg.sender, _deadline, _data, BountyStatus.CREATED, msg.value));
        emit BountyIssued(bounties.length - 1,msg.sender, msg.value, _data);
        return (bounties.length - 1);
    }

    //Modifiers
    modifier hasValue() {
        require(msg.value > 0);
        _;
    }
    modifier validateDeadline(uint _newDeadline) {
        require(_newDeadline > block.timestamp);
        _;
    }
    //Events
    event BountyIssued(uint bounty_id, address issuer, uint amount, string data);
}
