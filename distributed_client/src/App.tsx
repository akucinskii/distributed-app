// src/App.js
import { useEffect, useState } from "react";
import { joinLobbyRoom } from "./socket";
import { Channel } from "phoenix";

function App() {
  const [channel, setChannel] = useState<Channel | null>(null);
  useEffect(() => {
    // Join the lobby room when the component mounts
    const new_channel = joinLobbyRoom();

    setChannel(new_channel);

    // Optionally, send a message to the channel
    new_channel.push("new_msg", { body: "Hello from React!" });

    new_channel.on("new_msg", (payload) => {
      // Update the messages state
      setMessages((messages) => [...messages, payload.body]);
    });
    // Cleanup on component unmount
    return () => {
      channel?.leave();
    };
  }, []);

  const sendMessage = (input: string) => {
    // Send a message to the channel
    channel?.push("new_msg", { body: input });
  };
  const [newMessage, setNewMessage] = useState("");
  const [messages, setMessages] = useState<string[]>([]);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Phoenix Chat</h1>
        <input
          type="text"
          onChange={(e) => setNewMessage(e.target.value)}
          value={newMessage}
        />
        <button
          onClick={() => {
            sendMessage(newMessage);
            setNewMessage("");
          }}
        >
          Send Message
        </button>
        {messages.map((message, index) => (
          <p key={index}>{message}</p>
        ))}
      </header>
    </div>
  );
}

export default App;
