pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "GameObj.sol";
import "BaseStation.sol";

contract WarUnit is GameObj{
    address public m_baseStationAddress;
    uint8 public m_attack;

    constructor(BaseStation baseStationAddress, uint16 warUnitHealth) public GameObj(warUnitHealth){
        require(msg.pubkey() == tvm.pubkey(), 102);
        require(tvm.pubkey() != 0, 101);
        tvm.accept();

        baseStationAddress.addWarUnit(this);
        m_baseStationAddress = baseStationAddress;
    }

    // Атаковать
    function doAttack(IGameObj enemyAddress) public{
        tvm.accept();
        enemyAddress.takeAttack(m_attack);
    }

    // Получить силу атаки
    function getAttackForce(uint8 attackValue) public {
        tvm.accept();
        m_attack = attackValue;
    }
    
    // Получить силу защиты - берем из нашего родителя

    // Обработка гибили, это же метод есть в родительском объекте GameObject
    function gameOver() public override{
        tvm.accept();
        sendAllMoney(msg.sender);
    }

    // Смерть из-за базы
    function deathFromBaseStation() public {
        // !!! Доработать этот метод !!!
        tvm.accept();
        sendAllMoney(msg.sender);
    }
}