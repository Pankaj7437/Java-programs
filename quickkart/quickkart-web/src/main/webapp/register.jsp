<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Create Account" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5 bg-white">
                <div class="text-center mb-4">
                    <div class="d-inline-flex p-3 rounded-circle bg-primary bg-opacity-10 text-primary mb-2">
                        <i class="bi bi-person-plus-fill fs-1"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Create Account</h3>
                    <p class="text-muted small">Join QuickKart to start ordering with exclusive member discounts</p>
                </div>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Full Name</label>
                        <input type="text" name="name" value="${name}" class="form-control rounded-3" placeholder="e.g. Alex Hunter" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Email Address</label>
                        <input type="email" name="email" value="${email}" class="form-control rounded-3" placeholder="name@domain.com" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Mobile Number</label>
                        <input type="tel" name="mobile" value="${mobile}" class="form-control rounded-3" placeholder="9876543210">
                    </div>

                    <div class="row g-2 mb-4">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Password</label>
                            <input type="password" name="password" class="form-control rounded-3" placeholder="••••••••" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Confirm Password</label>
                            <input type="password" name="confirmPassword" class="form-control rounded-3" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg rounded-pill w-100 fw-bold shadow py-2 mb-3">
                        Complete Registration
                    </button>
                </form>

                <div class="text-center small text-muted">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold text-primary">Sign in here</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/fragments/footer.jsp"/>
