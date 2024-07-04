// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { ERC20Base } from "ecdysisxyz/erc20/src/main/functions/ERC20Base.sol";
import { Schema as ERC20Schema } from "ecdysisxyz/erc20/src/main/storage/Schema.sol";
import { Storage as ERC20Storage } from "ecdysisxyz/erc20/src/main/storage/Storage.sol";
import { Schema } from "../storage/Schema.sol";
import { Storage } from "../storage/Storage.sol";

contract MyToken is ERC20Base {
    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        ERC20Schema.GlobalState storage s = ERC20Storage.state();
        s.name = _name;
        s.symbol = _symbol;
        s.decimals = _decimals;
    }

    function mint(address account, uint256 amount) external {
        // ここにミント権限のチェックロジックを追加
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external {
        // ここにバーン権限のチェックロジックを追加
        _burn(account, amount);
    }

    // カスタム機能の例：転送時に手数料を徴収
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        uint256 fee = amount / 100; // 1%の手数料
        uint256 amountAfterFee = amount - fee;
        
        _transfer(owner, to, amountAfterFee);
        _transfer(owner, address(this), fee); // 手数料をコントラクトに転送
        
        return true;
    }
}
