/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.ImportDao;
import data.impl.ImportImpl;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ImportHistory;

/**
 *
 * @author HIEU PC
 */
@WebServlet(name = "ImportHistoryServlet", urlPatterns = {"/import-history"})
public class ImportHistoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Khởi tạo DAO qua Interface/Impl
        ImportDao dao = new ImportImpl(); 
        
        // 2. Lấy danh sách lịch sử nhập kho chi tiết
        List<ImportHistory> list = dao.getAllImportHistory();
        
        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("historyList", list);
        
        // 4. Chuyển hướng (Đảm bảo đường dẫn file .jsp là chính xác)
        request.getRequestDispatcher("inc/import-history.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}