async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Establece un valor inicial para matchLength (por ejemplo, 2 nibbles)
  const initialMatchLength = 2;

  const AdversarialEntropyGame = await ethers.getContractFactory("AdversarialEntropyGame");
  const adversarialEntropyGame = await AdversarialEntropyGame.deploy(initialMatchLength);

  // Esperar a que se despliegue el contrato antes de continuar
  await adversarialEntropyGame.waitForDeployment();

  console.log("AdversarialEntropyGame contract deployed to:", adversarialEntropyGame.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

