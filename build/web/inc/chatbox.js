document.addEventListener("DOMContentLoaded", function () {
    const toggleBtn = document.getElementById("chat-toggle");
    const chatWindow = document.getElementById("chat-window");
    const sendBtn = document.getElementById("chat-send");
    const input = document.getElementById("chat-input");
    const messages = document.getElementById("chat-messages");

    toggleBtn.addEventListener("click", () => {
        chatWindow.style.display = chatWindow.style.display === "none" ? "block" : "none";
    });

    function appendMessage(sender, text) {
        messages.innerHTML += `<div><b>${sender}:</b> ${text}</div>`;
        messages.scrollTop = messages.scrollHeight;
    }

    sendBtn.addEventListener("click", () => {
        const userMsg = input.value.trim();
        if (userMsg === "") return;

        appendMessage("Bạn", userMsg);
        input.value = "";

        fetch("chat", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "message=" + encodeURIComponent(userMsg)
        })
        .then(res => res.text())
        .then(reply => {
            appendMessage("Hỗ trợ", reply);
        })
        .catch(err => console.error("Lỗi:", err));
    });

    input.addEventListener("keypress", function (e) {
        if (e.key === "Enter") sendBtn.click();
    });
});
