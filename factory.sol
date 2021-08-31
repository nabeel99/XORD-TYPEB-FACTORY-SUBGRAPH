pragma solidity^0.8.6;
import './skins.sol';

contract valorant {
    uint internal skinSalt = 6;
    uint internal createdCounter;
    mapping(uint => address) public skinIDtoAddress;
    event SkinCreated(address indexed skinAddr, uint indexed skinSalt);
    function  getSkinLength() external view returns(uint)
    {
        return createdCounter; 
    }
    
    
    function createContractwithArguments(string memory _name ,uint _price, bool _vfx) external
    returns(address){
        bytes memory temp = getBytecodewithArguments(_name,_price,_vfx);
        address cAddress = _create(temp,skinSalt);
        skinSalt++;
        return cAddress;


    }

    function getBytecodewithArguments(string memory name, uint price, bool vfx) internal view
    returns(bytes memory){
        bytes memory bytecode = type(skins).creationCode;
        return (abi.encodePacked(bytecode,abi.encode(name,price,vfx,address(this))));
        // no argument creation code is is type(contract).creation code, if u wanna pass arguments in bytecode
        //then abiencode packed with bytes code and abi encode of argumetns 

    }
    //create2(0,add(bytecode,32),mload(bytecode),salt)
    function _create(bytes memory bytecode, uint salt) 
    internal
    returns(address skinCAddress)
    

    {
  
       assembly  {

           skinCAddress := create2(0,add(bytecode,32),mload(bytecode),salt)
             if iszero(extcodesize(skinCAddress)) {
                revert(0, 0)
            }
       }
     
        skinIDtoAddress[createdCounter] = skinCAddress;
      
        emit SkinCreated(skinCAddress,salt);
            createdCounter++;
    }
    function changeSkinPrice(address skinAddress,uint _price) external 
    {
        skins(skinAddress).setPrice(_price);

    }


    //address calculator
    //address(uint160(uint(keccak256(bytes1(0xff),address(this),salt,keccak256(type(skin).creationCode or bytecode with arguments))))
}