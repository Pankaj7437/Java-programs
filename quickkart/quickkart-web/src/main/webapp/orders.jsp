<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Orders" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="mb-4 pb-2 border-bottom">
        <h2 class="fw-bold mb-1">My Orders</h2>
        <p class="text-muted small mb-0">Track shipments, view invoices, and review past purchases</p>
    </div>

    <c:choose>
        <c:when test="${not empty orders}">
            <div class="d-flex flex-column gap-4">
                <c:forEach var="ord" items="${orders}">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                        <div class="card-header bg-light py-3 px-4 border-0">
                            <div class="row align-items-center g-2">
                                <div class="col-6 col-md-3">
                                    <span class="text-muted small d-block">Order Placed</span>
                                    <span class="fw-semibold text-dark small"><fmt:formatDate value="${ord.createdAt}" pattern="dd MMM yyyy"/></span>
                                </div>
                                <div class="col-6 col-md-3">
                                    <span class="text-muted small d-block">Total Amount</span>
                                    <span class="fw-bold text-primary">₹<fmt:formatNumber value="${ord.finalAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                                </div>
                                <div class="col-6 col-md-3">
                                    <span class="text-muted small d-block">Order Status</span>
                                    <c:choose>
                                        <c:when test="${ord.orderStatus == 'DELIVERED'}">
                                            <span class="badge bg-success bg-opacity-25 text-success rounded-pill px-3 py-1">Delivered</span>
                                        </c:when>
                                        <c:when test="${ord.orderStatus == 'CANCELLED'}">
                                            <span class="badge bg-danger bg-opacity-25 text-danger rounded-pill px-3 py-1">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary bg-opacity-25 text-primary rounded-pill px-3 py-1">${ord.orderStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-6 col-md-3 text-end">
                                    <a href="${pageContext.request.contextPath}/order-details?id=${ord.orderId}" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                        View Details <i class="bi bi-chevron-right ms-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="card-body p-4">
                            <div class="d-flex flex-column gap-3">
                                <c:forEach var="item" items="${ord.items}">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="d-flex align-items-center gap-3">
                                            <c:set var="ordItemImgSrc" value="${pageContext.request.contextPath}/assets/img/product-placeholder.svg"/>
                                            <c:if test="${not empty item.product.imageUrl}">
                                                <c:choose>
                                                    <c:when test="${item.product.imageUrl.startsWith('http')}">
                                                        <c:set var="ordItemImgSrc" value="${item.product.imageUrl}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="ordItemImgSrc" value="${pageContext.request.contextPath}${item.product.imageUrl}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <img src="${ordItemImgSrc}"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                                                 alt="${item.product.name}" class="rounded-3" style="width: 50px; height: 50px; object-fit: cover;">
                                            <div>
                                                <h6 class="mb-0 fw-bold">
                                                    <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}" class="text-decoration-none text-dark">
                                                        ${item.product.name}
                                                    </a>
                                                </h6>
                                                <span class="text-muted small">Qty: ${item.quantity} × ₹<fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2"/></span>
                                            </div>
                                        </div>
                                        <span class="fw-bold text-dark">₹<fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 border shadow-sm my-4">
                <i class="bi bi-box2 fs-1 text-muted mb-3 d-block"></i>
                <h4 class="fw-bold">No Orders Placed Yet</h4>
                <p class="text-muted mb-4">You have not completed any purchases. Discover something you love today!</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-4">Start Shopping</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/fragments/footer.jsp"/>
