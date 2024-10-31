// src/socket.js
import { Socket } from "phoenix";

// Create a new socket instance and connect to the Phoenix server
const socket = new Socket("ws://localhost:4000/socket");

// Connect the socket
socket.connect();

// Export a function to join a specific channel
export function joinLobbyRoom() {
  // Join the "user:lobby" channel
  const channel = socket.channel("room:lobby", {});

  // Handle successful join
  channel
    .join()
    .receive("ok", (resp) => {
      console.log("Joined successfully", resp);
    })
    .receive("error", (resp) => {
      console.error("Unable to join", resp);
    });

  // Listen for events
  channel.on("new_msg", (payload) => {
    console.log("New message:", payload);
  });

  return channel; // Return the channel instance
}
