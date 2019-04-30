pragma solidity ^0.5.0;

import "../IERC1155TokenReceiver.sol";
import "./ERC1820ImplementerInterface.sol";

// Contract to test safe transfer behavior and 1820 compatibility.
contract ERC1820Implementer is ERC1820ImplementerInterface, IERC1155TokenReceiver {

    bool public shouldReject;
    function setShouldReject(bool _value) public {
        shouldReject = _value;
    }

    function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) external returns(bytes4) {
        (_operator);(_from);(_id);(_value);(_data);

        if (shouldReject == true) {
            return ERC1155_REJECTED;
        } else {
            return ERC1155_ACCEPTED;
        }
    }

    function onERC1155BatchReceived(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external returns(bytes4) {
        (_operator);(_from);(_ids);(_values);(_data);

        if (shouldReject == true) {
            return ERC1155_REJECTED;
        } else {
            return ERC1155_BATCH_ACCEPTED;
        }
    }

    /// @notice Indicates whether the contract implements the interface 'interfaceHash' for the address 'addr' or not.
    /// @param interfaceHash keccak256 hash of the name of the interface
    /// @param addr Address for which the contract will implement the interface
    /// @return ERC1820_ACCEPT_MAGIC only if the contract implements 'interfaceHash' for the address 'addr'.
    function canImplementInterfaceForAddress(bytes32 interfaceHash, address addr) external view returns(bytes32) {

        // Note: should check against interfaceHash and addr here, just silence warnings.
        (interfaceHash);(addr);

        return ERC1820_ACCEPT_MAGIC;
    }
}
