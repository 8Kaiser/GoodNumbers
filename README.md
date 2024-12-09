# GoodNumbers

GoodNumbers creates entropy on the blockchain in a decentralized way through agents that compete in either an adversarial or altruistic manner to win prizes or fund social projects.

## INTRODUCTION

Having the goal of generating a decentralized entropy while ensuring that hashes obtained from these interactions are freely accessible to the ecosystem via our contract, GoodNumbers achieves it by allowing users to participate in a lottery-based game (presented as an hexadecimal hash) stored on the blockchain.

To play, participants send a small amount of Ether to the contract (an amount of wei typically equivalent to a few cents). Each contribution modifies the lottery number and increases the accumulated game pool. If a player manages to match the last characters of the lottery with the number his wallet address, he can claim half of the accumulated funds. In this way, adversarial players can compete to win the funds when it becomes economically viable.

The contract allocates a percentage of the deposits to a fund that finances social impact projects. This will encourage the participation of altruistic actors, who’s interaction with the project is motivated by the development of the ecosystem rather than by the potential economic reward – generating additional hashes.

In our opinion, this blend of adversarial and altruistic motivations allows for the development of a more solid, resilient, and enduring system - inspired by a similar mix of altruistic and adversarial incentives seen in major blockchains like Bitcoin and Ethereum.

## Deployment

### CREDENTIALS REQUIRED FOR DEPLOYMENT

To deploy GoodNumbers, you need to have the following API KEYS:

    Alchemy API KEY
    Arbiscan API KEY
    Etherscan API KEY

### DEPENDENCY INSTALLATION

Additionally, you will need to have the following dependencies:

    NPM
    NPX
    Yarn
    HardHat
    ethers.js

Which you can install with the following commands:

    npm init -y
    npm install --save-dev hardhat
    npx hardhat init
    npm install ethers@^6.1.0
    npm install --save-dev @nomicfoundation/hardhat-toolbox
    npx hardhat compile

To make your personal testing interacting with the user interfaces just:

    npm run dev

### CONTRACT DEPLOYMENT ON LOCAL HARDHAT HOW TO

To deploy the contract in a local Hardhat environment, follow these steps:

    In the contract folder execute:
    npx hardhat node
    npx hardhat run scripts/deploy.js --network localhost

    In MetaMask, connect to a new network:
    	Nombre de la red: Localhost 8545
    	URL de la red: http://127.0.0.1:8545
    	ID de la cadena: 1337
    	Moneda: ETH

### CONTRACT DEPLOYMENT ON SEPOLIA NETWORK HOW TO

Para Deployar el contracto en la red de pruebas Sepolia sigue los siguientes pasos:

    Ingresa a la carpeta contract
    npm install dotenv

    Crear el archivo .env y agrega dentro las variables de entorno para el deployment:
    	SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/<alchemy api key>
    	ARBITRUM_SEPOLIA_RPC=https://sepolia-rollup.arbitrum.io/rpc
    	PRIVATE_KEY=<private key del owner del contrato sin 0x>
    	ETHERSCAN_API_KEY=<etherscan api key> # opcional, para verificar el contrato

    En MetaMask:
    	Nombre de la red: Sepolia
    	URL de la red: sepolia.infura.io
    	ID de la cadena: 11155111
    	Moneda: ETH

    Despliega el contrato en Sepolia:
    	npx hardhat run scripts/deploy.js --network sepolia

    Verifica el contrato (opcional):
    	npx hardhat verify --network sepolia <direccion del contrato> 2
    	Obs: "2" es el initialMatchLength que pasaste en el constructor.



### DEPLOYAR EN ARBITRUM

Para Deployar el contracto en la red de pruebas Sepolia-Arbitrum sigue los siguientes pasos:

    Ingresa a la carpeta contract
    npm install hardhat @nomicfoundation/hardhat-toolbox @nomicfoundation/hardhat-verify
    npm install dotenv

    Envia ETHs desde desde la red Sepolia Tesnet hacia Arbitrum:
    	https://bridge.arbitrum.io

    En MetaMask:
    	Nombre de la red: Arbitrum Sepolia
    	URL de la red: sepolia-rollup.arbitrum.io/rpc
    	ID de la cadena: 421614
    	Moneda: ETH
    	Explorador de bloques: sepolia-explorer.arbitrum.io

    Despliega el contrato en Arbitrum Sepolia:
    	npx hardhat run scripts/deploy.js --network arbitrumSepolia

    Verificacion del contrato
    	Se hará automáticamente en el script

    Interactuar con el contrato mediante el script interact.js
    	npx hardhat run scripts/interact.js --network arbitrumSepolia
    	Obs:
    		 La interacción consistía en:
    			Conectarse al contrato desplegado
    			Llamar al método getNewNumber() con un depósito de ETH
    			Obtener el estado actual del contrato


## API Reference

Interaction with the contract is made by using the following functions:

### checkNumber()

Description: This function allows querying the current lottery number stored on the blockchain. It is useful for players and other smart contracts that wish to use this number as part of an entropy-dependent calculations or processes.
Usage: Returns the current number without requiring Ether or special permissions.

### getNewNumber()

Description: Modifies the lottery number stored in the contract, generating a new number based on the current number, the sender's address, and the amount of Ether sent. This process increases the entropy of the system.
Requirement: The player must send a minimum amount of Ether specified in the contract to execute this function.
Goal: To encourage active player participation and the generation of manipulation-resistant random numbers.

### claimLottery()

Description: Allows a player to claim the accumulated funds in the contract if the last characters of their wallet address match the last characters of the current lottery number.
Requirement: The player must meet the match condition to withdraw the funds.
Goal: To encourage adversarial strategies and reward successful players.

### claimDevelopmentAndDonation()

Description: Allows the contract owner to withdraw a percentage of the accumulated funds allocated for development and social donations. It can only be executed by the address designated as the contract owner (e.g., a multisig).
Requirement: Accessible only to the contract administrator.
Goal: Ensure that part of the funds are allocated for contract maintenance and social impact.

### setMatchLength()

Description: Adjusts the length of the hash that must match between the lottery number and a player's address to claim a prize. This parameter controls the difficulty of the game.
Requirement: Can only be executed by the contract owner.
Goal: Enables to adapt the game's difficulty based on player behavior and system needs.

### getContractState()

Description: Provides a complete overview of the current state of the contract, including:
Contract owner.
Current lottery number.
Accumulated funds for prizes and donations.
Minimum deposit required to participate.
Current match length (matchLength).
Usage: Helps players and administrators understand the system's state in a centralized manner.

## Authors

Project authors (in alphabetical order):

- Diego Gil - https://github.com/diegog321
- Danny Grinberg - https://github.com/DannyCodo
- Hoover Zavala - https://github.com/pseeker33
- Juan Pablo Kaiser - https://github.com/8Kaiser

# GoodNumbers

GoodNumbers crea entropía en la Blockchain de manera descentralizada a través de agentes que compiten de manera adversarial o altruista para obtener premios o financiar proyectos sociales.

## INTRODUCTION

Good Numbers permite a los usuarios participar en un juego basado en un número de lotería (presentado como un hash hexadecimal) almacenado en la blockchain, con el objetivo de generar entropía descentralizada y que, como resultado, los hashes de estas interacciones sean de libre acceso al ecosistema a través de nuestro contrato.

Para jugar los participantes envían pequeñas cantidades Ether al contrato (típicamente el wei equivalente a centavos de dólares), lo que modifica el número de la lotería y aumenta el fondo acumulado del juego. Si un jugador consigue que los últimos caracteres del número de lotería coincidan con su dirección de billetera, puede reclamar la mitad de los fondos acumulados. De esta manera, los jugadores adversariales pueden competir por llevarse los fondos cuando les sea económicamente viable.

El contrato también destina un porcentaje de los depósitos a un fondo para financiar proyectos que generen impacto social. Incentivando así la participación de actores altruistas que interactúen con el proyecto generando hashes motivados por el desarrollo del ecosistema y no por la posible recompensa económica.

En nuestra opinión este balance entre la adversarialidad y el altruismo permite el desarrollo de un sistema sólido, resilente y perdurable en el tiempo, siendo nuestra inspiración la forma en que funcionan los incentivos altruistas y adversariales de las principales Blockchains como Bitcoin y Ethereum.

## Deployment

### CREDENCIALES NECESARIAS PARA EL DEPLOYMENT

Para poder Deployear GoodNumbers necesitas contar con las siguientes API KEYS:

    Alchemy API KEY
    Arbiscan API KEY
    Etherscan API KEY

### INSTALACION DE DEPENDENCIAS

Adicionalmente vas a requerir contar con las siguientes dependencias:

    NPM
    NPX
    Yarn
    HardHat
    ethers.js

Que puedes instalar con los siguientes comandos:

    npm init -y
    npm install --save-dev hardhat
    npx hardhat init
    npm install ethers@^6.1.0
    npm install --save-dev @nomicfoundation/hardhat-toolbox
    npx hardhat compile

### DEPLOYAR EL CONTRATO EN HARDHAT LOCAL

Para Deployar el contracto en un entorno Hardhat local sigue los siguientes pasos:

    Ingresa a la carpeta contract
    npx hardhat node
    npx hardhat run scripts/deploy.js --network localhost

    Conectar a una nueva red en MetaMask:
    	Nombre de la red: Localhost 8545
    	URL de la red: http://127.0.0.1:8545
    	ID de la cadena: 1337
    	Moneda: ETH

### DEPLOYAR EL CONTRATO EN SEPOLIA

Para Deployar el contracto en la red de pruebas Sepolia sigue los siguientes pasos:

    Ingresa a la carpeta contract
    npm install dotenv

    Crear el archivo .env y agrega dentro las variables de entorno para el deployment:
    	SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/<alchemy api key>
    	ARBITRUM_SEPOLIA_RPC=https://sepolia-rollup.arbitrum.io/rpc
    	PRIVATE_KEY=<private key del owner del contrato sin 0x>
    	ETHERSCAN_API_KEY=<etherscan api key> # opcional, para verificar el contrato

    En MetaMask:
    	Nombre de la red: Sepolia
    	URL de la red: sepolia.infura.io
    	ID de la cadena: 11155111
    	Moneda: ETH

    Despliega el contrato en Sepolia:
    	npx hardhat run scripts/deploy.js --network sepolia

    Verifica el contrato (opcional):
    	npx hardhat verify --network sepolia <direccion del contrato> 2
    	Obs: "2" es el initialMatchLength que pasaste en el constructor.



### DEPLOYAR EN ARBITRUM

Para Deployar el contracto en la red de pruebas Sepolia-Arbitrum sigue los siguientes pasos:

    Ingresa a la carpeta contract
    npm install hardhat @nomicfoundation/hardhat-toolbox @nomicfoundation/hardhat-verify
    npm install dotenv

    Envia ETHs desde desde la red Sepolia Tesnet hacia Arbitrum:
    	https://bridge.arbitrum.io

    En MetaMask:
    	Nombre de la red: Arbitrum Sepolia
    	URL de la red: sepolia-rollup.arbitrum.io/rpc
    	ID de la cadena: 421614
    	Moneda: ETH
    	Explorador de bloques: sepolia-explorer.arbitrum.io

    Despliega el contrato en Arbitrum Sepolia:
    	npx hardhat run scripts/deploy.js --network arbitrumSepolia

    Verificacion del contrato
    	Se hará automáticamente en el script

    Interactuar con el contrato mediante el script interact.js
    	npx hardhat run scripts/interact.js --network arbitrumSepolia
    	Obs:
    		 La interacción consistía en:
    			Conectarse al contrato desplegado
    			Llamar al método getNewNumber() con un depósito de ETH
    			Obtener el estado actual del contrato


## API Reference

Puedes interactuar con el contrato utilizando las siguientes funciones:

### checkNumber()

Descripción: Esta función permite consultar el número actual de la lotería almacenado en la blockchain. Es útil para los jugadores y otros contratos que deseen usar este número como parte de cálculos o procesos dependientes de entropía.
Uso: Simplemente devuelve el número actual sin requerir Ether ni permisos especiales.

### getNewNumber()

Descripción: Modifica el número de lotería almacenado en el contrato, generando un nuevo número basado en el número actual, la dirección del remitente y la cantidad de Ether enviada. Este proceso incrementa la entropía del sistema.
Requisito: El jugador debe enviar una cantidad mínima de Ether especificada en el contrato para ejecutar esta función.
Objetivo: Fomenta la participación activa de los jugadores y la generación de números aleatorios resistentes a manipulaciones.

### claimLottery()

Descripción: Permite a un jugador reclamar los fondos acumulados en el contrato si los últimos caracteres de su dirección de billetera coinciden con los últimos caracteres del número de lotería actual.
Requisito: El jugador debe cumplir con la condición de coincidencia para poder retirar los fondos.
Objetivo: Incentivar estrategias adversariales y premiar a los jugadores exitosos.

### claimDevelopmentAndDonation()

Descripción: Permite al propietario del contrato retirar un porcentaje de los fondos acumulados destinado al desarrollo y donaciones sociales. Solo puede ser ejecutada por la dirección designada como propietaria del contrato (por ejemplo, una multisig).
Requisito: Accesible únicamente para el administrador del contrato.
Objetivo: Asegurar que parte de los fondos se destinen al mantenimiento del contrato y al impacto social.

### setMatchLength()

Descripción: Ajusta la longitud del hash que debe coincidir entre el número de lotería y la dirección de un jugador para reclamar un premio. Este parámetro controla la dificultad del juego.
Requisito: Solo puede ser ejecutada por el propietario del contrato.
Objetivo: Adaptar la dificultad del juego según el comportamiento de los jugadores y las necesidades del sistema.

### getContractState()

Descripción: Proporciona un resumen completo del estado actual del contrato, incluyendo:
El propietario del contrato.
El número de lotería actual.
Los fondos acumulados para premios y donaciones.
El depósito mínimo requerido para participar.
La longitud actual de la coincidencia (matchLength).
Uso: Ayuda a los jugadores y administradores a comprender el estado del sistema de forma centralizada.

## Authors

Autores del proyecto (en orden alfabético):

- Diego Gil - https://github.com/diegog321
- Danny Grinberg - https://github.com/DannyCodo
- Hoover Zavala - https://github.com/pseeker33
- Juan Pablo Kaiser - https://github.com/8Kaiser
