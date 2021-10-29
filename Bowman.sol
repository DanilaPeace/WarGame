pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "GameObj.sol";
import "BaseStation.sol";
import "WarUnit.sol";

contract Bowman is WarUnit{
    uint8 public m_arrowsAmount;

    constructor(BaseStation baseStationAddress,  uint16 bowmanHealth) 
    public 
    WarUnit(baseStationAddress, bowmanHealth){
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    // This method is needed to differ from Warrior 
    function getArrow(uint8 arrowsAmount) public{
        m_arrowsAmount = arrowsAmount;
    }
}
