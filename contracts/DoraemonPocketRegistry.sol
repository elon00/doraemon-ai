// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DoraemonPocketRegistry
 * @dev 22nd-Century 4D Pocket Spatial Compute & Gadget Registry Protocol
 */
contract DoraemonPocketRegistry {
    struct Gadget {
        string name;
        bytes32 dimensionalCoordinates;
        uint256 dorayakiCost;
        bool isAvailable;
    }

    mapping(bytes32 => Gadget) public pocketGadgets;
    address public immutable doraemonAdmin;
    uint256 public totalGadgetsRetrieved;

    event GadgetDispensed(bytes32 indexed gadgetId, string name, address indexed recipient);
    event AnywhereDoorOpened(bytes32 indexed origin, bytes32 indexed destination);

    constructor() {
        doraemonAdmin = msg.sender;
        _registerGadget(keccak256("ANYWHERE_DOOR"), "Anywhere Door (Dokodemo Door)", 50);
        _registerGadget(keccak256("TIME_MACHINE"), "Time Machine (Time Machine)", 100);
        _registerGadget(keccak256("BAMBOO_COPTER"), "Bamboo Copter (Take-Copter)", 10);
        _registerGadget(keccak256("TRANSLATION_GUMMY"), "Translation Gummy (Honyaku Konnyaku)", 15);
    }

    function _registerGadget(bytes32 id, string memory name, uint256 cost) internal {
        pocketGadgets[id] = Gadget({
            name: name,
            dimensionalCoordinates: keccak256(abi.encodePacked(id, block.timestamp)),
            dorayakiCost: cost,
            isAvailable: true
        });
    }

    function retrieveGadget(bytes32 gadgetId) external payable {
        Gadget storage g = pocketGadgets[gadgetId];
        require(g.isAvailable, "Gadget unavailable in 4D pocket");
        require(msg.value >= g.dorayakiCost, "Insufficient Dorayaki collateral");

        totalGadgetsRetrieved += 1;
        emit GadgetDispensed(gadgetId, g.name, msg.sender);
    }

    function openAnywhereDoor(bytes32 destination) external {
        emit AnywhereDoorOpened(keccak256(abi.encodePacked(msg.sender)), destination);
    }
}
