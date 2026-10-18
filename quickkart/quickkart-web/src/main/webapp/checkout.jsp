<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Secure Checkout" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="d-flex align-items-center gap-2 mb-4 pb-2 border-bottom">
        <i class="bi bi-shield-lock-fill text-success fs-3"></i>
        <div>
            <h2 class="fw-bold mb-0">Secure Checkout</h2>
            <p class="text-muted small mb-0">Encrypted 256-bit transactional checkout</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <div class="row g-4">
            <!-- Left Column: Address & Payment -->
            <div class="col-lg-8">
                <!-- Step 1: Delivery Address -->
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                    <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                        <span class="badge bg-primary rounded-circle">1</span> Delivery Address
                    </h5>

                    <c:choose>
                        <c:when test="${not empty addresses}">
                            <div class="d-flex flex-column gap-3 mb-3">
                                <c:forEach var="addr" items="${addresses}" varStatus="status">
                                    <div class="form-check p-3 border rounded-3 bg-light">
                                        <input class="form-check-input ms-0 me-3" type="radio" name="addressId" id="addr_${addr.addressId}" value="${addr.addressId}" ${status.first ? 'checked' : ''}>
                                        <label class="form-check-label w-100" for="addr_${addr.addressId}">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="badge bg-secondary text-uppercase">${addr.addressType}</span>
                                                <c:if test="${addr['default']}"><span class="badge bg-success bg-opacity-25 text-success">Default</span></c:if>
                                            </div>
                                            <div class="mt-2 text-dark fw-semibold">${addr.addressLine}</div>
                                            <div class="text-muted small">${addr.city}, ${addr.state} - ${addr.pincode}</div>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Option to add new address -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="addressId" id="addr_new" value="new" data-bs-toggle="collapse" data-bs-target="#newAddressFields">
                                <label class="form-check-label fw-bold text-primary" for="addr_new">
                                    + Deliver to a Different / New Address
                                </label>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="addressId" value="new">
                        </c:otherwise>
                    </c:choose>

                    <!-- New Address Form Fields -->
                    <div class="collapse ${empty addresses ? 'show' : ''}" id="newAddressFields">
                        <div class="p-3 bg-light rounded-3 border">
                            <h6 class="fw-bold mb-3">Enter New Delivery Address</h6>
                            <div class="mb-3">
                                <label class="form-label small fw-semibold">Street / Flat / House Address</label>
                                <input type="text" name="newAddressLine" class="form-control rounded-3" placeholder="e.g. Flat 301, Lake Residency">
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-md-5">
                                    <label class="form-label small fw-semibold">City</label>
                                    <input type="text" name="newCity" class="form-control rounded-3" placeholder="City">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">State</label>
                                    <input type="text" name="newState" class="form-control rounded-3" placeholder="State">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Pincode</label>
                                    <input type="text" name="newPincode" class="form-control rounded-3" placeholder="Pincode">
                                </div>
                            </div>
                            <div class="mb-2">
                                <label class="form-label small fw-semibold">Address Type</label>
                                <select name="newAddressType" class="form-select rounded-3">
                                    <option value="HOME">Home</option>
                                    <option value="WORK">Office / Commercial</option>
                                    <option value="BILLING">Billing Only</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Step 2: Payment Method -->
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                    <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                        <span class="badge bg-primary rounded-circle">2</span> Payment Method
                    </h5>

                    <div class="d-flex flex-column gap-3">
                        <div class="form-check p-3 border rounded-3 bg-light">
                            <input class="form-check-input ms-0 me-3" type="radio" name="paymentMethod" id="pay_upi" value="UPI" checked>
                            <label class="form-check-label w-100" for="pay_upi">
                                <div class="d-flex align-items-center gap-2">
                                    <i class="bi bi-qr-code-scan fs-4 text-primary"></i>
                                    <div>
                                        <div class="fw-bold text-dark">UPI / Instant QR Code</div>
                                        <div class="text-muted small">Google Pay, PhonePe, Paytm, BHIM</div>
                                    </div>
                                </div>
                            </label>
                        </div>

                        <div class="form-check p-3 border rounded-3 bg-light">
                            <input class="form-check-input ms-0 me-3" type="radio" name="paymentMethod" id="pay_card" value="CARD">
                            <label class="form-check-label w-100" for="pay_card">
                                <div class="d-flex align-items-center gap-2">
                                    <i class="bi bi-credit-card-2-front fs-4 text-success"></i>
                                    <div>
                                        <div class="fw-bold text-dark">Credit or Debit Card</div>
                                        <div class="text-muted small">Visa, MasterCard, RuPay, American Express</div>
                                    </div>
                                </div>
                            </label>
                        </div>

                        <div class="form-check p-3 border rounded-3 bg-light">
                            <input class="form-check-input ms-0 me-3" type="radio" name="paymentMethod" id="pay_cod" value="COD">
                            <label class="form-check-label w-100" for="pay_cod">
                                <div class="d-flex align-items-center gap-2">
                                    <i class="bi bi-cash-stack fs-4 text-warning"></i>
                                    <div>
                                        <div class="fw-bold text-dark">Cash on Delivery (COD)</div>
                                        <div class="text-muted small">Pay cash upon receipt at your doorstep</div>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Final Summary & CTA -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white sticky-top" style="top: 100px;">
                    <h5 class="fw-bold mb-3">Order Overview</h5>

                    <div class="d-flex flex-column gap-2 mb-3 overflow-auto" style="max-height: 220px;">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex justify-content-between align-items-center small">
                                <div class="text-truncate me-2" style="max-width: 180px;">
                                    <span class="fw-bold">${item.quantity}x</span> ${item.product.name}
                                </div>
                                <span class="fw-semibold text-dark">₹<fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                        </c:forEach>
                    </div>

                    <hr class="my-2">

                    <div class="d-flex justify-content-between mb-2 small text-secondary">
                        <span>Items Subtotal</span>
                        <span class="fw-bold text-dark">₹<fmt:formatNumber value="${pricing.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                    </div>

                    <c:if test="${pricing.discount > 0}">
                        <div class="d-flex justify-content-between mb-2 small text-success">
                            <span>Promotional Discount</span>
                            <span class="fw-bold">-₹<fmt:formatNumber value="${pricing.discount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>
                    </c:if>

                    <div class="d-flex justify-content-between mb-3 small text-secondary">
                        <span>Delivery Fee</span>
                        <span class="fw-bold">
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

                    <hr class="my-2">

                    <div class="d-flex justify-content-between mb-4 align-items-baseline">
                        <span class="fw-bold fs-5">Final Amount</span>
                        <span class="display-6 fw-bold text-primary">₹<fmt:formatNumber value="${pricing.finalAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg rounded-pill w-100 fw-bold shadow py-3">
                        <i class="bi bi-lock-fill me-2"></i> Place Order Now
                    </button>

                    <div class="mt-3 text-center text-muted small">
                        <i class="bi bi-shield-check text-success me-1"></i> 100% Purchase Protection
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/fragments/footer.jsp"/>
