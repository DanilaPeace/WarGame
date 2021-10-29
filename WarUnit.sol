pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "IWarUnit.sol";
import "GameObj.sol";
import "BaseStation.sol";

contract WarUnit is GameObj, IWarUnit{
    BaseStation public m_baseStation;
    uint8 public m_attack;

    constructor(BaseStation baseStationAddress, uint16 warUnitHealth) public GameObj(warUnitHealth){
        require(msg.pubkey() == tvm.pubkey(), 102);
        require(tvm.pubkey() != 0, 101);
        tvm.accept();

        baseStationAddress.addWarUnit(this);
        m_baseStation = baseStationAddress;
    }

    // Unit makes attack 
    function doAttack(IGameObj enemyAddress) public{
        tvm.accept();
        enemyAddress.takeAttack(m_attack);
    }

    // This method gets attach force
    function getAttackForce(uint8 attackValue) public {
        tvm.accept();
        m_attack = attackValue;
    }

    function gameOver() public override{
        tvm.accept();
        sendAllMoney(msg.sender);
        m_baseStation.removeWarUnit(this);
    }

    // Modifier for deathFromBaseStation() method
    modifier checkMyBaseStation {
        require(msg.sender == m_baseStation, 105);
        _;
    }

    // This method is called when base station is died
    function deathFromBaseStation(address enemyAddress) public override(IWarUnit) checkMyBaseStation{
        tvm.accept();
        sendAllMoney(enemyAddress);
    }
}