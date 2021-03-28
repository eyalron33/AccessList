pragma solidity >=0.6.10;


interface Access {

    // Logged when granting access to a new user .
    event AccessGranted(address _user);

    // Logged when revoking access of an existing user .
    event AccessRevoked(address _user);

    // grants access to a user
    function grantAccess(address _user) external;
    
    function grantBulkAccess(address[] memory _usersList) external;

    // revokes access to a user
    function revokeAccess(address _user) external;

    function revokeBulkAccess(address[] memory _usersList) external;
    
    // check if a user has access
    function hasAccess(address _user) external view returns (bool);

    // transfer ownership to a new owner
    function transferOwnership(address new_owner) external;

}