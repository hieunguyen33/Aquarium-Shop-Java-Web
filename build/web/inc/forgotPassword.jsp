<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-container input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-container button:hover {
            background: #0056b3;
        }
        .message {
            text-align: center;
            margin-top: 10px;
            color: red;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Quên mật khẩu</h2>
    <form action="forgotPassword" method="post">
        <input type="text" name="email" placeholder="Nhập email" required>
        <input type="text" name="phone" placeholder="Nhập số điện thoại" required>
        <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
        <button type="submit">Đổi mật khẩu</button>
    </form>

    <div class="message">
        <c:if test="${not empty error}">
            ${error}
        </c:if>
        <c:if test="${not empty success}">
            <span class="success">${success}</span>
        </c:if>
    </div>
</div>
</body>
</html>
