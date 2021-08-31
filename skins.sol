pragma solidity^0.8.6;



contract skins{
    string private name;
    uint price;
    bool vfx;
    address immutable private owner;
    event PriceChanged(uint256 indexed  oldPrice, uint256 indexed newPrice);
    constructor(string memory _name, uint _price, bool _vfx,address _owner){
        name = _name;
        price = _price;
        vfx = _vfx;
        owner = _owner;
    }
    modifier checkOwner(address a){
        require(a==owner,"only owner can call it");
        _;

    }
    
    function getOwner() external view returns(address) {
        return owner;
    }

    function getName() external view 
        returns(string memory)
    {
        return name;
    }
    function getPrice () external view returns(uint)
    {
        return price;
    }
    function setPrice(uint p) external
    checkOwner(msg.sender)
     {
         emit PriceChanged(price,p);
         price = p;

    }
    function getVfx() external view 
    returns(bool)
    {
        return vfx;
    }

}
//    constructor(string _name, uint _price, bool _vfx,address _owner){
