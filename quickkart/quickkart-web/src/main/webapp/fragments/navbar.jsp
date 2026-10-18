<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-glass sticky-top py-3">
    <div class="container">
        <!-- Brand Logo -->
        <a class="navbar-brand d-flex align-items-center py-0" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/assets/img/quickkart-logo.png" alt="QuickKart" style="height: 42px; width: auto; object-fit: contain;">
        </a>

        <!-- Mobile Toggler -->
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <!-- Search Bar -->
            <form class="d-flex mx-auto my-2 my-lg-0 col-12 col-lg-5" action="${pageContext.request.contextPath}/products" method="get">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 rounded-start-pill ps-3 text-muted">
                        <i class="bi bi-search"></i>
                    </span>
                    <input class="form-control border-start-0 border-end-0 shadow-none" type="search" name="q" value="${searchQuery}" placeholder="Search products, brands, tech..." aria-label="Search">
                    <button class="btn btn-primary rounded-end-pill px-4" type="submit">Search</button>
                </div>
            </form>

            <!-- Navigation Links -->
            <ul class="navbar-nav ms-auto align-items-lg-center gap-1">
                <li class="nav-item">
                    <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/products">
                        <i class="bi bi-grid me-1"></i> Catalog
                    </a>
                </li>

                <!-- Flash Deals Link -->
                <li class="nav-item">
                    <a class="nav-link fw-semibold px-3 text-danger d-flex align-items-center" href="${pageContext.request.contextPath}/products?sort=discount">
                        <i class="bi bi-fire me-1"></i> Deals
                        <span class="badge bg-danger bg-opacity-10 text-danger rounded-pill ms-1 px-2 py-1 small">Hot</span>
                    </a>
                </li>

                <!-- Wishlist Link -->
                <li class="nav-item">
                    <a class="nav-link px-3" href="${pageContext.request.contextPath}/wishlist" title="My Wishlist">
                        <i class="bi bi-heart fs-5"></i>
                    </a>
                </li>

                <!-- Cart Link with Badge -->
                <li class="nav-item">
                    <a class="nav-link px-3 position-relative" href="${pageContext.request.contextPath}/cart" title="Shopping Cart">
                        <i class="bi bi-bag fs-5"></i>
                        <c:if test="${not empty sessionScope.cartCount && sessionScope.cartCount > 0}">
                            <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badge-cart">
                                ${sessionScope.cartCount}
                            </span>
                        </c:if>
                    </a>
                </li>

                <!-- Auth / User Profile Menu -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown ms-lg-2">
                            <a class="nav-link dropdown-toggle btn btn-light rounded-pill px-3 py-2 border d-flex align-items-center gap-2" href="#" id="userMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle fs-5 text-primary"></i>
                                <span class="fw-semibold small">${sessionScope.user.name}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-4 p-2" aria-labelledby="userMenu">
                                <c:if test="${sessionScope.user.admin}">
                                    <li><a class="dropdown-item py-2 rounded-3 text-primary fw-bold" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i>Admin Dashboard</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item py-2 rounded-3" href="${pageContext.request.contextPath}/orders"><i class="bi bi-box-seam me-2 text-muted"></i>My Orders</a></li>
                                <li><a class="dropdown-item py-2 rounded-3" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person me-2 text-muted"></i>Account Profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item py-2 rounded-3 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-lg-2">
                            <a class="btn btn-outline-primary rounded-pill px-3 py-2 fw-semibold me-2" href="${pageContext.request.contextPath}/login">Sign In</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-primary rounded-pill px-3 py-2 fw-semibold" href="${pageContext.request.contextPath}/register">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<jsp:include page="/fragments/messages.jsp"/>
