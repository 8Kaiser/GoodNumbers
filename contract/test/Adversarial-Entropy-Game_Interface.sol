// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IAdversarialEntropyGame
 * @notice Interface defining the functions, events, and getters of the Adversarial Entropy Game.
 */
interface IAdversarialEntropyGame {
    /// @notice Emitted when a new number is generated.
    event NewNumberGenerated(bytes32 newNumber, address indexed player, uint256 amount);

    /// @notice Emitted when the lottery is successfully claimed.
    event LotteryClaimed(address indexed winner, uint256 amount);

    /// @notice Emitted when the development and donation funds are claimed.
    event DevAndDonationClaimed(address indexed owner, uint256 amount);

    /// @notice Emitted when the match length (difficulty) is updated.
    event MatchLengthUpdated(uint8 newMatchLength);

    /**
     * @notice Returns the current lottery number.
     * @return The current lottery number.
     */
    function lotteryNumber() external view returns (bytes32);

    /**
     * @notice Returns the owner address.
     * @return The owner address.
     */
    function owner() external view returns (address);

    /**
     * @notice Returns the current game pot in wei.
     * @return The current game pot.
     */
    function gamePot() external view returns (uint256);

    /**
     * @notice Returns the development and donation pot in wei.
     * @return The current development and donation pot.
     */
    function devAndDonationPot() external view returns (uint256);

    /**
     * @notice Returns the minimum required deposit in wei.
     * @return The minimum deposit requirement.
     */
    function MIN_DEPOSIT() external view returns (uint256);

    /**
     * @notice Returns the current match length (number of trailing nibbles to match).
     * @return The current match length.
     */
    function matchLength() external view returns (uint8);

    /**
     * @notice Returns the current state of the contract.
     * @return currentOwner The owner's address.
     * @return currentLotteryNumber The current lottery number.
     * @return currentGamePot The current game pot.
     * @return currentDevAndDonationPot The current dev/donation pot.
     * @return currentMinDeposit The minimum deposit required.
     * @return currentMatchLength The current match length.
     */
    function getContractState()
        external
        view
        returns (
            address currentOwner,
            bytes32 currentLotteryNumber,
            uint256 currentGamePot,
            uint256 currentDevAndDonationPot,
            uint256 currentMinDeposit,
            uint8 currentMatchLength
        );

}
