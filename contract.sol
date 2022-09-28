// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Scorer {

    struct Wallet {
        address addedBy;
        int score;
        uint timestamp;
    }

    mapping(address => Wallet) private wallets;
    
    function addAddress(address _address) public {
        wallets[_address] = Wallet(msg.sender, 0, block.timestamp);
    }

    function getScore(address _address) public view returns(int) {
        return wallets[_address].score;
    }

    function getAll(address _address) public view returns(Wallet memory) {
        return wallets[_address];
    }

    function castVote(address _address, bool _vote) public {
        if (_vote) {
            wallets[_address].score++;
        } else {
            wallets[_address].score--;
        }
    }

}
