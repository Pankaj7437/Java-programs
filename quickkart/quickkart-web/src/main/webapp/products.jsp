<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<c:set var="pageTitle" value="Product Catalog" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-4">
    <!-- Breadcrumb & Title -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h2 class="fw-bold mb-1">Product Catalog</h2>
            <p class="text-muted small mb-0">
                <c:choose>
                    <c:when test="${not empty searchQuery}">
                        Showing search results for "<span class="fw-bold text-dark">${searchQuery}</span>" (${products.size()} items)
                    </c:when>
                    <c:otherwise>
                        Explore all available products (${products.size()} items found)
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        <c:if test="${not empty searchQuery or not empty selectedCategory or not empty minPrice or not empty maxPrice}">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm rounded-pill px-3 mt-2 mt-md-0">
                <i class="bi bi-x-circle me-1"></i> Reset Filters
            </a>
        </c:if>
    </div>

    <!-- Mobile Filter Trigger Bar (Visible on < 992px) -->
    <div class="d-lg-none d-flex justify-content-between align-items-center mb-3 p-2 bg-white rounded-3 shadow-sm border">
        <button class="btn btn-outline-primary btn-sm rounded-pill px-3 d-flex align-items-center gap-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasFilters" aria-controls="offcanvasFilters">
            <i class="bi bi-funnel-fill"></i>
            <span>Filters &amp; Sort</span>
            <c:if test="${not empty selectedCategory or not empty minPrice or not empty maxPrice or currentSort != 'newest'}">
                <span class="badge bg-primary rounded-pill">Active</span>
            </c:if>
        </button>
        <div class="small text-muted fw-semibold">
            ${products.size()} Items
        </div>
    </div>

    <!-- Mobile Offcanvas Filters Drawer -->
    <div class="offcanvas offcanvas-start rounded-end-4" tabindex="-1" id="offcanvasFilters" aria-labelledby="offcanvasFiltersLabel">
        <div class="offcanvas-header border-bottom">
            <h5 class="offcanvas-title fw-bold d-flex align-items-center gap-2" id="offcanvasFiltersLabel">
                <i class="bi bi-funnel-fill text-primary"></i> Filter &amp; Sort
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body p-4">
            <form action="${pageContext.request.contextPath}/products" method="get">
                <c:if test="${not empty searchQuery}">
                    <input type="hidden" name="q" value="${searchQuery}">
                </c:if>

                <!-- Sort By -->
                <div class="mb-4">
                    <label class="form-label fw-bold small text-uppercase text-muted">Sort By</label>
                    <select name="sort" class="form-select rounded-3 shadow-none">
                        <option value="newest" ${currentSort == 'newest' ? 'selected' : ''}>Newest Arrivals</option>
                        <option value="price_asc" ${currentSort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="price_desc" ${currentSort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                        <option value="discount" ${currentSort == 'discount' ? 'selected' : ''}>Highest Discount</option>
                    </select>
                </div>

                <!-- Price Filter -->
                <div class="mb-4">
                    <label class="form-label fw-bold small text-uppercase text-muted">Price Range (₹)</label>
                    <div class="d-flex gap-2 align-items-center mb-2">
                        <input type="number" name="minPrice" value="${minPrice}" placeholder="Min" class="form-control rounded-3">
                        <span class="text-muted">-</span>
                        <input type="number" name="maxPrice" value="${maxPrice}" placeholder="Max" class="form-control rounded-3">
                    </div>
                </div>

                <!-- Category Filter -->
                <div class="mb-4">
                    <label class="form-label fw-bold small text-uppercase text-muted">Category</label>
                    <div class="d-flex flex-column gap-1">
                        <a href="${pageContext.request.contextPath}/products${not empty searchQuery ? '?q='.concat(searchQuery) : ''}"
                           class="text-decoration-none py-2 px-3 rounded-3 ${empty selectedCategory ? 'bg-primary text-white fw-bold' : 'text-dark bg-light'}">
                            All Categories
                        </a>
                        <c:forEach var="cat" items="${categories}">
                            <a href="${pageContext.request.contextPath}/products?category=${cat.categoryId}${not empty searchQuery ? '&q='.concat(searchQuery) : ''}"
                               class="text-decoration-none py-2 px-3 rounded-3 ${selectedCategory == cat.categoryId ? 'bg-primary text-white fw-bold' : 'text-dark bg-light'}">
                                ${cat.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <div class="d-grid gap-2 pt-2">
                    <button type="submit" class="btn btn-primary rounded-pill py-2.5 fw-bold">Apply Filters</button>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary rounded-pill py-2">Reset All</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Horizontal Category Scroll Chips for Quick Tapping -->
    <div class="d-flex gap-2 overflow-x-auto pb-3 mb-4 scrollbar-none" style="white-space: nowrap; -webkit-overflow-scrolling: touch;">
        <a href="${pageContext.request.contextPath}/products${not empty searchQuery ? '?q='.concat(searchQuery) : ''}"
           class="badge rounded-pill px-3 py-2 text-decoration-none ${empty selectedCategory ? 'bg-primary text-white shadow-sm' : 'bg-white text-secondary border'}">
            All Products
        </a>
        <c:forEach var="cat" items="${categories}">
            <a href="${pageContext.request.contextPath}/products?category=${cat.categoryId}${not empty searchQuery ? '&q='.concat(searchQuery) : ''}"
               class="badge rounded-pill px-3 py-2 text-decoration-none ${selectedCategory == cat.categoryId ? 'bg-primary text-white shadow-sm' : 'bg-white text-secondary border'}">
                ${cat.name}
            </a>
        </c:forEach>
    </div>

    <div class="row g-4">
        <!-- Desktop Sidebar Filters (Visible on >= 992px) -->
        <div class="col-lg-3 d-none d-lg-block">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white sticky-top" style="top: 90px; z-index: 10;">
                <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-funnel-fill text-primary"></i> Filter Products
                </h5>

                <form action="${pageContext.request.contextPath}/products" method="get">
                    <c:if test="${not empty searchQuery}">
                        <input type="hidden" name="q" value="${searchQuery}">
                    </c:if>

                    <!-- Category Filter -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold small text-uppercase text-muted">Category</label>
                        <div class="d-flex flex-column gap-1">
                            <a href="${pageContext.request.contextPath}/products${not empty searchQuery ? '?q='.concat(searchQuery) : ''}"
                               class="text-decoration-none py-1 px-2 rounded-2 ${empty selectedCategory ? 'bg-primary text-white fw-bold' : 'text-dark'}">
                                All Categories
                            </a>
                            <c:forEach var="cat" items="${categories}">
                                <a href="${pageContext.request.contextPath}/products?category=${cat.categoryId}${not empty searchQuery ? '&q='.concat(searchQuery) : ''}"
                                   class="text-decoration-none py-1 px-2 rounded-2 ${selectedCategory == cat.categoryId ? 'bg-primary text-white fw-bold' : 'text-dark'}">
                                    ${cat.name}
                                </a>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Sort By -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold small text-uppercase text-muted">Sort By</label>
                        <select name="sort" class="form-select rounded-3 shadow-none" onchange="this.form.submit()">
                            <option value="newest" ${currentSort == 'newest' ? 'selected' : ''}>Newest Arrivals</option>
                            <option value="price_asc" ${currentSort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_desc" ${currentSort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                            <option value="discount" ${currentSort == 'discount' ? 'selected' : ''}>Highest Discount</option>
                        </select>
                    </div>

                    <!-- Price Filter -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold small text-uppercase text-muted">Price Range (₹)</label>
                        <div class="d-flex gap-2 align-items-center mb-2">
                            <input type="number" name="minPrice" value="${minPrice}" placeholder="Min" class="form-control form-control-sm rounded-3">
                            <span class="text-muted">-</span>
                            <input type="number" name="maxPrice" value="${maxPrice}" placeholder="Max" class="form-control form-control-sm rounded-3">
                        </div>
                        <c:if test="${not empty selectedCategory}">
                            <input type="hidden" name="category" value="${selectedCategory}">
                        </c:if>
                        <button type="submit" class="btn btn-outline-primary btn-sm w-100 rounded-pill">Apply Filter</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="col-lg-9">
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="row">
                        <c:forEach var="prod" items="${products}">
                            <tags:productCard product="${prod}" />
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 bg-white rounded-4 border shadow-sm">
                        <i class="bi bi-search fs-1 text-muted mb-3 d-block"></i>
                        <h4 class="fw-bold">No Products Found</h4>
                        <p class="text-muted mb-3">We couldn't find any products matching your current criteria.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-4">Browse All Products</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/fragments/footer.jsp"/>
