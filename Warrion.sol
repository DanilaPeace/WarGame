pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "GameObj.sol";
import "BaseStation.sol";
import "WarUnit.sol";

contract Warrior is WarUnit{
    constructor(BaseStation baseStationAddress) public WarUnit(baseStationAddress){
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
}
