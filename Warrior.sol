pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "WarUnit.sol";

contract Warrior is WarUnit{
    constructor(BaseStation baseStationAddress, uint16 warriorHealth) 
    public 
    WarUnit(baseStationAddress, warriorHealth){
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
}
