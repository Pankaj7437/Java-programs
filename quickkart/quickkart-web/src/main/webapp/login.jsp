<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Sign In" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5">
            <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5 bg-white">
                <div class="text-center mb-4">
                    <div class="d-inline-flex p-3 rounded-circle bg-primary bg-opacity-10 text-primary mb-2">
                        <i class="bi bi-person-fill-lock fs-1"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Welcome Back</h3>
                    <p class="text-muted small">Sign in to your QuickKart account</p>
                </div>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 rounded-start-3"><i class="bi bi-envelope"></i></span>
                            <input type="email" name="email" value="${email}" class="form-control rounded-end-3 shadow-none border-start-0" placeholder="name@example.com" required autofocus>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold mb-0">Password</label>
                            <a href="#" class="small text-decoration-none text-muted">Forgot password?</a>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 rounded-start-3"><i class="bi bi-key"></i></span>
                            <input type="password" name="password" class="form-control rounded-end-3 shadow-none border-start-0" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg rounded-pill w-100 fw-bold shadow py-2 mb-3">
                        Sign In
                    </button>
                </form>

                <div class="text-center small text-muted">
                    Don't have an account yet?
                    <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-bold text-primary">Create one</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/fragments/footer.jsp"/>
