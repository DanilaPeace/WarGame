pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "GameObj.sol";

contract BaseStation is GameObj{
    address[] public m_warUnitsArray;

    constructor(uint16 baseHealth) public GameObj(baseHealth){
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

    // Funciton to get an index of an unit who died
    function getIndexRemovingUnit(address warUnitAddress) internal returns(uint32){
        for(uint i = 0; i < m_warUnitsArray.length; i++) {
            if(m_warUnitsArray[i] == warUnitAddress) {
                return uint32(i);
            }
        }
    }

    // Remove war unit who died
    function removeWarUnit(address warUnitAddress) external {
        tvm.accept();

        uint32 removingUnitIndex = getIndexRemovingUnit(warUnitAddress);
        for(uint index = removingUnitIndex; index < m_warUnitsArray.length - 1; index++) {
            m_warUnitsArray[index] = m_warUnitsArray[index + 1];
        }
        m_warUnitsArray.pop();
    }

    // Обработка гибили, это же метод есть в родительском объекте GameObject
    function gameOver() public override{
        tvm.accept();
        sendAllMoney(msg.sender);
    }
}