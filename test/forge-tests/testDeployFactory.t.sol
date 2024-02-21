pragma solidity ^0.8.17;

import "contracts/factory/TREXGateway.sol";
import "contracts/factory/TREXFactory.sol";
import "@onchain-id/solidity/contracts/factory/IdFactory.sol";
import "contracts/proxy/authority/TREXImplementationAuthority.sol";
import "contracts/proxy/authority/IAFactory.sol";
import "contracts/registry/implementation/ClaimTopicsRegistry.sol";
import "contracts/registry/implementation/IdentityRegistry.sol";
import "contracts/registry/implementation/IdentityRegistryStorage.sol";
import "contracts/registry/implementation/TrustedIssuersRegistry.sol";
import "contracts/compliance/modular/ModularCompliance.sol";
import "forge-std/Test.sol";

contract TestTREXFactory is Test {

    TREXFactory trexFactory;
    TREXGateway trexGateway;
    IdFactory idFactory;
    TREXImplementationAuthority trexImplementationAuthority;

    function setUp() public{

    }

    function testBool() public returns(bool) {
        return true;
    }

}