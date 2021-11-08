pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

contract ShoppingList {

     constructor( uint256 pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        m_ownerPubkey = pubkey;
    }

    

    modifier onlyOwner() {
        require(msg.pubkey() == m_ownerPubkey, 101);
        _;
    }

    

    struct Purchase {
        uint32 id;
        string name;
        uint amount;
        uint price;
        uint64 createTime;
        bool isBought;
    }

    struct SummaryPurchase {
        uint paidPurchases;
        uint notPaidPurchases;
        uint totalAmount;
    }

    mapping(uint32 => Purchase) m_purchase;

    uint256 m_ownerPubkey;
    uint32 m_id;

   

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



}
