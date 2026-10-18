<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Order #SPH-${order.orderId}" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/orders" class="text-decoration-none">My Orders</a></li>
                    <li class="breadcrumb-item active" aria-current="page">#SPH-${order.orderId}</li>
                </ol>
            </nav>
            <h2 class="fw-bold mb-0">Order Details &amp; Invoice</h2>
        </div>
        <div class="d-flex gap-2 mt-2 mt-md-0">
            <button onclick="window.print()" class="btn btn-outline-secondary rounded-pill px-3 btn-sm">
                <i class="bi bi-printer me-1"></i> Print Invoice
            </button>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary rounded-pill px-3 btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Back to Orders
            </a>
        </div>
    </div>

    <div class="row g-4">
        <!-- Main Line Items -->
        <div class="col-lg-8">
            <!-- Tracking Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold mb-3">Fulfillment Status: <span class="text-primary">${order.orderStatus}</span></h5>
                <div class="p-3 bg-light rounded-3 mb-2">
                    <div class="row text-center">
                        <div class="col-3">
                            <i class="bi bi-check-circle-fill fs-4 text-success"></i>
                            <div class="small fw-bold text-dark mt-1">Confirmed</div>
                        </div>
                        <div class="col-3">
                            <i class="bi bi-box-seam-fill fs-4 ${order.orderStatus == 'SHIPPED' or order.orderStatus == 'DELIVERED' ? 'text-success' : 'text-muted'}"></i>
                            <div class="small fw-bold mt-1">Packed</div>
                        </div>
                        <div class="col-3">
                            <i class="bi bi-truck fs-4 ${order.orderStatus == 'SHIPPED' or order.orderStatus == 'DELIVERED' ? 'text-success' : 'text-muted'}"></i>
                            <div class="small fw-bold mt-1">Shipped</div>
                        </div>
                        <div class="col-3">
                            <i class="bi bi-house-door-fill fs-4 ${order.orderStatus == 'DELIVERED' ? 'text-success' : 'text-muted'}"></i>
                            <div class="small fw-bold mt-1">Delivered</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Items List -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <h5 class="fw-bold mb-3">Ordered Items</h5>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-light small text-uppercase text-muted">
                            <tr>
                                <th>Item</th>
                                <th>Price</th>
                                <th>Qty</th>
                                <th class="text-end">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.items}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <c:set var="detailItemImgSrc" value="${pageContext.request.contextPath}/assets/img/product-placeholder.svg"/>
                                            <c:if test="${not empty item.product.imageUrl}">
                                                <c:choose>
                                                    <c:when test="${item.product.imageUrl.startsWith('http')}">
                                                        <c:set var="detailItemImgSrc" value="${item.product.imageUrl}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="detailItemImgSrc" value="${pageContext.request.contextPath}${item.product.imageUrl}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <img src="${detailItemImgSrc}"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                                                 alt="${item.product.name}" class="rounded-3" style="width: 50px; height: 50px; object-fit: cover;">
                                            <div>
                                                <h6 class="mb-0 fw-bold">
                                                    <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}" class="text-decoration-none text-dark">
                                                        ${item.product.name}
                                                    </a>
                                                </h6>
                                                <span class="text-muted small">${item.product.brand}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>₹<fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td>${item.quantity}</td>
                                    <td class="text-end fw-bold">₹<fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Sidebar Info -->
        <div class="col-lg-4">
            <!-- Payment & Summary -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold mb-3">Payment Summary</h5>
                <div class="d-flex justify-content-between mb-2 small text-secondary">
                    <span>Subtotal</span>
                    <span class="fw-bold text-dark">₹<fmt:formatNumber value="${order.totalAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
                <c:if test="${order.discount > 0}">
                    <div class="d-flex justify-content-between mb-2 small text-success">
                        <span>Discount</span>
                        <span class="fw-bold">-₹<fmt:formatNumber value="${order.discount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                    </div>
                </c:if>
                <div class="d-flex justify-content-between mb-3 small text-secondary">
                    <span>Shipping Fee</span>
                    <span class="fw-bold">
                        <c:choose>
                            <c:when test="${order.shippingFee == 0}">
                                <span class="badge bg-success bg-opacity-25 text-success">FREE</span>
                            </c:when>
                            <c:otherwise>
                                ₹<fmt:formatNumber value="${order.shippingFee}" minFractionDigits="2" maxFractionDigits="2"/>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <hr>
                <div class="d-flex justify-content-between align-items-baseline mb-3">
                    <span class="fw-bold">Total Paid</span>
                    <span class="fs-4 fw-bold text-primary">₹<fmt:formatNumber value="${order.finalAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>

                <div class="p-3 bg-light rounded-3 small">
                    <div class="d-flex justify-content-between mb-1">
                        <span class="text-muted">Payment Method:</span>
                        <span class="badge bg-secondary text-uppercase">${order.paymentMethod}</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted">Payment Status:</span>
                        <span class="badge bg-success">${order.paymentStatus}</span>
                    </div>
                </div>
            </div>

            <!-- Shipping Address -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <h5 class="fw-bold mb-3">Delivery Address</h5>
                <c:choose>
                    <c:when test="${not empty order.address}">
                        <div class="text-dark fw-semibold mb-1">${order.address.addressLine}</div>
                        <div class="text-muted small">${order.address.city}, ${order.address.state} - ${order.address.pincode}</div>
                        <span class="badge bg-light text-dark border mt-2">${order.address.addressType}</span>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted small mb-0">Standard shipping location</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/fragments/footer.jsp"/>
