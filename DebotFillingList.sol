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


    function createPurchase(uint32 index) public {
        index = index;
        Terminal.input(tvm.functionId(createTask_), "One line please:", false);
    }

    function createPurchase_(string value) public view {
        optional(uint256) pubkey = 0;
        PurchaseList(m_address).createPurchase{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(value);
    }





}


