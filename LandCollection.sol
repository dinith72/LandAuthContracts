pragma solidity >=0.4.22 <0.6.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "./Land.sol";


contract LandCollection {
    //Land[] landCollection ;
    address[] landAddressAccounts ;
    mapping(address => Land) landCollection;
    
    function vallidateAdmin(address admin) private returns (bool){
        return true;
    }
    
    
    // function addNewLand(Land land) public {
    //     require(vallidateAdmin(msg.sender) , 'you are not authorised to handle the trasaction');
    //     address landAddress = land.getLandId();
    //     landCollection[landAddress] = land;
    //     landAddressAccounts.push(landAddress);
        
    //     // landCollection.push(land);
        
    // }
    
    function createNewLand() public {
        require(vallidateAdmin(msg.sender) , 'you are not authorised to handle the trasaction');
        //Land memory land;
        Land land = new Land();
        address landId = land.getLandId();
        landCollection[landId] = land;
        landAddressAccounts.push(landId);
    }
    
    function getLand(address landId) public returns (address) {
        return landCollection[landId].getLandId();
    }
    
    function getOwnerInfo(address landId) public returns (address){
        
        Land land = landCollection[landId];
        return land.getCurrentOwner();
        
    }
}
