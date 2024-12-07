// ESTA ES UNA IMPLEMENTACION REALIZADA POR CHATGPT. REVISAR EN PROFUNDIDAD.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * @title Adversarial Entropy Game
 * @author 
 * @notice This contract implements a lottery-like adversarial game designed to generate on-chain entropy.
 * @dev Interactions involve depositing ETH to recalculate a lottery number and potentially claim rewards if conditions are met.
 */
contract AdversarialEntropyGame {
    /// @notice Current lottery number stored on-chain.
    bytes32 public lotteryNumber;

    /// @notice Owner address with administrative privileges.
    address public owner;

    /// @notice Total funds accumulated for the game (lottery pot).
    uint256 public gamePot;

    /// @notice Funds reserved for development and donation.
    uint256 public devAndDonationPot;

    /// @notice Minimum required deposit in wei (e.g., 1 gwei).
    uint256 public constant MIN_DEPOSIT = 1e9;

    /// @notice Number of trailing nibbles (hex characters) to be matched to claim the lottery.
    uint8 public matchLength;

    // Events
    event NewNumberGenerated(bytes32 newNumber, address indexed player, uint256 amount);
    event LotteryClaimed(address indexed winner, uint256 amount);
    event DevAndDonationClaimed(address indexed owner, uint256 amount);
    event MatchLengthUpdated(uint8 newMatchLength);

    /**
     * @dev Initializes the contract with a pseudo-random lottery number and sets the owner.
     */
    constructor(uint8 initialMatchLength) {
        owner = msg.sender;
        matchLength = initialMatchLength;
        lotteryNumber = keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender)); // REVISAR. COMO ARRANCA EL JUEGO EN EL DEPLOY?
    }

    /**
     * @dev Modifier that restricts execution to the contract owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    /**
     * @notice Returns the current lottery number stored on-chain.
     * @return The current lottery number.
     */
    function checkNumber() external view returns (bytes32) {
        return lotteryNumber;
    }

    /**
     * @notice Generates a new lottery number. This requires sending a minimum amount of ETH.
     * @dev When called with a sufficient ETH deposit, it redistributes the funds as follows:
     *      - 10% of the deposit goes to devAndDonationPot. LO PODEMOS AJUSTAR.
     *      - 90% of the deposit goes to gamePot
     *      The lottery number is recalculated using the previous number, sender's address, and deposit amount.
     * @custom:requirements The caller must send at least MIN_DEPOSIT wei.
     */
    function getNewNumber() external payable {
        require(msg.value >= MIN_DEPOSIT, "Insufficient ETH sent");

        uint256 devDonationShare = (msg.value * 10) / 100; // 10%
        uint256 gameShare = msg.value - devDonationShare;

        devAndDonationPot += devDonationShare;
        gamePot += gameShare;

        //ESTE ES EL ALGORITMO DE HASH. ES BÁSICO. SI SE LES OCURRE ALGO MEJOR SE PUEDE CAMBIAR.
        lotteryNumber = keccak256(
            abi.encodePacked(
                lotteryNumber, 
                msg.sender, 
                msg.value 
            )
        );

        emit NewNumberGenerated(lotteryNumber, msg.sender, msg.value);
    }

    /**
     * @notice Claims the lottery funds if the last `matchLength` nibbles of the sender's address hash match the lottery number.
     * @dev If the match is successful:
     *      - The winner receives 50% of the current gamePot.
     *      - The remaining 50% stays in the contract.
     */
    function claimLottery() external {
        require(_matchesLastCharacters(msg.sender, lotteryNumber, matchLength), "No match");

        uint256 half = gamePot / 2;
        (bool success, ) = msg.sender.call{value: half}("");
        require(success, "Transfer failed");

        gamePot -= half;

        emit LotteryClaimed(msg.sender, half);
    }

    /**
     * @notice Claims all the development and donation funds.
     * @dev Only the owner can withdraw these funds. They are intended for public goods and contract governance.
     */
    function claimDevelopmentAndDonation() external onlyOwner {
        uint256 amount = devAndDonationPot;
        devAndDonationPot = 0;
        
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Transfer failed");

        emit DevAndDonationClaimed(owner, amount);
    }

    /**
     * @notice Updates the difficulty of the game by changing the number of trailing nibbles to match.
     * @dev Only the owner can change this parameter to adjust game difficulty dynamically.
     * @param _newMatchLength The new number of nibbles (hex characters) that must match.
     */
    function setMatchLength(uint8 _newMatchLength) external onlyOwner {
        matchLength = _newMatchLength;
        emit MatchLengthUpdated(_newMatchLength);
    }

    /**
     * @notice Returns the current state of the contract.
     * @return currentOwner Address of the contract owner.
     * @return currentLotteryNumber Current lottery number.
     * @return currentGamePot Current game pot in wei.
     * @return currentDevAndDonationPot Current development and donation pot in wei.
     * @return currentMinDeposit Minimum deposit required.
     * @return currentMatchLength Number of trailing nibbles required to match.
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
        )
    {
        currentOwner = owner;
        currentLotteryNumber = lotteryNumber;
        currentGamePot = gamePot;
        currentDevAndDonationPot = devAndDonationPot;
        currentMinDeposit = MIN_DEPOSIT;
        currentMatchLength = matchLength;
    }

    /**
     * @dev Internal function to verify whether the last `length` nibbles of the player's address hash 
     *      match the last `length` nibbles of the lottery number.
     * @param player Address of the player attempting to claim.
     * @param number The lottery number to compare against.
     * @param length Number of trailing nibbles to compare.
     * @return True if the last `length` nibbles match, false otherwise.
     */
    function _matchesLastCharacters(address player, bytes32 number, uint8 length) internal pure returns (bool) {
        bytes32 addrHash = keccak256(abi.encodePacked(player));

        // Calculate mask for the last `length` nibbles
        uint256 mask = (16 ** length) - 1;
        uint256 addrVal = uint256(addrHash);
        uint256 numVal = uint256(number);

        uint256 addrSuffix = addrVal & mask;
        uint256 numSuffix = numVal & mask;

        return (addrSuffix == numSuffix);
    }

    /**
     * @dev Fallback function disabled to prevent accidental ETH transfers.
     */
    fallback() external payable {
        revert("Use getNewNumber function to send ETH");
    }

    /**
     * @dev Receive function disabled to prevent accidental ETH transfers.
     */
    receive() external payable {
        revert("Use getNewNumber function to send ETH");
    }
}
