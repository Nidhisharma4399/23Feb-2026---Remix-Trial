// testAdmission.js
// Simple ethers test script – should work in Remix VM

(async () => {
  try {
    console.log("=== Starting CourseAdmission tests ===");
    
    // ethers should be available in Remix scripts
    if (typeof ethers === 'undefined') {
      throw new Error("ethers not loaded. Try: rename to .js, reload page, reset VM");
    }
    
    console.log("ethers version:", ethers.version);
    
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const account = await signer.getAddress();
    console.log("Using account:", account);

    // === CHANGE THIS TO YOUR LATEST DEPLOYED ADDRESS ===
    const contractAddress = "0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47";   // ← update this !

    const abi = [];

    const contract = new ethers.Contract(contractAddress, abi, signer);
    console.log("Connected to contract:", contractAddress);

    // Helper
    async function getBalance() {
      const wei = await provider.getBalance(contractAddress);
      return ethers.utils.formatEther(wei);
    }

    // Test 1
    console.log("\nTest 1: Initial balance");
    let balance = await getBalance();
    console.log("Balance:", balance, "ETH");

    // Test 2 – enrol 1 ETH
    console.log("\nTest 2: Enrol with exactly 1 ETH");
    const tx = await contract.enrol({ value: ethers.utils.parseEther("1.0") });
    console.log("TX sent:", tx.hash);
    await tx.wait();
    console.log("Enrol confirmed");

    const enrolled = await contract.amIEnrolled();
    console.log("amIEnrolled:", enrolled);

    balance = await getBalance();
    console.log("Balance after enrol:", balance, "ETH");

    // Test 3 – should fail
    console.log("\nTest 3: Try 0.5 ETH (should revert)");
    try {
      await contract.enrol({ value: ethers.utils.parseEther("0.5") });
      console.log("ERROR – it should have reverted");
    } catch (e) {
      console.log("Revert (good):", e.reason || e.message || "execution reverted");
    }

    console.log("\nAll tests finished ✓");

  } catch (err) {
    console.error("Script error:", err.message || err);
  }
})();