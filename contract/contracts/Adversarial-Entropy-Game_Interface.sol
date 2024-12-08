
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * @title IAdversarialEntropyGame
 * @notice Interface defining the functions, events, and getters of the Adversarial Entropy Game.
 */
interface IAdversarialEntropyGame {
    /// @notice Emitted when a new number is generated.
    //Se emite cada vez que se genera un nuevo número de lotería
    event NewNumberGenerated(bytes32 newNumber, address indexed player, uint256 amount);
    //newNumber: El nuevo número generado player: Dirección del jugador que generó el número. amount: Cantidad de ETH enviada para generar el número.
    /// @notice Emitted when the lottery is successfully claimed.
    //LotteryClaimed: Se emite cuando alguien reclama el premio de la lotería.
    event LotteryClaimed(address indexed winner, uint256 amount);
    //DevAndDonationClaimed: Se emite cuando los fondos de desarrollo/donación son reclamados.
    /// @notice Emitted when the development and donation funds are claimed.
    event DevAndDonationClaimed(address indexed owner, uint256 amount);
    //MatchLengthUpdated: Se emite cuando se actualiza la dificultad del juego (longitud del match).
    /// @notice Emitted when the match length (difficulty) is updated.
    event MatchLengthUpdated(uint8 newMatchLength);

    /**
     * @notice Returns the current lottery number.
     * @return The current lottery number.
     */
    function lotteryNumber() external view returns (bytes32);
    //MatchLengthUpdated: Se emite cuando se actualiza la dificultad del juego (longitud del match).
    /**
     * @notice Returns the owner address.
     * @return The owner address.
     */
    function owner() external view returns (address);
    //owner(): Devuelve la dirección del propietario del contrato.

    /**
     * @notice Returns the current game pot in wei.
     * @return The current game pot.
     */
    function gamePot() external view returns (uint256);
    //gamePot(): Muestra la cantidad acumulada en el pozo del juego.

    /**
     * @notice Returns the development and donation pot in wei.
     * @return The current development and donation pot.
     */
    function devAndDonationPot() external view returns (uint256);
    //devAndDonationPot(): Devuelve los fondos destinados a desarrollo y donaciones.

    /**
     * @notice Returns the minimum required deposit in wei.
     * @return The minimum deposit requirement.
     */
    function MIN_DEPOSIT() external view returns (uint256);
    //MIN_DEPOSIT(): Devuelve el depósito mínimo requerido para participar.


    /**
     * @notice Returns the current match length (number of trailing nibbles to match).
     * @return The current match length.
     */
    function matchLength() external view returns (uint8);
    //matchLength(): Devuelve la longitud actual del match (dificultad).

    /**
     * @notice Returns the current state of the contract.
     * @return currentOwner The owner's address.
     * @return currentLotteryNumber The current lottery number.
     * @return currentGamePot The current game pot.
     * @return currentDevAndDonationPot The current dev/donation pot.
     * @return currentMinDeposit The minimum deposit required.
     * @return currentMatchLength The current match length.
     */
     //Devuelve toda la información clave del contrato en una sola llamada
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

    /**
     * @notice Reads the current lottery number.
     * @return The current lottery number.
     */
     //checkNumber(): Devuelve el número actual de la lotería.
    function checkNumber() external view returns (bytes32);

    /**
     * @notice Generates a new lottery number by sending at least the minimum required ETH.
     * @dev Updates lotteryNumber and redistributes incoming funds.
     */
    function getNewNumber() external payable;
    //Genera un nuevo número de lotería.
    /**
     * @notice Claims the lottery pot if the sender's address matches the trailing nibbles of the lottery number.
     */
    function claimLottery() external;
    //Permite que un jugador reclame el premio de la lotería si su dirección cumple con ciertas condiciones (por ejemplo, coincide con parte del número de lotería).

    /**
     * @notice Claims the development and donation funds, only callable by the owner.
     */
    function claimDevelopmentAndDonation() external;
    //Permite al propietario reclamar los fondos acumulados para desarrollo y donaciones.

    /**
     * @notice Updates the match length (game difficulty), only callable by the owner.
     * @param _newMatchLength New number of trailing nibbles to match.
     */
    function setMatchLength(uint8 _newMatchLength) external;
    //El propietario puede actualizar la dificultad del juego cambiando la longitud del "match".
}
