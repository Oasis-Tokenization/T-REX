pragma solidity ^0.8.17;

import "contracts/factory/TREXGateway.sol";
import "contracts/factory/TREXFactory.sol";
import "@onchain-id/solidity/contracts/factory/IdFactory.sol";
import "@onchain-id/solidity/contracts/Identity.sol";
import "contracts/proxy/authority/TREXImplementationAuthority.sol";
import "contracts/proxy/authority/IAFactory.sol";
import "contracts/registry/implementation/ClaimTopicsRegistry.sol";
import "contracts/registry/implementation/IdentityRegistry.sol";
import "contracts/registry/implementation/IdentityRegistryStorage.sol";
import "contracts/registry/implementation/TrustedIssuersRegistry.sol";
import "contracts/compliance/modular/ModularCompliance.sol";
import "contracts/token/Token.sol";
import "forge-std/Test.sol";

contract TestTREXFactory is Test {
    
    uint8 constant MAJOR = 4;
    uint8 constant MINOR = 1;
    uint8 constant PATCH = 3;
    
    TREXFactory trexFactory;
    TREXGateway trexGateway;
    IdFactory idFactory;
    TREXImplementationAuthority trexImplementationAuthority;
    ClaimTopicsRegistry claimTopicsRegistry;
    IdentityRegistry identityRegistry;
    IdentityRegistryStorage identityRegistryStorage;
    TrustedIssuersRegistry trustedIssuersRegistry;
    ModularCompliance modularCompliance;
    Token token;

    function setUp() public{
        // deploy implementation contracts
        claimTopicsRegistry = new ClaimTopicsRegistry();
        trustedIssuersRegistry = new TrustedIssuersRegistry();
        identityRegistry = new IdentityRegistry();
        identityRegistryStorage = new IdentityRegistryStorage();
        trustedIssuersRegistry = new TrustedIssuersRegistry();
        modularCompliance = new ModularCompliance();
        token = new Token();
        // set up TREXImplementationAuthority
        trexImplementationAuthority = new TREXImplementationAuthority(true, address(0), address(0));
        ITREXImplementationAuthority.TREXContracts memory contracts = ITREXImplementationAuthority.TREXContracts(address(token), address(claimTopicsRegistry), address(identityRegistry), address(identityRegistryStorage),
            address(trustedIssuersRegistry), address(modularCompliance));
        ITREXImplementationAuthority.Version memory version = ITREXImplementationAuthority.Version(MAJOR, MINOR, PATCH);
        trexImplementationAuthority.addAndUseTREXVersion(version, contracts);
        // deploy factories
        idFactory = 

    }

    function testBool() public returns(bool) {
        return true;
    }

}