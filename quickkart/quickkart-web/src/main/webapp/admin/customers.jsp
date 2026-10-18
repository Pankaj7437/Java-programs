<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Customers" scope="request"/>
<c:set var="activeTab" value="customers" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/admin-navbar.jsp"/>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
    <div>
        <h1 class="h2 fw-bold text-dark">Customer Directory</h1>
        <p class="text-muted small mb-0">${customers.size()} total registered user accounts</p>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light small text-uppercase text-muted">
                <tr>
                    <th class="ps-4">User</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th class="pe-4 text-end">Registered On</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${customers}">
                    <tr>
                        <td class="ps-4">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-person-circle fs-4 ${u.admin ? 'text-warning' : 'text-primary'}"></i>
                                <span class="fw-bold text-dark">${u.name}</span>
                            </div>
                        </td>
                        <td>${u.email}</td>
                        <td class="text-muted">${not empty u.mobile ? u.mobile : '—'}</td>
                        <td>
                            <span class="badge ${u.admin ? 'bg-warning text-dark font-monospace' : 'bg-light text-dark border'}">${u.role}</span>
                        </td>
                        <td>
                            <span class="badge ${u.status == 'ACTIVE' ? 'bg-success bg-opacity-25 text-success' : 'bg-danger'}">${u.status}</span>
                        </td>
                        <td class="pe-4 text-end small text-muted"><fmt:formatDate value="${u.createdAt}" pattern="dd MMM yyyy"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/fragments/admin-footer.jsp"/>
