<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Profile" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="mb-4 pb-2 border-bottom">
        <h2 class="fw-bold mb-1">Account &amp; Settings</h2>
        <p class="text-muted small mb-0">Manage your credentials, delivery addresses, and preferences</p>
    </div>

    <div class="row g-4">
        <!-- Personal Information -->
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-person-circle text-primary"></i> Personal Information
                </h5>

                <form action="${pageContext.request.contextPath}/profile" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Email Address (Read-only)</label>
                        <input type="email" class="form-control rounded-3 bg-light" value="${profileUser.email}" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Full Name</label>
                        <input type="text" name="name" class="form-control rounded-3" value="${profileUser.name}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Mobile Number</label>
                        <input type="text" name="mobile" class="form-control rounded-3" value="${profileUser.mobile}">
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-semibold">Update Password (leave blank to keep current)</label>
                        <input type="password" name="newPassword" class="form-control rounded-3" placeholder="••••••••">
                    </div>

                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-semibold">Save Profile Changes</button>
                </form>
            </div>
        </div>

        <!-- Address Book -->
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-geo-alt-fill text-danger"></i> Saved Delivery Addresses
                </h5>

                <c:choose>
                    <c:when test="${not empty addresses}">
                        <div class="d-flex flex-column gap-3 mb-4">
                            <c:forEach var="addr" items="${addresses}">
                                <div class="p-3 border rounded-3 bg-light d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="d-flex align-items-center gap-2 mb-1">
                                            <span class="badge bg-secondary text-uppercase">${addr.addressType}</span>
                                            <c:if test="${addr['default']}"><span class="badge bg-success bg-opacity-25 text-success">Default</span></c:if>
                                        </div>
                                        <div class="fw-semibold text-dark">${addr.addressLine}</div>
                                        <div class="text-muted small">${addr.city}, ${addr.state} - ${addr.pincode}</div>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/address/delete" method="post" onsubmit="return confirm('Delete this address?');">
                                        <input type="hidden" name="addressId" value="${addr.addressId}">
                                        <button type="submit" class="btn btn-outline-danger btn-sm rounded-circle p-2" title="Delete">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted small mb-4">No addresses saved yet. Add your primary delivery address below.</p>
                    </c:otherwise>
                </c:choose>

                <!-- Add New Address Form -->
                <div class="p-3 bg-light rounded-3 border">
                    <h6 class="fw-bold mb-3">Add New Address</h6>
                    <form action="${pageContext.request.contextPath}/address/add" method="post">
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Street / Flat / House</label>
                            <input type="text" name="addressLine" class="form-control rounded-3 form-control-sm" required>
                        </div>
                        <div class="row g-2 mb-3">
                            <div class="col-md-5">
                                <label class="form-label small fw-semibold">City</label>
                                <input type="text" name="city" class="form-control rounded-3 form-control-sm" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-semibold">State</label>
                                <input type="text" name="state" class="form-control rounded-3 form-control-sm" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-semibold">Pincode</label>
                                <input type="text" name="pincode" class="form-control rounded-3 form-control-sm" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Address Type</label>
                            <select name="addressType" class="form-select rounded-3 form-select-sm">
                                <option value="HOME">Home</option>
                                <option value="WORK">Office</option>
                                <option value="BILLING">Billing Only</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-outline-primary btn-sm rounded-pill px-4">Add Address</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/fragments/footer.jsp"/>
