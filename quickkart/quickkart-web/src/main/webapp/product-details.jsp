<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<c:set var="pageTitle" value="${product.name}" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none">Home</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products" class="text-decoration-none">Products</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
        </ol>
    </nav>

    <!-- Product Showcase -->
    <div class="row g-5 mb-5 align-items-center">
        <!-- Product Image -->
        <div class="col-lg-6">
            <c:set var="detailImgSrc" value="${pageContext.request.contextPath}/assets/img/product-placeholder.svg"/>
            <c:if test="${not empty product.imageUrl}">
                <c:choose>
                    <c:when test="${product.imageUrl.startsWith('http')}">
                        <c:set var="detailImgSrc" value="${product.imageUrl}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="detailImgSrc" value="${pageContext.request.contextPath}${product.imageUrl}"/>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white p-3 text-center">
                <img src="${detailImgSrc}"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                     alt="${product.name}" class="img-fluid rounded-4 shadow-sm" style="max-height: 480px; width: 100%; object-fit: cover;">
            </div>
        </div>

        <!-- Product Actions & Info -->
        <div class="col-lg-6">
            <div class="ps-lg-3">
                <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-bold mb-2">
                    ${product.categoryName != null ? product.categoryName : 'Featured'}
                </span>
                <span class="text-muted fw-semibold ms-2 text-uppercase small">${product.brand}</span>

                <h1 class="fw-bold mb-2 mt-1 text-dark">${product.name}</h1>

                <div class="d-flex align-items-center gap-3 mb-3">
                    <tags:rating score="${product.rating}" />
                    <span class="text-muted small">(${reviews.size()} customer reviews)</span>
                    <span class="text-muted small">•</span>
                    <c:choose>
                        <c:when test="${product.stock > 10}">
                            <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-1">In Stock (${product.stock} units)</span>
                        </c:when>
                        <c:when test="${product.stock > 0}">
                            <span class="badge bg-warning bg-opacity-25 text-dark rounded-pill px-3 py-1">Only ${product.stock} left!</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-3 py-1">Out of Stock</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Price Box -->
                <div class="p-3 bg-light rounded-4 mb-4 d-flex align-items-baseline gap-3">
                    <span class="display-6 fw-bold text-primary">₹<fmt:formatNumber value="${product.discountedPrice}" minFractionDigits="2" maxFractionDigits="2"/></span>
                    <c:if test="${product.discount > 0}">
                        <span class="fs-4 text-muted text-decoration-line-through">₹<fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/></span>
                        <span class="badge bg-danger rounded-pill px-3 py-2 fw-bold">Save <fmt:formatNumber value="${product.discount}" maxFractionDigits="0"/>%</span>
                    </c:if>
                </div>

                <p class="text-secondary mb-4 leading-relaxed">${product.description}</p>

                <!-- Add to Cart & Wishlist Actions -->
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="mb-4">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.productId}">

                            <div class="row g-3 align-items-center mb-3">
                                <div class="col-auto">
                                    <label class="fw-semibold small">Quantity:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="number" name="quantity" value="1" min="1" max="${product.stock}" class="form-control rounded-pill text-center shadow-none" style="width: 90px;">
                                </div>
                            </div>

                            <div class="d-flex flex-wrap gap-3">
                                <button type="submit" class="btn btn-primary btn-lg rounded-pill px-5 fw-bold shadow">
                                    <i class="bi bi-cart-plus me-2"></i> Add to Cart
                                </button>
                                <button type="submit" formaction="${pageContext.request.contextPath}/wishlist" class="btn btn-outline-danger btn-lg rounded-pill px-4" title="Save to Wishlist">
                                    <i class="bi bi-heart me-1"></i> Wishlist
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning rounded-4 mb-4">
                            <i class="bi bi-info-circle me-2"></i> This product is currently out of stock. Add it to your wishlist to get notified when available.
                        </div>
                        <form action="${pageContext.request.contextPath}/wishlist" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <button type="submit" class="btn btn-outline-danger rounded-pill px-4">
                                <i class="bi bi-heart me-1"></i> Save to Wishlist
                            </button>
                        </form>
                    </c:otherwise>
                </c:choose>

                <!-- Trust Badges -->
                <div class="pt-4 border-top d-flex gap-4 text-muted small">
                    <div><i class="bi bi-arrow-counterclockwise text-primary me-1"></i> 30-Day Easy Returns</div>
                    <div><i class="bi bi-shield-lock text-success me-1"></i> Secure 256-Bit SSL Checkout</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Customer Reviews Section -->
    <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1">Customer Reviews</h3>
                <p class="text-muted small mb-0">Verified customer feedback and product ratings</p>
            </div>
        </div>

        <div class="row g-4">
            <!-- Review Submission Form -->
            <div class="col-lg-5">
                <div class="p-4 bg-light rounded-4">
                    <h5 class="fw-bold mb-3">Write a Review</h5>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/review/add" method="post">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold small">Rating (1 to 5 Stars)</label>
                                    <select name="rating" class="form-select rounded-3">
                                        <option value="5">⭐⭐⭐⭐⭐ 5 - Excellent</option>
                                        <option value="4">⭐⭐⭐⭐ 4 - Very Good</option>
                                        <option value="3">⭐⭐⭐ 3 - Average</option>
                                        <option value="2">⭐⭐ 2 - Poor</option>
                                        <option value="1">⭐ 1 - Terrible</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-semibold small">Your Feedback</label>
                                    <textarea name="reviewText" rows="3" class="form-control rounded-3" placeholder="Share your experience with this item..." required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary rounded-pill px-4">Submit Review</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted small mb-3">Please sign in to share your thoughts and rate this product.</p>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary rounded-pill px-4">Sign In to Review</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Existing Reviews List -->
            <div class="col-lg-7">
                <c:choose>
                    <c:when test="${not empty reviews}">
                        <div class="d-flex flex-column gap-3">
                            <c:forEach var="rev" items="${reviews}">
                                <div class="p-3 border rounded-3 bg-white">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <div class="fw-bold text-dark"><i class="bi bi-person-circle me-1 text-primary"></i> ${rev.userName}</div>
                                        <tags:rating score="${rev.rating * 1.0}" />
                                    </div>
                                    <p class="text-secondary small mb-0">${rev.reviewText}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-chat-square-text fs-2 mb-2 d-block"></i>
                            <p class="mb-0">No reviews yet. Be the first to review this product!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <c:if test="${not empty relatedProducts}">
        <h4 class="fw-bold mb-4">Related in ${product.categoryName}</h4>
        <div class="row">
            <c:forEach var="rel" items="${relatedProducts}">
                <tags:productCard product="${rel}" />
            </c:forEach>
        </div>
    </c:if>
</div>

<jsp:include page="/fragments/footer.jsp"/>
