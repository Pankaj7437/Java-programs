<%@ tag description="Reusable QuickKart Product Card" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ attribute name="product" type="com.quickkart.common.model.Product" required="true" %>

<div class="col-6 col-md-4 col-lg-3 mb-3 mb-md-4">
    <div class="card product-card h-100 shadow-sm border-0 position-relative">
        <c:if test="${product.discount > 0}">
            <span class="badge bg-danger position-absolute top-0 start-0 m-2 px-2 py-1 rounded-pill">
                -<fmt:formatNumber value="${product.discount}" maxFractionDigits="0"/>% OFF
            </span>
        </c:if>

        <c:set var="cardImgSrc" value="${pageContext.request.contextPath}/assets/img/product-placeholder.svg"/>
        <c:if test="${not empty product.imageUrl}">
            <c:choose>
                <c:when test="${product.imageUrl.startsWith('http')}">
                    <c:set var="cardImgSrc" value="${product.imageUrl}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="cardImgSrc" value="${pageContext.request.contextPath}${product.imageUrl}"/>
                </c:otherwise>
            </c:choose>
        </c:if>

        <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}" class="text-decoration-none text-dark">
            <div class="product-img-wrapper overflow-hidden bg-light rounded-top d-flex align-items-center justify-content-center" style="height: 220px;">
                <img src="${cardImgSrc}"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-placeholder.svg';"
                     alt="${product.name}" class="img-fluid product-img" style="object-fit: cover; width: 100%; height: 100%;" loading="lazy">
            </div>
        </a>

        <div class="card-body d-flex flex-column p-3">
            <div class="d-flex justify-content-between align-items-center mb-1">
                <span class="text-muted small text-uppercase fw-semibold">${product.brand}</span>
                <tags:rating score="${product.rating}" />
            </div>

            <h6 class="card-title mb-2 fw-bold text-truncate" title="${product.name}">
                <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}" class="text-decoration-none text-dark">
                    ${product.name}
                </a>
            </h6>

            <div class="mt-auto pt-2">
                <div class="d-flex align-items-baseline gap-2 mb-3">
                    <span class="fs-5 fw-bold text-primary">₹<fmt:formatNumber value="${product.discountedPrice}" minFractionDigits="2" maxFractionDigits="2"/></span>
                    <c:if test="${product.discount > 0}">
                        <span class="text-muted text-decoration-line-through small">₹<fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/></span>
                    </c:if>
                </div>

                <div class="d-grid gap-2">
                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="d-grid">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn btn-primary btn-sm rounded-pill py-2 fw-semibold">
                                    <i class="bi bi-cart-plus me-1"></i> Add to Cart
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-secondary btn-sm rounded-pill py-2 disabled">Out of Stock</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
