<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Shopping Cart" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h2 class="fw-bold mb-1">Shopping Cart</h2>
            <p class="text-muted small mb-0">${cartItems.size()} distinct items in your cart</p>
        </div>
        <c:if test="${not empty cartItems}">
            <form action="${pageContext.request.contextPath}/cart" method="post" onsubmit="return confirm('Clear entire cart?');">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill px-3">
                    <i class="bi bi-trash3 me-1"></i> Clear Cart
                </button>
            </form>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${not empty cartItems}">
            <div class="row g-4">
                <!-- Cart Items Table -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                    <tr class="small text-uppercase text-muted">
                                        <th class="ps-4 py-3">Product</th>
                                        <th class="py-3">Price</th>
                                        <th class="py-3 text-center">Quantity</th>
                                        <th class="py-3">Subtotal</th>
                                        <th class="py-3 pe-4 text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr>
                                            <td class="ps-4 py-3">
                                                <div class="d-flex align-items-center gap-3">
                                                    <c:set var="cartItemImgSrc" value="${pageContext.request.contextPath}/assets/img/product-placeholder.svg"/>
                                                    <c:if test="${not empty item.product.imageUrl}">
                                                        <c:choose>
                                                            <c:when test="${item.product.imageUrl.startsWith('http')}">
                                                                <c:set var="cartItemImgSrc" value="${item.product.imageUrl}"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="cartItemImgSrc" value="${pageContext.request.contextPath}${item.product.imageUrl}"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                    <img src="${cartItemImgSrc}"
                                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                                                         alt="${item.product.name}" class="rounded-3 shadow-sm" style="width: 64px; height: 64px; object-fit: cover;">
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
                                            <td class="py-3 fw-semibold">
                                                ₹<fmt:formatNumber value="${item.product.discountedPrice}" minFractionDigits="2" maxFractionDigits="2"/>
                                            </td>
                                            <td class="py-3 text-center">
                                                <div class="d-inline-flex align-items-center border rounded-pill p-1 bg-light">
                                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="productId" value="${item.productId}">
                                                        <input type="hidden" name="quantity" value="${item.quantity - 1}">
                                                        <button type="submit" class="btn btn-sm btn-link text-dark p-0 px-2 text-decoration-none" title="Decrease">
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                    </form>
                                                    <span class="px-2 fw-bold small">${item.quantity}</span>
                                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="productId" value="${item.productId}">
                                                        <input type="hidden" name="quantity" value="${item.quantity + 1}">
                                                        <button type="submit" class="btn btn-sm btn-link text-dark p-0 px-2 text-decoration-none" title="Increase">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                            <td class="py-3 fw-bold text-primary">
                                                ₹<fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/>
                                            </td>
                                            <td class="pe-4 py-3 text-end">
                                                <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="productId" value="${item.productId}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-circle p-2" title="Remove Item">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary rounded-pill px-4">
                        <i class="bi bi-arrow-left me-2"></i> Continue Shopping
                    </a>
                </div>

                <!-- Order Summary & Coupon Box -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                        <h5 class="fw-bold mb-3">Order Summary</h5>

                        <div class="d-flex justify-content-between mb-2 small text-secondary">
                            <span>Bag Subtotal</span>
                            <span class="fw-bold text-dark">₹<fmt:formatNumber value="${pricing.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>

                        <c:if test="${pricing.discount > 0}">
                            <div class="d-flex justify-content-between mb-2 small text-success">
                                <span>Coupon (${sessionScope.appliedCouponCode})</span>
                                <span class="fw-bold">-₹<fmt:formatNumber value="${pricing.discount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-between mb-3 small text-secondary">
                            <span>Estimated Shipping</span>
                            <span>
                                <c:choose>
                                    <c:when test="${pricing.shippingFee == 0}">
                                        <span class="badge bg-success bg-opacity-25 text-success">FREE</span>
                                    </c:when>
                                    <c:otherwise>
                                        ₹<fmt:formatNumber value="${pricing.shippingFee}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <hr class="my-3">

                        <div class="d-flex justify-content-between mb-4 align-items-baseline">
                            <span class="fw-bold fs-5">Total Payable</span>
                            <span class="display-6 fw-bold text-primary">₹<fmt:formatNumber value="${pricing.finalAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>

                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg rounded-pill w-100 fw-bold shadow py-3">
                            Proceed to Checkout <i class="bi bi-arrow-right ms-2"></i>
                        </a>
                    </div>

                    <!-- Coupon Code Input Box -->
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                        <h6 class="fw-bold mb-2"><i class="bi bi-tag-fill text-primary me-2"></i>Have a Promo Code?</h6>
                        <p class="small text-muted mb-3">Try <code>WELCOME10</code> or <code>FLAT20</code></p>

                        <c:choose>
                            <c:when test="${not empty sessionScope.appliedCouponCode}">
                                <div class="d-flex justify-content-between align-items-center p-2 px-3 bg-success bg-opacity-10 text-success rounded-3 mb-2">
                                    <span class="fw-bold"><i class="bi bi-check-circle-fill me-1"></i> ${sessionScope.appliedCouponCode} applied</span>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="m-0">
                                        <input type="hidden" name="action" value="removeCoupon">
                                        <button type="submit" class="btn btn-link btn-sm text-danger p-0 text-decoration-none fw-bold">Remove</button>
                                    </form>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="applyCoupon">
                                    <div class="input-group">
                                        <input type="text" name="couponCode" class="form-control rounded-start-pill text-uppercase shadow-none" placeholder="Coupon Code" required>
                                        <button class="btn btn-dark rounded-end-pill px-3" type="submit">Apply</button>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 border shadow-sm my-4">
                <i class="bi bi-cart-x fs-1 text-muted mb-3 d-block"></i>
                <h3 class="fw-bold">Your Cart is Empty</h3>
                <p class="text-muted mb-4">Looks like you haven't added anything to your cart yet.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-5 py-2 fw-semibold">
                    Start Shopping Now
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/fragments/footer.jsp"/>
