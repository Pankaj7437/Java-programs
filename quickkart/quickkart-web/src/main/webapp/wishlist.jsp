<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Wishlist" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<div class="container my-5">
    <div class="mb-4 pb-2 border-bottom">
        <h2 class="fw-bold mb-1">My Saved Wishlist</h2>
        <p class="text-muted small mb-0">${wishlist.size()} items saved for future consideration</p>
    </div>

    <c:choose>
        <c:when test="${not empty wishlist}">
            <div class="row g-4">
                <c:forEach var="item" items="${wishlist}">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                            <div class="position-relative" style="height: 200px;">
                                <c:set var="wishItemImgSrc" value="${pageContext.request.contextPath}/assets/img/product-placeholder.svg"/>
                                <c:if test="${not empty item.product.imageUrl}">
                                    <c:choose>
                                        <c:when test="${item.product.imageUrl.startsWith('http')}">
                                            <c:set var="wishItemImgSrc" value="${item.product.imageUrl}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="wishItemImgSrc" value="${pageContext.request.contextPath}${item.product.imageUrl}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <img src="${wishItemImgSrc}"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                                     alt="${item.product.name}" class="img-fluid" style="width: 100%; height: 100%; object-fit: cover;">
                                <form action="${pageContext.request.contextPath}/wishlist" method="post" class="position-absolute top-0 end-0 m-2">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <button type="submit" class="btn btn-light btn-sm rounded-circle shadow-sm" title="Remove">
                                        <i class="bi bi-x-lg text-danger"></i>
                                    </button>
                                </form>
                            </div>

                            <div class="card-body d-flex flex-column p-3">
                                <span class="text-muted small text-uppercase fw-semibold mb-1">${item.product.brand}</span>
                                <h6 class="fw-bold mb-2 text-truncate" title="${item.product.name}">
                                    <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}" class="text-decoration-none text-dark">
                                        ${item.product.name}
                                    </a>
                                </h6>

                                <div class="mt-auto">
                                    <div class="d-flex align-items-baseline gap-2 mb-3">
                                        <span class="fs-5 fw-bold text-primary">₹<fmt:formatNumber value="${item.product.discountedPrice}" minFractionDigits="2" maxFractionDigits="2"/></span>
                                        <c:if test="${item.product.discount > 0}">
                                            <span class="text-muted text-decoration-line-through small">₹<fmt:formatNumber value="${item.product.price}" minFractionDigits="2" maxFractionDigits="2"/></span>
                                        </c:if>
                                    </div>

                                    <form action="${pageContext.request.contextPath}/wishlist" method="post" class="d-grid">
                                        <input type="hidden" name="action" value="moveToCart">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <button type="submit" class="btn btn-primary btn-sm rounded-pill py-2 fw-semibold">
                                            <i class="bi bi-bag-plus me-1"></i> Move to Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 border shadow-sm my-4">
                <i class="bi bi-heart fs-1 text-muted mb-3 d-block"></i>
                <h4 class="fw-bold">Your Wishlist is Empty</h4>
                <p class="text-muted mb-4">Save your favorite items here to purchase later or track discounts.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-4">Browse Catalog</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/fragments/footer.jsp"/>
