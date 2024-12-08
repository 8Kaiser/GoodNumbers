
# GoodNumbers

Good Numbers permite a los usuarios participar en un juego basado en un número de lotería (presentado como un hash hexadecimal) almacenado en la blockchain, con el objetivo de generar entropía descentralizada y que, como resultado, los hashes de estas interacciones sean de libre acceso al ecosistema a través de nuestro contrato. 

Para jugar los participantes envían pequeñas cantidades Ether al contrato (típicamente el wei equivalente a centavos de dólares), lo que modifica el número de la lotería y aumenta el fondo acumulado del juego. Si un jugador consigue que los últimos caracteres del número de lotería coincidan con su dirección de billetera, puede reclamar la mitad de los fondos acumulados. De esta manera, los jugadores adversariales pueden competir por llevarse los fondos cuando les sea económicamente viable.

El contrato también destina un porcentaje de los depósitos a un fondo para financiar proyectos que generen impacto social. Incentivando así la participación de actores altruistas que interactúen con el proyecto generando hashes motivados por el desarrollo del ecosistema y no por la posible recompensa económica. 

En nuestra opinión este balance entre la adversarialidad y el altruismo permite el desarrollo de un sistema sólido, resilente y perdurable en el tiempo, siendo nuestra inspiración la forma en que funcionan los incentivos altruistas y adversariales de las principales Blockchains como Bitcoin y Ethereum.


## Deployment

### CREDENCIALES NECESARIAS PARA EL DEPLOYMENT

	Alchemy API KEY
	Arbiscan API KEY
	Etherscan API KEY

### INSTALACION DE DEPENDENCIAS

	npm init -y 
	npm install --save-dev hardhat
	npx hardhat init
	npm install ethers@^6.1.0
	npm install --save-dev @nomicfoundation/hardhat-toolbox
	npx hardhat compile

### DEPLOYAR EL CONTRATO EN HARDHAT LOCAL

	Ingresa a la carpeta contract
	npx hardhat node
	npx hardhat run scripts/deploy.js --network localhost
	
	En MetaMask:		
		Nombre de la red: Localhost 8545
		URL de la red: http://127.0.0.1:8545
		ID de la cadena: 1337 
		Moneda: ETH

### DEPLOYAR EL CONTRATO EN SEPOLIA

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



## Appendix

Any additional information goes here


## Authors

- Diego Gil
- Danny Grinberg
- Hoover Zavala
- Juan Pablo Kaiser

