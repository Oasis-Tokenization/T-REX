pragma solidity ^0.8.17;

import "contracts/factory/TREXGateway.sol";
import "contracts/factory/TREXFactory.sol";
import "@onchain-id/solidity/contracts/factory/IdFactory.sol";
import "@onchain-id/solidity/contracts/Identity.sol";
import "@onchain-id/solidity/contracts/proxy/ImplementationAuthority.sol";
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
    ImplementationAuthority implementationAuthority;
    Identity identity;
    TREXImplementationAuthority trexImplementationAuthority;
    IAFactory iaFactory;
    ClaimTopicsRegistry claimTopicsRegistry;
    IdentityRegistry identityRegistry;
    IdentityRegistryStorage identityRegistryStorage;
    TrustedIssuersRegistry trustedIssuersRegistry;
    ModularCompliance modularCompliance;
    Token token;

    event TREXSuiteDeployed(address indexed _token, address _ir, address _irs, address _tir, address _ctr, address
    _mc, string indexed _salt);
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
        // deploy OnchainID factories
        identity = new Identity(address(this), true);
        implementationAuthority = new ImplementationAuthority(address(identity));
        idFactory = new IdFactory(address(implementationAuthority));
        // deploy TREXFactory
        trexFactory = new TREXFactory(address(trexImplementationAuthority), address(idFactory));
        // set TREXFactory on IdFactory
        idFactory.addTokenFactory(address(trexFactory));
        // deploy IAFactory
        iaFactory = new IAFactory(address(trexFactory));
        // set factories on TREXImplementationAuthority
        trexImplementationAuthority.setTREXFactory(address(trexFactory));
        trexImplementationAuthority.setIAFactory(address(iaFactory));
    }

    function testBool() public returns(bool) {
        return true;
    }

    function testDeployTREXSuite() public returns(bool) {
        address[] memory arrAddr = new address[](0);
        bytes[] memory arrBytes = new bytes[](0);
        uint256[] memory arrUint = new uint[](0);
        uint256[][] memory arrUint2 = new uint[][](0);
        bytes memory salt = abi.encodePacked(address(this), "TEST");
        ITREXFactory.TokenDetails memory tokenDetails = ITREXFactory.TokenDetails(
            address(this),
            "TEST",
            "TST",
            18,
            address(0),
            address(0),
            arrAddr,
            arrAddr,
            arrAddr,
            arrBytes
        );
        ITREXFactory.ClaimDetails memory claimDetails = ITREXFactory.ClaimDetails(
            arrUint,
            arrAddr,
            arrUint2
        );
        vm.expectEmit(false, true, false, false);
        emit TREXSuiteDeployed(address(0), address(0), address(0), address(0), address(0), address(0), string(salt));
        trexFactory.deployTREXSuite(string(salt), tokenDetails, claimDetails);

    }

}