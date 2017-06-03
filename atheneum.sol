pragma solidity 0.4.8;

//Contract is highest object that can be declared in solidity
contract mortal{

	//Contract will not be deployed to blockchain, unless owner address is saved

	address public owner;
	function mortal(){
		//Set owner to the sender of this contract
		owner = msg.sender;
	}
	
	//Creaete function modifier onlyOwner and assign owner to the contract creator
	modifier onlyOwner{
		if (msg.sender != owner){
			throw;
		}else{
			_;
		}
	}

	//Only the owner of this contract can kill it
	function kill() onlyOwner{
		suicide(owner);
	}
}

contract getUploader is mortal{
    
	mapping(address=>Uploader) public uploaders;

	struct Uploader{
		bool active;
		uint256 cost;
	}

    //Note: cost is set to 1 ETH which is equivalent to 1*10^(17) 
    //To test the payments of microtransactions, the cost may be subject to change
    //after further testing
	function getUploader(address _uploaderAddress){
		uploaders[_uploaderAddress] = Uploader({
		active: true,
		cost: 100000000000000000
		});
	}

	function pay(address _uploaderAddress) payable{

	    if(!_uploaderAddress.send(uploadersp[_uploaderAddress].cost)){
	    	throw;
	    }
	}
}