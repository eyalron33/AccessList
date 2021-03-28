pragma solidity >=0.6.10;

import './Access.sol';
import './Alpress/Alpress.sol';


contract AccessList is Access {
    mapping(address=>bool) authorized;
    address owner; 
    Alpress alpress;


    modifier only_owner {
        require(msg.sender == owner, 'Access denied');
        _;
    }

    modifier only_accesslist_member {
        require(authorized[msg.sender], 'Access denied');
        _;
    }

    constructor(Alpress _alpress, address[] memory _usersList) public {
        owner = msg.sender;

        alpress = _alpress;

        for (uint i=0; i<_usersList.length; i++) {
            authorized[_usersList[i]] = true;
        }
    }

    // grants access to a user
    function grantAccess(address _user) external override only_owner {
        authorized[_user] = true;

        emit AccessGranted(_user);
    }

    function grantBulkAccess(address[] memory _usersList) external override only_owner {
        for (uint i=0; i<_usersList.length; i++) {
            authorized[_usersList[i]] = true;
            emit AccessGranted(_usersList[i]);
        }
    }
    
    // revokes access to a user
    function revokeAccess(address _user) external override only_owner {
        authorized[_user] = false;

        emit AccessRevoked(_user);
    }

    function revokeBulkAccess(address[] memory _usersList) external override only_owner {
        for (uint i=0; i<_usersList.length; i++) {
            authorized[_usersList[i]] = false;
            emit AccessRevoked(_usersList[i]);
        }
    }
    
    // check if a user has access
    function hasAccess(address _user) external view override returns (bool) {
        return authorized[_user];
    }

    // transfer ownership to a new owner
    function transferOwnership(address _new_owner) external override only_owner {
        owner = _new_owner;
    }

    //** Alpress specific functions **//
    function publish(string calldata _name, bytes calldata _contentHash) external only_accesslist_member {
        alpress.publish(_name, _contentHash);
    }

    function buy(string calldata _name) external payable only_accesslist_member {
        alpress.buy(_name);
    }

    function buyAndInitAlpress(string calldata _name, bytes calldata _contentHash) external payable only_accesslist_member {
        alpress.buyAndInitAlpress(_name, _contentHash);
    }

    function renew(string calldata _name) external payable only_accesslist_member {
        alpress.renew(_name);
    }

}