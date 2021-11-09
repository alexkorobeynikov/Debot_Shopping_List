pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "/base/Debot.sol";
import "/base/Terminal.sol";
import "/base/Menu.sol";
import "/base/AddressInput.sol";
import "/base/ConfirmInput.sol";
import "/base/Upgradable.sol";
import "/base/Sdk.sol";



interface IMsig {
   function sendTransaction(address dest, uint128 value, bool bounce, uint8 flags, TvmCell payload  ) external;
}


interface PurchaseList {
   function createPurchase(string text) external;
   function deletePurchase(uint32 id) external;
   function completePurchase(uint32 id, bool done) external;
   function getPurchasesList() external returns (Purchase[] purchasesList);
   function getStat() external returns(SummaryPurchase);
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

abstract contract HasConstructorWithPubKey {
   constructor(uint256 pubkey) public {}
}

