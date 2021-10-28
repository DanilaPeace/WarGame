pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";

contract GameObj is IGameObj{
    // Защитная сила
    uint8 public m_shielForce;
    uint8 public m_health = 50;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    // Получить силу защиты
    function getShieldForce(uint8 shieldForceValue) public {
        tvm.accept();
        m_shielForce = shieldForceValue;
    }   

    // Принять атаку
    function takeAttack(uint8 attackValue) public override{
        tvm.accept();
        m_health -= attackValue;
    }

    // Проверка убит ли объект
    function isDead() private view returns(bool){
        return m_health <= 0;
    }

    // Обработка гибили
    function gameOver() virtual public {
        tvm.accept();
        sendAllMoney(msg.sender);
    }

    // Метод для самоуничтожения
    function sendAllMoney(address enemyAddress) public view{
        tvm.accept();
        enemyAddress.transfer(0, true, 160);
    }
}
