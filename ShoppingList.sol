pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

import "PurchaseListInterfaces.sol";

contract ShoppingList is PurchaseListInterfaces {




     constructor( uint256 pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        m_ownerPubkey = pubkey;
    }

    

    modifier onlyOwner() {
        require(msg.pubkey() == m_ownerPubkey, 101);
        _;
    }



     function createPurchase(string text, uint amount) public onlyOwner {
        tvm.accept();
        m_id++;
        m_purchase[m_id] = Purchase(m_id, text, amount, 0, now, false);
    }

    function deletePurchase(uint32 id) public onlyOwner{
        tvm.accept();
        delete m_purchase[id];
    }

    function completePurchase(uint32 id, uint price ) public onlyOwner{
        tvm.accept();
        m_purchase[id].price = price;
        m_purchase[id].isBought = true;

    }

    function getPurchasesList() public view returns (Purchase[] purchases) {
        string name;
        uint amount;
        uint price;
        uint64 createTime;
        bool isBought;

        for((uint32 id, Purchase purchase) : m_purchase) {
            name = purchase.name;
            amount = purchase.price;
            price = purchase.price;
            createTime = purchase.createTime;
            isBought = purchase.isBought;
            purchases.push(Purchase(id, name, amount, price, createTime, isBought));
       }
    }


     function getStat() public view returns (SummaryPurchase stat) {
        uint32 paidPurchases;
        uint32 notPaidPurchases;
        uint totalAmount;

        for((, Purchase purchase) : m_purchase) {
            if  (purchase.isBought) {
                paidPurchases ++;
                totalAmount += purchase.price;
            } else {
                notPaidPurchases ++;
            }
        }
        stat = SummaryPurchase( paidPurchases, notPaidPurchases, totalAmount );
    }



}
