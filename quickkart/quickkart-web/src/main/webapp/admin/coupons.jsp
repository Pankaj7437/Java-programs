<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Coupons" scope="request"/>
<c:set var="activeTab" value="coupons" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/admin-navbar.jsp"/>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
    <div>
        <h1 class="h2 fw-bold text-dark">Promotional Coupons &amp; Discounts</h1>
        <p class="text-muted small mb-0">${coupons.size()} promotional discount codes configured</p>
    </div>
</div>

<div class="row g-4">
    <!-- Coupons List Table -->
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light small text-uppercase text-muted">
                        <tr>
                            <th class="ps-4">Code</th>
                            <th>Discount</th>
                            <th>Min Order</th>
                            <th>Status</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${coupons}">
                            <tr>
                                <td class="ps-4">
                                    <span class="badge bg-light text-primary border font-monospace fs-6 px-3 py-2">${c.code}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.discountType == 'PERCENTAGE'}">
                                            <span class="fw-bold text-success">${c.discountValue}% OFF</span>
                                            <c:if test="${not empty c.maximumDiscount}">
                                                <span class="text-muted small d-block">Max ₹${c.maximumDiscount}</span>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="fw-bold text-success">Flat ₹${c.discountValue} OFF</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>₹<fmt:formatNumber value="${c.minimumOrder}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/coupons/toggle" method="post" class="d-inline">
                                        <input type="hidden" name="couponId" value="${c.couponId}">
                                        <input type="hidden" name="status" value="${c.status}">
                                        <button type="submit" class="btn btn-sm ${c.status ? 'btn-success' : 'btn-secondary'} rounded-pill px-3 py-1">
                                            ${c.status ? 'Active' : 'Disabled'}
                                        </button>
                                    </form>
                                </td>
                                <td class="pe-4 text-end">
                                    <form action="${pageContext.request.contextPath}/admin/coupons/delete" method="post" class="d-inline" onsubmit="return confirm('Delete this coupon?');">
                                        <input type="hidden" name="couponId" value="${c.couponId}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger rounded-circle" title="Delete">
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
    </div>

    <!-- Create Coupon Card -->
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
            <h5 class="fw-bold mb-3">Create Promotional Coupon</h5>
            <form action="${pageContext.request.contextPath}/admin/coupons/add" method="post">
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Coupon Code</label>
                    <input type="text" name="code" class="form-control rounded-3 text-uppercase font-monospace" placeholder="e.g. FESTIVE25" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Discount Type</label>
                    <select name="discountType" class="form-select rounded-3">
                        <option value="PERCENTAGE">Percentage (%)</option>
                        <option value="FIXED">Flat Fixed Amount (₹)</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Discount Value</label>
                    <input type="number" step="0.01" name="discountValue" class="form-control rounded-3" placeholder="e.g. 15 or 50.00" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Minimum Order Requirement (₹)</label>
                    <input type="number" step="0.01" name="minimumOrder" class="form-control rounded-3" placeholder="e.g. 50.00" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Maximum Discount Cap (optional)</label>
                    <input type="number" step="0.01" name="maximumDiscount" class="form-control rounded-3" placeholder="e.g. 100.00">
                </div>
                <button type="submit" class="btn btn-primary rounded-pill w-100 fw-bold">Create Coupon</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/fragments/admin-footer.jsp"/>
