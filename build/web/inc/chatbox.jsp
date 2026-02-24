<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="chat-box" style="position: fixed; bottom: 20px; right: 20px; z-index: 999;">
    <button id="chat-toggle" style="background: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 5px;">
        💬 Hỗ trợ
    </button>

    <div id="chat-window" style="display: none; width: 300px; height: 400px; background: white; border: 1px solid #ccc; border-radius: 10px; overflow: hidden; box-shadow: 0 0 10px rgba(0,0,0,0.2);">
        <div style="background: #007bff; color: white; padding: 10px; font-weight: bold;">
            Chat hỗ trợ
        </div>

        <div id="chat-messages" style="padding: 10px; height: 300px; overflow-y: auto; font-size: 14px;">
            <div><b>Hỗ trợ:</b> Xin chào! Bạn cần giúp gì?</div>
            <div>- 1. Thông tin sản phẩm</div>
            <div>- 2. Hướng dẫn mua hàng</div>
            <div>- 3. Liên hệ nhân viên</div>
        </div>

        <div style="display: flex; border-top: 1px solid #ccc;">
            <input id="chat-input" type="text" placeholder="Nhập câu trả lời..." style="flex: 1; border: none; padding: 8px;">
            <button id="chat-send" style="background: #007bff; color: white; border: none; padding: 8px 12px;">Gửi</button>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/inc/chatbox.js"></script>
