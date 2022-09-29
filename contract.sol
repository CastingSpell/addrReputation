// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Scorer is Ownable {

    struct Wallet {
        address addedBy;
        int score;
        uint timestamp;
    }

    mapping(address => Wallet) private wallets;
    

    function getScore(address _address) public view returns(int) {
        return wallets[_address].score;
    }

    function getAll(address _address) public view returns(Wallet memory) {
        return wallets[_address];
    }


    uint256 private constant _TIMELOCK = 60;
    uint256 public timelock;

    modifier notLocked() {
        require(timelock != 0 && timelock <= block.timestamp, "You must wait before casting a new vote");
        _;
    }

    //lock and unlock timelock
    function unlockFunction() public onlyOwner { timelock = block.timestamp + _TIMELOCK; }
    function lockFunction() private onlyOwner { timelock = 0; }

    function castVote(address _address, bool _vote) public onlyOwner notLocked() {
        if (wallets[_address].timestamp == 0) {
            wallets[_address] = Wallet(msg.sender, 0, block.timestamp);
        }

        if (_vote) {
            wallets[_address].score++;
        } else {
            wallets[_address].score--;
        }
        timelock = 0;
    }
    

}
