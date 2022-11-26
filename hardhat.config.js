/** @type import('hardhat/config').HardhatUserConfig */
require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-ethers");
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {},
    mumbai : {
      url : process.env.NEXT_PUBLIC_RPCURL,
      accounts: [process.env.NEXT_PUBLIC_PRIAVATE_KEY],
    }
  },

};
