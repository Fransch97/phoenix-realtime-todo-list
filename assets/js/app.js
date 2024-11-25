// Include phoenix_html to handle method=PUT/DELETE in forms and buttons
import "phoenix_html";

// Import Phoenix Socket and LiveView
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";

// Import topbar for navigation progress bar
import topbar from "../vendor/topbar";

// CSRF token for secure requests
let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

// LiveView setup
let Hooks = {};

Hooks.TodoList = {
  mounted() {
    this.el.addEventListener("mousemove", (e) => {
      this.pushEvent("track_mouse", { x: e.clientX, y: e.clientY });
    });
  },
};

let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// Connect LiveView if there are any LiveViews on the page
liveSocket.connect();

// Expose liveSocket on window for web console debugging
window.liveSocket = liveSocket;

// Phoenix Channel setup
let socket = new Socket("/socket", { params: { _csrf_token: csrfToken } });
socket.connect();

let channel = socket.channel("mouse:track", {});

// Handle updates from other clients
channel.on("mouse_update", ({ x, y, userId }) => {
  let cursor = document.getElementById(`remote-cursor-${userId}`);
  if (!cursor) {
    cursor = document.createElement("div");
    cursor.id = `remote-cursor-${userId}`;
    cursor.style.position = "absolute";
    cursor.style.width = "10px";
    cursor.style.height = "10px";
    cursor.style.backgroundColor = "red";
    cursor.style.borderRadius = "50%";
    cursor.style.zIndex = "1000";
    document.body.appendChild(cursor);
  }
  cursor.style.left = `${x}px`;
  cursor.style.top = `${y}px`;
});

// Join the channel
channel
  .join()
  .receive("ok", () => console.log("Joined mouse tracking channel"))
  .receive("error", (resp) => console.log("Unable to join", resp));

// Send mouse movements to the server
window.addEventListener("mousemove", (event) => {
  channel.push("mouse_move", { x: event.clientX, y: event.clientY, userId: "unique-id" });
});
