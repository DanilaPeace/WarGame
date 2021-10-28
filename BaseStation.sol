pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "GameObj.sol";

contract BaseStation is GameObj{
    address[] public m_warUnitsArray;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    // Получить силу защиты - берем из нашего родителя
    
    // Добавляем юнита в базу
    function addWarUnit(address warUnitAddress) public {
        tvm.accept();
        m_warUnitsArray.push(warUnitAddress);
    }

    // Убрать воееный юниь
    function removeWarUnit() public {
        // !!! Доработать этот метод !!!
        tvm.accept();
        m_warUnitsArray.pop();
    }

    // Обработка гибили, это же метод есть в родительском объекте GameObject
    function gameOver() public override{
        tvm.accept();
        sendAllMoney(msg.sender);
    }
}