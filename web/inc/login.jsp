<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:import url="/inc/header.jsp" />
<c:import url="/inc/navbar.jsp" />

<section class="vh-100">
  <div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
          class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
        <form action="login" method="post">

          <!-- Hiển thị thông báo đổi mật khẩu thành công -->
          <c:if test="${not empty sessionScope.success_msg}">
            <div style="color: green; margin-bottom: 10px; font-weight: bold;">
                ${sessionScope.success_msg}
            </div>
            <c:remove var="success_msg" scope="session"/>
          </c:if>


          <h1 style="padding: 30px 0 10px 0;">Information Login</h1>

          <!-- Hiển thị lỗi đăng nhập -->
          <c:if test="${not empty error_login}">
            <div style="color: red; margin-bottom: 10px; font-weight: bold;">
              ${error_login}
            </div>
          </c:if>

          <div class="mb-4">
            <input type="text" name="emailphone" class="form-control form-control-lg"
              placeholder="Email address or phone number" required/>
          </div>
          <div class="mb-3">
            <input type="password" name="password" class="form-control form-control-lg"
              placeholder="Password" required/>
          </div>
          <div class="d-flex justify-content-between align-items-center">
            <div class="form-check mb-0">
              <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
              <label class="form-check-label" for="form2Example3">
                Remember me
              </label>
            </div>
            <a href="forgotPassword" class="text-body">Forgot password?</a>
          </div>
          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit" class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
            <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="register"
                class="link-danger">Register</a></p>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<c:import url="/inc/footer.jsp" />
