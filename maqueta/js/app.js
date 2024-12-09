// Verificar si MetaMask está instalado
if (typeof window.ethereum !== 'undefined') {
    const web3 = new Web3(window.ethereum);
    let userAccount = null;
  
    // Conectar la billetera
    document.getElementById('connect-wallet').addEventListener('click', async () => {
      try {
        const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
        userAccount = accounts[0];
        document.getElementById('connect-wallet').innerText = 'Billetera Conectada';
        fetchCurrentHash();
      } catch (error) {
        console.error("Error al conectar la billetera", error);
      }
    });
  
    // Función para obtener el hash actual del contrato inteligente
    async function fetchCurrentHash() {
      // Aquí deberías llamar a tu contrato inteligente para obtener el hash actual
      // Usando Web3.js, por ejemplo:
      const currentHash = "0xabc123..."; // Obtén el hash del contrato
      document.getElementById('current-hash').innerText = currentHash;
      calculateMyHash();
    }
  
    // Calcular el hash basado en la billetera del usuario
    function calculateMyHash() {
      if (userAccount) {
        // Aquí se calcularía el hash usando la dirección de la billetera
        const myHash = web3.utils.sha3(userAccount); // Simple ejemplo
        document.getElementById('my-hash').innerText = myHash;
      }
    }
  
    // Calcular la recompensa estimada al enviar un monto
    document.getElementById('amount').addEventListener('input', (e) => {
      const amount = e.target.value;
      const reward = calculateReward(amount);
      document.getElementById('estimated-reward').innerText = reward;
    });
  
    function calculateReward(amount) {
      // Aquí puedes usar una lógica más compleja o consultar el contrato para calcular la recompensa
      return (amount * 0.05).toFixed(4); // Ejemplo de recompensa estimada del 5% del monto
    }
  
    // Función para enviar la transacción
    document.getElementById('send-button').addEventListener('click', async () => {
      const amount = document.getElementById('amount').value;
      if (amount && userAccount) {
        sendTransaction(amount);
      } else {
        alert("Por favor, ingresa un monto y conecta tu billetera.");
      }
    });
  
    // Enviar la transacción a Ethereum
    async function sendTransaction(amount) {
      try {
        // Crear y enviar la transacción al contrato inteligente
        const transactionParameters = {
          to: '0xYourSmartContractAddress', // Dirección del contrato
          from: userAccount,
          value: web3.utils.toWei(amount, 'ether'), // Convierte el monto a Wei
        };
  
        const txHash = await ethereum.request({
          method: 'eth_sendTransaction',
          params: [transactionParameters],
        });
  
        alert(`Transacción enviada. Hash: ${txHash}`);
      } catch (error) {
        console.error("Error al enviar la transacción", error);
      }
    }
  
  } else {
    alert("Por favor, instala MetaMask para continuar.");
  }
  