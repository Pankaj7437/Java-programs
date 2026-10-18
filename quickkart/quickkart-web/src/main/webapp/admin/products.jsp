<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Products" scope="request"/>
<c:set var="activeTab" value="products" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/admin-navbar.jsp"/>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
    <div>
        <h1 class="h2 fw-bold text-dark">Product Catalog Management</h1>
        <p class="text-muted small mb-0">${products.size()} total SKUs in database</p>
    </div>
    <button type="button" class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addProductModal">
        <i class="bi bi-plus-lg me-1"></i> Add New Product
    </button>
</div>

<!-- Products Table -->
<div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light small text-uppercase text-muted">
                <tr>
                    <th class="ps-4">Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Discount</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th class="pe-4 text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td class="ps-4">
                            <div class="d-flex align-items-center gap-3">
                                <img src="${p.imageUrl != null ? p.imageUrl : pageContext.request.contextPath.concat('/assets/img/product-placeholder.svg')}"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                                     alt="${p.name}" class="rounded-3 shadow-sm" style="width: 48px; height: 48px; object-fit: cover;">
                                <div>
                                    <div class="fw-bold text-dark">${p.name}</div>
                                    <span class="text-muted small">${p.brand}</span>
                                </div>
                            </div>
                        </td>
                        <td><span class="badge bg-light text-dark border">${p.categoryName}</span></td>
                        <td class="fw-semibold">₹<fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td>
                            <c:if test="${p.discount > 0}"><span class="badge bg-danger">-${p.discount}%</span></c:if>
                        </td>
                        <td>
                            <span class="badge ${p.stock <= 10 ? 'bg-danger' : 'bg-success'}">${p.stock} units</span>
                        </td>
                        <td>
                            <span class="badge ${p.status ? 'bg-success bg-opacity-25 text-success' : 'bg-secondary'}">${p.status ? 'Active' : 'Draft'}</span>
                        </td>
                        <td class="pe-4 text-end">
                            <div class="d-inline-flex gap-2">
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-circle" data-bs-toggle="modal" data-bs-target="#editModal_${p.productId}" title="Edit">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/products/delete" method="post" class="d-inline" onsubmit="return confirm('Delete this product permanently?');">
                                    <input type="hidden" name="productId" value="${p.productId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-circle" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>

                            <!-- Edit Modal for this Product -->
                            <div class="modal fade text-start" id="editModal_${p.productId}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content rounded-4 border-0 shadow">
                                        <div class="modal-header">
                                            <h5 class="modal-title fw-bold">Edit Product: ${p.name}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/admin/products/edit" method="post">
                                            <input type="hidden" name="productId" value="${p.productId}">
                                            <div class="modal-body p-4">
                                                <div class="row g-3">
                                                    <div class="col-md-8">
                                                        <label class="form-label small fw-semibold">Product Name</label>
                                                        <input type="text" name="name" class="form-control rounded-3" value="${p.name}" required>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label small fw-semibold">Brand</label>
                                                        <input type="text" name="brand" class="form-control rounded-3" value="${p.brand}" required>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label small fw-semibold">Category</label>
                                                        <select name="categoryId" class="form-select rounded-3">
                                                            <c:forEach var="cat" items="${categories}">
                                                                <option value="${cat.categoryId}" ${cat.categoryId == p.categoryId ? 'selected' : ''}>${cat.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label small fw-semibold">Image URL</label>
                                                        <input type="url" name="imageUrl" class="form-control rounded-3" value="${p.imageUrl}">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label small fw-semibold">Price (₹)</label>
                                                        <input type="number" step="0.01" name="price" class="form-control rounded-3" value="${p.price}" required>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label small fw-semibold">Discount (%)</label>
                                                        <input type="number" step="0.01" name="discount" class="form-control rounded-3" value="${p.discount}">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label small fw-semibold">Stock Units</label>
                                                        <input type="number" name="stock" class="form-control rounded-3" value="${p.stock}" required>
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label small fw-semibold">Description</label>
                                                        <textarea name="description" rows="3" class="form-control rounded-3">${p.description}</textarea>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" name="status" id="status_${p.productId}" ${p.status ? 'checked' : ''}>
                                                            <label class="form-check-label" for="status_${p.productId}">Publish &amp; Enable Product</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-primary rounded-pill px-4">Save Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header">
                <h5 class="modal-title fw-bold">Create New Product</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/products/add" method="post">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label small fw-semibold">Product Name</label>
                            <input type="text" name="name" class="form-control rounded-3" placeholder="e.g. Wireless Ergonomic Keyboard" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Brand</label>
                            <input type="text" name="brand" class="form-control rounded-3" placeholder="e.g. Logitech" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Category</label>
                            <select name="categoryId" class="form-select rounded-3">
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Image URL</label>
                            <input type="url" name="imageUrl" class="form-control rounded-3" placeholder="https://images.unsplash.com/...">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Price (₹)</label>
                            <input type="number" step="0.01" name="price" class="form-control rounded-3" placeholder="99.99" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Discount (%)</label>
                            <input type="number" step="0.01" name="discount" class="form-control rounded-3" placeholder="10.0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Initial Stock Units</label>
                            <input type="number" name="stock" class="form-control rounded-3" placeholder="50" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-semibold">Description</label>
                            <textarea name="description" rows="3" class="form-control rounded-3" placeholder="Detailed product specifications and features..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Create Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/fragments/admin-footer.jsp"/>
