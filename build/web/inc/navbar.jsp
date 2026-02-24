<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="data.utils.API" %>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="assets/icon/logo.png" width="70" height="70"/>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin: 0 auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="home">Home</a>
                </li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Category
                    </a>
                    <ul class="dropdown-menu">
                        <c:forEach var="c" items="${listCategory}">
                            <li><a class="dropdown-item" href="./home?id_category=${c.id}">
                                <c:out value="${c.getName()}"/>
                            </a></li>
                        </c:forEach>
                    </ul>
                </li>
                
                <c:if test="${user == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="login">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart">
                            <img src="assets/icon/cart.png" width="30" height="30"/>
                            <c:if test="${sessionScope.cart != null && sessionScope.cart.totalItems > 0}">
                                <span>${sessionScope.cart.totalItems}</span>
                            </c:if>
                            <c:if test="${sessionScope.cart == null || sessionScope.cart.totalItems == 0}">
                                <span>0</span>
                            </c:if>
                        </a>
                    </li>
                </c:if>

                <c:if test="${user != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Hi, <c:set var="s" value="${user.getName()}"></c:set>
                            <%
                                String name=(String)pageContext.getAttribute("s");
                                out.print(API.getName(name)); 
                            %>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="profile">Profile</a></li>
                            <li><a class="dropdown-item" href="logout">Logout</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart">
                            <img src="assets/icon/cart.png" width="30" height="30"/>
                            <c:if test="${sessionScope.cart != null && sessionScope.cart.totalItems > 0}">
                                <span>${sessionScope.cart.totalItems}</span>
                            </c:if>
                             <c:if test="${sessionScope.cart == null || sessionScope.cart.totalItems == 0}">
                                <span>0</span>
                            </c:if>
                        </a>
                    </li>
                </c:if>
            </ul>
            <form action="search" method="get" class="d-flex me-3">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="keyword">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>