pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

import "DebotInitList.sol";

contract DebotFillingList is  DebotInitList {

    function setStat(SummaryPurchase stat) public {
        m_stat = stat;
        _menu();
    }



    function _menu() private {
        
        Menu.select(
            [
                MenuItem("Add purchase in list","",tvm.functionId(createPurchase)),
                MenuItem("Show purchase list","",tvm.functionId(showList)),
                MenuItem("Delete purchase","",tvm.functionId(deletePurchase))
            ]
        );
    }

    



}


