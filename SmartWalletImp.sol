//SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract SmartWalletImp{

    address payable  owner;

    mapping (address => uint) public  allowance;
    mapping (address => bool) public  isAllowedToSend;

    constructor(){
        owner = payable(msg.sender);
    }

    function setAllowance(address _for ,uint _amount) public {
        require(msg.sender ==owner, "you are nit the owener ,abording");
        allowance[msg.sender]= _amount;
        if (_amount >0){
            isAllowedToSend[_for] = true;
        }
        else {
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory  _pay) public returns (bytes memory){
        if(msg.sender != owner){
            require (isAllowedToSend [msg.sender],"you are nt allowed to send anything from this samart contravt ,adorting");
            require (allowance[msg.sender]>= _amount, "you are trying to send more than you are allowed to");

            allowance[msg.sender] -= _amount;
        }

        (bool success , bytes memory returnData) = _to.call{value : _amount } (_pay);
        require(success , "anording call way not success");
        return returnData;
    }

}