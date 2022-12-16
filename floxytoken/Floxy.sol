/**
 *Submitted for verification at BscScan.com on 2022-12-07
*/

pragma solidity ^0.8.17;

//SPDX-License-Identifier: MIT Licensed

interface IERC20 {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);
    
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        _owner = payable(msg.sender);
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
    
}


// ERC20 standards for token creation

contract Floxy is  IERC20, Ownable {
    
    using SafeMath for uint256;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    
    mapping (address=>uint256) balances;
    mapping (address=>mapping (address=>uint256)) allowed;
    mapping (address=>bool) public frozenAccount;
    event frozenfunds(address target,bool frozen);
    
    constructor(){
        
        _name = "Floxy";
        _symbol = "FXY";
        _decimals = 18;
        _totalSupply = 10000000000;   
        _totalSupply = _totalSupply.mul(10**_decimals);
        balances[owner()] = _totalSupply;
    }

    function name() view public virtual override returns (string memory) {
        return _name;
    }

    function symbol() view public virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() view public virtual override returns (uint8) {
        return _decimals;
    }

    function totalSupply() view public virtual override returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address _owner) view public virtual override returns (uint256) {
        return balances[_owner];
    }
    
    function allowance(address _owner, address _spender) view public virtual override returns (uint256) {
      return allowed[_owner][_spender];
    }
    
    function transfer(address _to, uint256 _amount) public virtual override returns (bool) {
        require (balances[msg.sender] >= _amount, "ERC20: user balance is insufficient");
        require(_amount > 0, "ERC20: amount can not be zero");
        require(!frozenAccount[msg.sender]);
        
        balances[msg.sender]=balances[msg.sender].sub(_amount);
        balances[_to]=balances[_to].add(_amount);
        emit Transfer(msg.sender,_to,_amount);
        return true;
    }
    
    function transferFrom(address _from,address _to,uint256 _amount) public virtual override returns (bool) {
        require(_amount > 0, "ERC20: amount can not be zero");
        require (balances[_from] >= _amount ,"ERC20: user balance is insufficient");
        require(allowed[_from][msg.sender] >= _amount, "ERC20: amount not approved");
        
        balances[_from]=balances[_from].sub(_amount);
        allowed[_from][msg.sender]=allowed[_from][msg.sender].sub(_amount);
        balances[_to]=balances[_to].add(_amount);
        emit Transfer(_from, _to, _amount);
        return true;
    }
  
    function approve(address _spender, uint256 _amount) public virtual override returns (bool) {
        require(_spender != address(0), "ERC20: address can not be zero");
        require(balances[msg.sender] >= _amount ,"ERC20: user balance is insufficient");
        
        allowed[msg.sender][_spender]=_amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
    function freezeAccount(address target, bool freeze)public onlyOwner{
        frozenAccount[target]=freeze;
        emit frozenfunds(target,freeze);
    }

    
    
}
 
library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}
