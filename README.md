# GoodNumbers
Hackaton Académica Ethereum  

Generación de Entropía en Redes Blockchain mediante Juegos Adversariales
Introducción
Proponemos un juego diseñado para generar entropía en redes blockchain mediante interacciones adversariales. En este sistema, los participantes intentan modificar un número de "lotería" almacenado on-chain a través de una función de recálculo y un monto invertido en la operación. El objetivo es lograr que este número coincida con la dirección de su billetera y, como recompensa, reclamar los fondos acumulados en el contrato inteligente.

La dinámica del juego se torna más compleja a medida que aumenta el número de jugadores y el valor acumulado del premio en el contrato, incentivando estrategias avanzadas por parte de los participantes.

CREDENCIALES NECESARIAS

	Alchemy API KEY
	Arbiscan API KEY
	Etherscan API KEY

INSTALACION DE DEPENDENCIAS

	npm init -y 
	npm install --save-dev hardhat
	npx hardhat init
	npm install ethers@^6.1.0
	npm install --save-dev @nomicfoundation/hardhat-toolbox
	npx hardhat compile

DEPLOYAR EL CONTRATO EN HARDHAT LOCAL

	Ingresa a la carpeta contract
	npx hardhat node
	npx hardhat run scripts/deploy.js --network localhost
	
	En MetaMask:		
		Nombre de la red: Localhost 8545
		URL de la red: http://127.0.0.1:8545
		ID de la cadena: 1337 
		Moneda: ETH

DEPLOYAR EL CONTRATO EN SEPOLIA

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
		
		
DEPLOYAR EN ARBITRUM

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
				

