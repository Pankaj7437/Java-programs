<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Admin Dashboard" scope="request"/>
<c:set var="activeTab" value="dashboard" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/admin-navbar.jsp"/>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
    <div>
        <h1 class="h2 fw-bold text-dark">Executive Dashboard</h1>
        <p class="text-muted small mb-0">Real-time inventory metrics, order velocity, and system health</p>
    </div>
    <div class="btn-toolbar mb-2 mb-md-0 gap-2">
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-sm btn-primary rounded-pill px-3">
            <i class="bi bi-plus-circle me-1"></i> Add Product
        </a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline-dark rounded-pill px-3">
            <i class="bi bi-receipt me-1"></i> Manage Orders
        </a>
    </div>
</div>

<!-- KPI Cards -->
<div class="row g-3 mb-4">
    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card p-3 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted small text-uppercase fw-semibold">Total Revenue</span>
                    <h3 class="fw-bold text-primary mb-0 mt-1">₹<fmt:formatNumber value="${totalRevenue}" minFractionDigits="2" maxFractionDigits="2"/></h3>
                </div>
                <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-4">
                    <i class="bi bi-currency-rupee fs-3"></i>
                </div>
            </div>
            <span class="text-success small mt-2 d-block"><i class="bi bi-graph-up-arrow me-1"></i> Settled via Payment Gateway</span>
        </div>
    </div>

    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card p-3 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted small text-uppercase fw-semibold">Total Orders</span>
                    <h3 class="fw-bold text-dark mb-0 mt-1">${totalOrders}</h3>
                </div>
                <div class="p-3 bg-success bg-opacity-10 text-success rounded-4">
                    <i class="bi bi-bag-check-fill fs-3"></i>
                </div>
            </div>
            <span class="text-muted small mt-2 d-block">Lifetime completed orders</span>
        </div>
    </div>

    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card p-3 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted small text-uppercase fw-semibold">Customers</span>
                    <h3 class="fw-bold text-dark mb-0 mt-1">${totalCustomers}</h3>
                </div>
                <div class="p-3 bg-info bg-opacity-10 text-info rounded-4">
                    <i class="bi bi-people-fill fs-3"></i>
                </div>
            </div>
            <span class="text-muted small mt-2 d-block">Active registered accounts</span>
        </div>
    </div>

    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card p-3 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted small text-uppercase fw-semibold">Catalog SKUs</span>
                    <h3 class="fw-bold text-dark mb-0 mt-1">${totalProducts}</h3>
                </div>
                <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-4">
                    <i class="bi bi-box-seam-fill fs-3"></i>
                </div>
            </div>
            <span class="text-muted small mt-2 d-block">Published products</span>
        </div>
    </div>
</div>

<div class="row g-4">
    <!-- Low Stock Alerts -->
    <div class="col-lg-5">
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0 text-danger"><i class="bi bi-exclamation-triangle-fill me-2"></i>Low Stock Inventory</h5>
                <span class="badge bg-danger rounded-pill">${lowStockProducts.size()} items</span>
            </div>

            <c:choose>
                <c:when test="${not empty lowStockProducts}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 small">
                            <thead class="table-light">
                                <tr>
                                    <th>Product</th>
                                    <th>Category</th>
                                    <th class="text-end">Stock</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${lowStockProducts}">
                                    <tr>
                                        <td class="fw-semibold text-truncate" style="max-width: 140px;">${p.name}</td>
                                        <td class="text-muted">${p.categoryName}</td>
                                        <td class="text-end">
                                            <span class="badge bg-danger">${p.stock} units</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4 text-muted">
                        <i class="bi bi-check2-circle fs-2 text-success d-block mb-2"></i>
                        <p class="mb-0">All product stock levels are healthy.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Recent Orders -->
    <div class="col-lg-7">
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0">Recent Orders</h5>
                <a href="${pageContext.request.contextPath}/admin/orders" class="small text-primary text-decoration-none fw-semibold">View All</a>
            </div>

            <c:choose>
                <c:when test="${not empty recentOrders}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 small">
                            <thead class="table-light">
                                <tr>
                                    <th>Order #</th>
                                    <th>Customer</th>
                                    <th>Amount</th>
                                    <th>Payment</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ord" items="${recentOrders}">
                                    <tr>
                                        <td class="font-monospace fw-bold">#SPH-${ord.orderId}</td>
                                        <td>${ord.userName}</td>
                                        <td class="fw-bold">₹<fmt:formatNumber value="${ord.finalAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                        <td><span class="badge bg-light text-dark border">${ord.paymentStatus}</span></td>
                                        <td>
                                            <span class="badge ${ord.orderStatus == 'DELIVERED' ? 'bg-success' : 'bg-primary'}">${ord.orderStatus}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-muted small">No orders recorded yet.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/fragments/admin-footer.jsp"/>
