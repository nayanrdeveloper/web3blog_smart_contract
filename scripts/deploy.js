const hre = require("hardhat");


async function main() {

    
    const Blog = await hre.ethers.getContractFactory("Blog");
    const blog = await Blog.deploy();
    await blog.deployed();

    console.log(`Blog Deployed address are is ${blog.address}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });