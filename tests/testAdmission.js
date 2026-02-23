// test-enrol-debug.js

(async () => {
  try {
    const contractAddress = "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8";

    console.log("Testing contract at:", contractAddress);

    const enrolData = "0x3ccfd60b"; // enrol()

    const accounts = await remix.call('udapp', 'getAccounts');
    const from = accounts[0];
    console.log("From:", from);

    console.log("\nTrying 1 ETH enrol...");
    const tx1 = await remix.call('udapp', 'sendTransaction', {
      from,
      to: contractAddress,
      value: "1000000000000000000",
      data: enrolData,
      gasLimit: "500000",
      useCall: false
    });
    console.log("TX result:", tx1);

    console.log("\nTrying 0.5 ETH enrol...");
    try {
      const tx2 = await remix.call('udapp', 'sendTransaction', {
        from,
        to: contractAddress,
        value: "500000000000000000",
        data: enrolData,
        gasLimit: "500000",
        useCall: false
      });
      console.log("Unexpected success:", tx2);
    } catch (e) {
      console.log("Revert caught:", e.message || e);
    }

  } catch (err) {
    console.error("Script failed:", err.message || err);
  }
})();