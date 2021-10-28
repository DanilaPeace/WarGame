pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface IGameObj {
    function takeAttack(uint8 attackValue) external;
}