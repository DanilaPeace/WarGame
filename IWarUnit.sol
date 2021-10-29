pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface IWarUnit {
    function deathFromBaseStation(address enemyAddress) external;
}