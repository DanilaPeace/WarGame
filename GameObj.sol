pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";

contract GameObj is IGameObj{
    // Shied Force
    uint8 public m_shielForce;
    int32 public m_health;

    constructor(uint16 health) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

        m_health = int32(health);
    }

    // Get Shield force
    function getShieldForce(uint8 shieldForceValue) public {
        tvm.accept();
        m_shielForce = shieldForceValue;
    }   

    // Take attack. This funciton implements one from interface
    function takeAttack(uint8 attackValue) public override{
        tvm.accept();
        if(!isDead()) {
            // The unit's shield takes part of the attack and unit take damage
            uint8 damage = attackValue - m_shielForce;
            if(damage >= 0) {
                m_health -= damage;
                if(isDead()) {
                    gameOver();
                }
            } 
            else {
                // If unit shield more than attack force damage anyway is  
                m_health--;
            }
        }
        else {
            gameOver();
        }
    }

    // Chech  whether obj is dead
    function isDead() private view returns(bool){
        return m_health <= 0;
    }

    //  Gameover method for obj 
    function gameOver() virtual public {
        tvm.accept();
        sendAllMoney(msg.sender);
    }

    // Send all money and destroy contract
    function sendAllMoney(address enemyAddress) public view{
        tvm.accept();
        enemyAddress.transfer(0, true, 160);
    }
}
