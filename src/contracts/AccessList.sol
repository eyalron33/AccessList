pragma solidity >=0.8.2;

import './Access.sol';


contract AccessList is Access {

    mapping(address=>bool) authorized;

    constructor(address[] memory _usersList) {
        for (uint i=0; i<_usersList.length; i++) {
            authorized[_usersList[i]] = true;
        }
    }

    // grants access to a user
    function grantAccess(address _user) external override {
        authorized[_user] = true;
    }

    function grantBulkAccess(address[] memory _usersList) external override {
        for (uint i=0; i<_usersList.length; i++) {
            authorized[_usersList[i]] = true;
        }
    }
    
    // revokes access to a user
    function revokeAccess(address _user) external override {
        authorized[_user] = false;
    }

    function revokeBulkAccess(address[] memory _usersList) external override {
        for (uint i=0; i<_usersList.length; i++) {
            authorized[_usersList[i]] = false;
        }
    }
    
    // check if a user has access
    function hasAccess(address _user) external view override returns (bool) {
        return authorized[_user];
    }
}