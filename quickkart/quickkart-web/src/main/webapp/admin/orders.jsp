<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Orders" scope="request"/>
<c:set var="activeTab" value="orders" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/admin-navbar.jsp"/>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
    <div>
        <h1 class="h2 fw-bold text-dark">Order Fulfillment Management</h1>
        <p class="text-muted small mb-0">${orders.size()} customer orders placed</p>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light small text-uppercase text-muted">
                <tr>
                    <th class="ps-4">Order ID</th>
                    <th>Customer</th>
                    <th>Amount</th>
                    <th>Payment</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th class="pe-4 text-end">Update Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ord" items="${orders}">
                    <tr>
                        <td class="ps-4 font-monospace fw-bold text-primary">#SPH-${ord.orderId}</td>
                        <td>
                            <div class="fw-semibold text-dark">${ord.userName}</div>
                            <span class="text-muted small">${ord.userEmail}</span>
                        </td>
                        <td class="fw-bold">₹<fmt:formatNumber value="${ord.finalAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td>
                            <span class="badge ${ord.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">${ord.paymentStatus}</span>
                            <span class="text-muted small d-block">${ord.paymentMethod}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${ord.orderStatus == 'DELIVERED'}">
                                    <span class="badge bg-success bg-opacity-25 text-success">Delivered</span>
                                </c:when>
                                <c:when test="${ord.orderStatus == 'CANCELLED'}">
                                    <span class="badge bg-danger bg-opacity-25 text-danger">Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-primary bg-opacity-25 text-primary">${ord.orderStatus}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="small text-muted"><fmt:formatDate value="${ord.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></td>
                        <td class="pe-4 text-end">
                            <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post" class="d-inline-flex gap-1 align-items-center">
                                <input type="hidden" name="orderId" value="${ord.orderId}">
                                <select name="orderStatus" class="form-select form-select-sm rounded-pill shadow-none" style="width: 140px;">
                                    <option value="PENDING" ${ord.orderStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                                    <option value="CONFIRMED" ${ord.orderStatus == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                    <option value="SHIPPED" ${ord.orderStatus == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                                    <option value="DELIVERED" ${ord.orderStatus == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                    <option value="CANCELLED" ${ord.orderStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-dark rounded-pill px-3">Save</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/fragments/admin-footer.jsp"/>
