//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

 
import "@openzeppelin/contracts/utils/Counters.sol"; // using as a counter which keep track of id and counter
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // Using ERC721 standard
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract OrianNFTs is ERC721URIStorage.sol {
using Counters for Counter.Counter;

Counters.Counter private _tokenIds;
Counters.Counter private _itemsSold;

//state variable
uint256  listingPrice =0.0025 ether;
address payable owner;
mapping(uint256 =>MarketItem) private idMarketItem;

//this strcut will keep all the inforamtion  of any partiuclar nft
struct MarketIetm{
uint256 tokenId;
address payable seller;
address payable owner;
uint256 price;
bool sold;
}

// now we have to trigger the event
// whenever any kind of txn happens we have to trigger the event

event idMarketItemCreated(
    uint256 indexed tokenId,
    address seller,
    address owner,
    uint256 price,
    bool sold,
);
modifier onlyOwner(){
    require(
        msg.sender==owner,"only owner of the marketplace can change the listing price");
        _;
    )
}
// coming from openzeppelin
constructor() ERC721("Dash NFT Token","DNFT"){
    owner= payable(msg.sender);
}

//as a marketplace owner i want  to charge some price 

function updateListingPrice(uint256 _listingPrice) public payable onlyOwner{
    listingPrice=_listingPrice;
} 

//reading the price is state variable so use "view"
function getListingPrice() public view returns(uint256) {
    return listingPrice;
}

//creaing "NFT Token Function"
// here tokenId contains  all the metadat of the NFT
funtion createToken(string memory tokenURI, uint256 price) public{
    _tokenIds.increment();
    uint newTokenId= _tokenIds.current();

    //function coming from openzeppelin
    _mint(msg.sender,newTokenId);
    _setTokenURI(newTokenId,tokenURI);

    createMarketItem(newTokenId,price);

    return newTokenId;

}

// creating marketItem that will be called internally
function createMarketItem(uint256 tokenId, uint256 price) private {
require(price>0,"price must be greater than zero");
require(msg.value==listingPrice,"Price must be equal to listing price");

idMarketItem[tokenId]== MarketItem(
    tokenId,
    payable(msg.sender),
    payable(address(this)), //who iis creating nFT
    price,
    false,
);
_transfer(msg.sender,address(this),tokenId);

emit itMarketItemCreated(
    tokenId,
    msg.sender,
    address(this),
    price,
    false
);
}

//function for resale the nft token on higher price
function reSaleToken(uint256 tokenId,uint256 price) public payable {
    require(idMarketItem[tokenId].owner==msg.sender,"Only owner can do this this operation");

    require(msg.value==listingPrice ,"price must be equal to listing price");

    idMarketItem[tokenId].sold=false;
    idMarketItem[tokenId].price=price;
    idMarketItem[tokenId].seller=payable(msg.sender);
    idMarketItem[tokenId].owner=payable(address(this));

    // when somenone buys any particular nft the count increments
    //but when someone sell the nfts count decrements
    _itemsSold.decrement();

    _transfer(msg.sender,address(this),tokenId);   
}
//function for creating market sell
function createMarketSale(uint256 tokenId) public payable{
    uint256 price= idMarketItem[tokenid].price; // what is the live price of NFTs
    require(
        msg.value==price,
        "Please submit the asking price in order to complete the purchase"
    );

// the person will become owner after calling this function
    idMarketItem[tokenId].owner=payable(msg.sender);
    idMarketItem[tokenId].sold=true;
    idMarketItem[tokenId].owner=payable(address(0));

    _transfer(address(this),msg.sender,tokenId);
    payable(owner).transfer(listingPrice); //tking commision as nftMarketplace owner
    payable(idMarketItem[tokenId].seller).transfer(msg.value); // and transfer rest money to the seller
}

//getting unsold NFT data
function fetchMarketItem() public view retunrs (MarketItem[] memory){
    uint256 itemCount=_tokenIds.current(); // total nfts till now
    uint256 usSoldItemCount =_tokenIds.current() - _itemSold.current();
    uint256 currentIndex=0;

    MarketItem[] memory items =new MarketItem[](unSoldItemCount); // length of the array would be unSoldItems
    for(uint256 i=0;i<itemCount;i++){
        if(idMarketItem[i+1].owner==address(this)){
            uint256 currentId=i+1;
            MarketItem storage currentItem= idMarketItem[currentId];
            items[currentIndex]=currentItem;
            currentIndex+=1;
        }
    }
    return items;
}

//purchase Items functin

function fetchMyNFT() public view returns(MarketItem[] memory){
    uint256 totalCount= _tokenIds.current();
    uint256 itemCount =0;
    uint256 currentIndex=0;

    for(uint256 i=0;i<totalCount;i++){
        if(idMarketItem[i+1].owner==msg.sender){
            itemCount+=1;
        }
    }

    MarketItem[] memory items =new MarketItem[](itemCount);
    for(uint256 i=0;i<totalCount;i++){
        if(idMarketItem[i+1].owner==msg.sender){
            uint256 currentId=i+1;
            MarketItem storage currentItem=idMarketItem[currentId];
            items[currentIndex]=currentItem;
            currentIndex+=1;
        }
    }
    return items; 
}

//single user items
function fetchItemsListed() public view returns(MarketItem[] memory){
uint256 totalCount=_tokenIds.current();
uint256 itemCount=0;
uint256 currentIndex=0;

for(uint256 i=0;i<totalCount;i++){
    //nft seller and owner is the same
    if(idMarketItem[i+1].seller==msg.sender){

        itemCount+=1;
    }
}
MarketItem[] memory items= new MarketItem[](itemCount);
for(uint256 =0 ;i<totalCount;i++){
if(idMarketItem[i+1].seller=msg.sender){
    uint245 currentId=i+1;

    MarketItem storage currentItem = idMarketItem[currentId];
    items[currentIndex]=currentItem;
    currentIndex+=1;
}
}
return items;
}
}
