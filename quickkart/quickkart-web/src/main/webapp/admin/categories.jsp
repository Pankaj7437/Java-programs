<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Manage Categories" scope="request"/>
<c:set var="activeTab" value="categories" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/admin-navbar.jsp"/>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
    <div>
        <h1 class="h2 fw-bold text-dark">Category Management</h1>
        <p class="text-muted small mb-0">Organize catalog departments and browsing hierarchies</p>
    </div>
</div>

<div class="row g-4">
    <!-- Categories List -->
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light small text-uppercase text-muted">
                        <tr>
                            <th class="ps-4">Category</th>
                            <th>Slug</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categories}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="bi bi-folder-fill text-primary"></i>
                                        <span class="fw-bold text-dark">${cat.name}</span>
                                    </div>
                                </td>
                                <td><code>${cat.slug}</code></td>
                                <td class="text-muted small text-truncate" style="max-width: 200px;">${cat.description}</td>
                                <td>
                                    <span class="badge ${cat.status ? 'bg-success bg-opacity-25 text-success' : 'bg-secondary'}">${cat.status ? 'Active' : 'Disabled'}</span>
                                </td>
                                <td class="pe-4 text-end">
                                    <form action="${pageContext.request.contextPath}/admin/categories/delete" method="post" class="d-inline" onsubmit="return confirm('Delete this category?');">
                                        <input type="hidden" name="categoryId" value="${cat.categoryId}">
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

    <!-- Create Category Card -->
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
            <h5 class="fw-bold mb-3">Add New Category</h5>
            <form action="${pageContext.request.contextPath}/admin/categories/add" method="post">
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Category Name</label>
                    <input type="text" name="name" class="form-control rounded-3" placeholder="e.g. Gaming & VR" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">URL Slug (optional)</label>
                    <input type="text" name="slug" class="form-control rounded-3" placeholder="e.g. gaming-vr">
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Banner Image URL</label>
                    <input type="url" name="imageUrl" class="form-control rounded-3" placeholder="https://images.unsplash.com/...">
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Description</label>
                    <textarea name="description" rows="3" class="form-control rounded-3" placeholder="Brief category description..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary rounded-pill w-100 fw-bold">Create Category</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/fragments/admin-footer.jsp"/>
