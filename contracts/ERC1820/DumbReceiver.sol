pragma solidity ^0.5.0;

import "./IERC1820Registry.sol";

// Contract to be sent 1155's without knowing they exist (will have 1820 implementor to say it can receive them).
contract DumbReceiver {

    IERC1820Registry private _erc1820;

    // just use ERC1155_ACCEPTED as our interface hash for now
    bytes32 constant private ERC1155_1820_IMPLEMENTOR_HASH = keccak256("ERC1155Token");

    // this should ideally be hard-coded to the vanity address on test/main net but that makes local testing a mess.
    function set1820Registry(address _registry) external {
        require(address(_erc1820) == address(0x0));
        _erc1820 = IERC1820Registry(_registry);
    }

    // this is not likely to be a function present in smart wallets but is here for testing purposes to
    // set things up like they might (could also be done on construction for example).
    function set1820Interface(address _implementor) external {
        _erc1820.setInterfaceImplementer(address(this), ERC1155_1820_IMPLEMENTOR_HASH, _implementor);
    }
}
