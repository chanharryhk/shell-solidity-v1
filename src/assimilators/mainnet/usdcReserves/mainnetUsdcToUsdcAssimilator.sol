
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.5.0;

import "abdk-libraries-solidity/ABDKMath64x64.sol";

import "../../../interfaces/IERC20.sol";

import "../../../interfaces/IAssimilator.sol";

contract MainnetUsdcToUsdcAssimilator is IAssimilator {

    using ABDKMath64x64 for int128;
    using ABDKMath64x64 for uint256;

    IERC20 constant usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    constructor () public { }

    function intakeRawAndGetBalance (uint256 _amount) public returns (int128 amount_, int128 balance_) {

        bool _success = usdc.transferFrom(msg.sender, address(this), _amount);

        require(_success, "Shell/USDC-transfer-from-failed");

        uint256 _balance = usdc.balanceOf(address(this));

        amount_ = _amount.divu(1e6);

        balance_ = _balance.divu(1e6);

    }

    function intakeRaw (uint256 _amount) public returns (int128 amount_) {

        bool _success = usdc.transferFrom(msg.sender, address(this), _amount);

        require(_success, "Shell/USDC-transfer-from-failed");

        amount_ = _amount.divu(1e6);

    }

    function intakeNumeraire (int128 _amount) public returns (uint256 amount_) {

        amount_ = _amount.mulu(1e6);

        bool _success = usdc.transferFrom(msg.sender, address(this), amount_);

        require(_success, "Shell/USDC-transfer-from-failed");

    }

    function outputRawAndGetBalance (address _dst, uint256 _amount) public returns (int128 amount_, int128 balance_) {

        bool _success = usdc.transfer(_dst, _amount);

        require(_success, "Shell/USDC-transfer-failed");

        uint256 _balance = usdc.balanceOf(address(this));

        amount_ = _amount.divu(1e6);

        balance_ = _balance.divu(1e6);

    }

    function outputRaw (address _dst, uint256 _amount) public returns (int128 amount_) {

        bool _success = usdc.transfer(_dst, _amount);

        require(_success, "Shell/USDC-transfer-failed");

        amount_ = _amount.divu(1e6);

    }

    function outputNumeraire (address _dst, int128 _amount) public returns (uint256 amount_) {

        amount_ = _amount.mulu(1e6);

        bool _success = usdc.transfer(_dst, amount_);

        require(_success, "Shell/USDC-transfer-failed");

    }

    function viewRawAmount (int128 _amount) public view returns (uint256 amount_) {

        amount_ = _amount.mulu(1e6);

    }

    function viewNumeraireAmount (uint256 _amount) public view returns (int128 amount_) {

        amount_ = _amount.divu(1e6);

    }

    function viewNumeraireBalance (address _addr) public view returns (int128 balance_) {

        uint256 _balance = usdc.balanceOf(_addr);

        balance_ = _balance.divu(1e6);

    }

    function viewNumeraireAmountAndBalance (address _addr, uint256 _amount) public view returns (int128 amount_, int128 balance_) {

        amount_ = _amount.divu(1e6);

        uint256 _balance = usdc.balanceOf(_addr);

        balance_ = _balance.divu(1e6);

    }

}