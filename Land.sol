pragma solidity >=0.5.11 <0.6.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
// import "./LandOwner.sol";

contract Land{
    
  struct LandOwner{
    address ownerId; // address of the owner account 
    uint ownedFrom; // starting dateof the owning land 
    uint ownedTo; // ending date of the land onership 
    
}

    address landId;
    LandOwner[] public landOwners;
    bool landStatus; // if TRUE the land is still active 
    address[] preceedingLands;  
    address[] succedingLands; 
    
    function isLandActive() private returns(bool){
        return landStatus;
    }
    
    function updateOwner(address newOwnerAddress) public {
        
        //  assert(vallidateOwner());  
        require(vallidateOwner(),'Invalid Owner');
        require(isLandActive(),'You are trying update info in an archived land');
        LandOwner memory newOwner;
        newOwner.ownerId = newOwnerAddress;
        newOwner.ownedFrom = now;
        landOwners.push(newOwner);
       
        
    }
    
    function getCurrentOwner() public returns (address) {
        uint256 index = landOwners.length - 1;
        return landOwners[index].ownerId ;
    }
    
    function makeLandRedundant(address newLandAdress) public {
        require(vallidateAdmin() , 'You does not have the priviledge to perform this action ');
        require(isLandActive(),'You are trying update info in an archived land');
        landStatus = false;
        // for(uint256 i = 0; i < newLandAdress.length ; i++){
        //     succedingLands.push(newLandAdress[i]);
        // }
        succedingLands.push(newLandAdress);
        
    }
    
    constructor() public {
        landId = msg.sender;
        uint currentTime = now;
        
         LandOwner memory firstOwner;
         firstOwner.ownerId = msg.sender;
        firstOwner.ownedFrom = currentTime;
        landOwners.push(firstOwner);
    }
        
    
    
    function getLandId() public returns(address) {
        return landId;
    }
    
    function vallidateOwner() private returns(bool){
        address requestUser = msg.sender;
        uint latestOwner = landOwners.length - 1;
        address currentOwner = landOwners[latestOwner].ownerId;
        if(requestUser == currentOwner){
            return true;
        }
        else {
            return false;
        }
    }
    
    function vallidateAdmin() private returns(bool){
        return true;
    }
    
    

}
