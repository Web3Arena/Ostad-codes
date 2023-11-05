import "./App.css";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { ethers } from "ethers";
import { useState } from "react";
import { fetchBalance, getAccount } from "wagmi/actions";
import { getNetwork, watchNetwork } from "@wagmi/core";
import { useAccount } from "wagmi";

function App() {
  const [balance, setBalance] = useState(0);
  const [network, setNetwork] = useState("");
  const account = getAccount();
  const { chain } = getNetwork();
  watchNetwork((network) => {
    setNetwork(network?.chain?.name || "");
    setBalance(0);
  });
  const { isConnected } = useAccount();

  const getBalance = async () => {
    const userBalance = await fetchBalance({
      address: account?.address || "0x0",
    });
    const output = ethers.formatEther(userBalance.value);
    setBalance(Number(output));
  };
  return (
    <>
      <ConnectButton />
      {isConnected && (
        <div>
          <p>Account: {account?.address}</p>
          <button style={{ marginTop: "50px" }} onClick={getBalance}>
            Fetch Balance Manually
          </button>
          {balance && (
            <p>
              Balance: {balance} {network && chain?.nativeCurrency?.symbol}
            </p>
          )}
        </div>
      )}
    </>
  );
}

export default App;
