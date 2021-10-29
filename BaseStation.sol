pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "IGameObj.sol";
import "IWarUnit.sol";
import "GameObj.sol";

contract BaseStation is GameObj{
    address[] public m_warUnitsArray;

    constructor(uint16 baseHealth) public GameObj(baseHealth){
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    
    // Add units to the base
    function addWarUnit(address warUnitAddress) public {
        tvm.accept();
        m_warUnitsArray.push(warUnitAddress);
    }

    // Funciton to get an index of an unit who died
    function getIndexRemovingUnit(address warUnitAddress) internal returns(uint32){
        for(uint index = 0; index < m_warUnitsArray.length; index++) {
            if(m_warUnitsArray[index] == warUnitAddress) {
                return uint32(index);
            }
        }
    }

    // Remove war unit who died
    function removeWarUnit(address warUnitAddress) external {
        tvm.accept();
        
        // Here we change units array. Just move the elements of the array for one
        uint32 removingUnitIndex = getIndexRemovingUnit(warUnitAddress);
        for(uint index = removingUnitIndex; index < m_warUnitsArray.length - 1; index++) {
            m_warUnitsArray[index] = m_warUnitsArray[index + 1];
        }

        // Remove last element for reduce the length of the array
        m_warUnitsArray.pop();
    }

    function gameOver() internal override{
        tvm.accept();
        sendAllMoney(msg.sender);

        for(uint index = 0; index < m_warUnitsArray.length; index++) {
            IWarUnit(m_warUnitsArray[index]).deathFromBaseStation(msg.sender);
            this.removeWarUnit(m_warUnitsArray[index]);
        }
    }
}