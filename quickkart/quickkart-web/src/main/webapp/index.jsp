<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<c:set var="pageTitle" value="Next-Gen Enterprise E-Commerce" scope="request"/>
<jsp:include page="/fragments/header.jsp"/>
<jsp:include page="/fragments/navbar.jsp"/>

<!-- Top Announcement Bar -->
<div class="bg-primary bg-opacity-10 py-2 border-bottom border-primary border-opacity-10">
    <div class="container text-center small fw-semibold text-primary d-flex justify-content-center align-items-center gap-2">
        <span class="badge bg-primary rounded-pill px-2 py-1">SPECIAL OFFER</span>
        <span>Get Flat 10% Off your first purchase with coupon code <strong class="text-dark bg-white px-2 py-0.5 rounded border">WELCOME10</strong> • Free Express Shipping on orders above ₹499!</span>
    </div>
</div>

<div class="container my-4">
    <!-- Modern Responsive Hero Banner -->
    <div class="hero-banner p-4 p-md-5 mb-5 shadow-lg position-relative overflow-hidden">
        <!-- Ambient Background Glows -->
        <div class="hero-ambient-glow-1"></div>
        <div class="hero-ambient-glow-2"></div>

        <div class="row align-items-center position-relative" style="z-index: 2;">
            <!-- Left Info Column -->
            <div class="col-lg-7 py-2 py-lg-4">
                <div class="d-inline-flex align-items-center gap-2 px-3 py-1.5 rounded-pill bg-white bg-opacity-10 border border-white border-opacity-15 text-white mb-3 shadow-sm backdrop-blur">
                    <span class="badge bg-warning text-dark rounded-pill px-2.5 py-1 fw-bold font-monospace">FLAGSHIP AUDIO</span>
                    <span class="small fw-semibold">ProSound Series 2026 • 15% OFF</span>
                </div>
                
                <h1 class="display-4 fw-extrabold text-white mb-3 tracking-tight">
                    Pure Studio Acoustics. <br class="d-none d-sm-inline">
                    <span class="text-gradient-cyan">Zero Distraction.</span>
                </h1>
                
                <p class="lead text-light text-opacity-80 mb-4 col-xl-10">
                    Engineered with 40mm acoustic drivers, active hybrid noise cancellation, and 40-hour ultra-endurance battery life. Elevate your everyday listening with QuickKart.
                </p>

                <!-- Key Specs Grid -->
                <div class="d-flex flex-wrap gap-2 gap-sm-3 mb-4 text-white text-opacity-90 small">
                    <span class="px-3 py-1.5 rounded-pill bg-black bg-opacity-25 border border-white border-opacity-10 d-inline-flex align-items-center">
                        <i class="bi bi-shield-check text-info me-1.5"></i> Hybrid ANC 40dB
                    </span>
                    <span class="px-3 py-1.5 rounded-pill bg-black bg-opacity-25 border border-white border-opacity-10 d-inline-flex align-items-center">
                        <i class="bi bi-battery-charging text-warning me-1.5"></i> 40-Hr Playtime
                    </span>
                    <span class="px-3 py-1.5 rounded-pill bg-black bg-opacity-25 border border-white border-opacity-10 d-inline-flex align-items-center">
                        <i class="bi bi-truck text-success me-1.5"></i> Free Express Delivery
                    </span>
                </div>

                <!-- Call to action buttons -->
                <div class="d-flex flex-wrap align-items-center gap-3">
                    <a href="${pageContext.request.contextPath}/product-details?id=1" class="btn btn-primary btn-lg rounded-pill px-4 py-2.5 fw-bold shadow-lg d-inline-flex align-items-center gap-2">
                        <i class="bi bi-bag-plus-fill"></i> Buy Flagship • ₹12,749
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-light btn-lg rounded-pill px-4 py-2.5 fw-semibold d-inline-flex align-items-center gap-2">
                        <i class="bi bi-grid-fill"></i> Browse All (${totalProductCount}+ Items)
                    </a>
                </div>
            </div>

            <!-- Right Visual Column: Headphone Spotlight (Visible on Desktop, Tablet & Mobile) -->
            <div class="col-lg-5 col-md-8 col-sm-10 col-12 mx-auto text-center position-relative mt-4 mt-lg-0">
                <a href="${pageContext.request.contextPath}/product-details?id=1" class="text-decoration-none d-block hero-headphone-card position-relative">
                    <div class="card border-0 rounded-4 overflow-hidden position-relative shadow-2xl p-3 bg-dark bg-opacity-50 border border-white border-opacity-15 backdrop-blur">
                        <img src="${pageContext.request.contextPath}/assets/img/hero-headphones.jpg"
                             alt="ProSound Wireless Noise-Cancelling Headphones"
                             class="img-fluid rounded-4 hero-headphone-img"
                             style="width: 100%; max-height: 380px; object-fit: cover;">
                        
                        <!-- Floating Badge on Card Top-Left -->
                        <div class="position-absolute top-0 start-0 m-3 m-sm-4 px-3 py-1.5 rounded-pill bg-danger text-white small fw-bold shadow-lg d-flex align-items-center gap-1.5">
                            <i class="bi bi-fire"></i> 15% OFF SPECIAL
                        </div>

                        <!-- Floating Specs Bar on Card Bottom -->
                        <div class="position-absolute bottom-0 start-0 end-0 m-3 p-2 px-3 rounded-3 bg-black bg-opacity-75 text-white border border-white border-opacity-10 backdrop-blur d-flex justify-content-between align-items-center">
                            <div class="text-start">
                                <div class="fw-bold small text-truncate" style="max-width: 170px;">ProSound Wireless ANC</div>
                                <div class="text-warning small" style="font-size: 0.75rem;">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i> (4.9/5)
                                </div>
                            </div>
                            <div class="text-end">
                                <span class="fs-6 fw-bold text-info">₹12,749.15</span>
                                <span class="text-muted text-decoration-line-through d-block" style="font-size: 0.7rem;">₹14,999.00</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Value Propositions -->
    <div class="row g-3 mb-5 text-center">
        <div class="col-6 col-md-3">
            <div class="p-3 bg-white rounded-4 border shadow-sm h-100 trust-card">
                <i class="bi bi-truck fs-2 text-primary mb-2 d-block"></i>
                <h6 class="fw-bold mb-1">Free Express Delivery</h6>
                <p class="small text-muted mb-0">On all orders over ₹499</p>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="p-3 bg-white rounded-4 border shadow-sm h-100 trust-card">
                <i class="bi bi-shield-check fs-2 text-success mb-2 d-block"></i>
                <h6 class="fw-bold mb-1">Bank-Grade Security</h6>
                <p class="small text-muted mb-0">100% Safe &amp; 256-Bit SSL Encrypted</p>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="p-3 bg-white rounded-4 border shadow-sm h-100 trust-card">
                <i class="bi bi-arrow-repeat fs-2 text-info mb-2 d-block"></i>
                <h6 class="fw-bold mb-1">Instant 30-Day Returns</h6>
                <p class="small text-muted mb-0">Hassle-free money-back policy</p>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="p-3 bg-white rounded-4 border shadow-sm h-100 trust-card">
                <i class="bi bi-headset fs-2 text-warning mb-2 d-block"></i>
                <h6 class="fw-bold mb-1">24/7 VIP Support</h6>
                <p class="small text-muted mb-0">Dedicated assistance anytime</p>
            </div>
        </div>
    </div>

    <!-- Category Showcase Grid (Explore Departments) -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="bi bi-grid-fill text-primary me-2"></i>Explore Departments</h3>
            <p class="text-muted small mb-0">Shop across our 12 curated departments with premium quality guaranteed</p>
        </div>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm rounded-pill px-3">
            View All Categories <i class="bi bi-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row g-3 mb-5">
        <c:forEach var="cat" items="${categories}">
            <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                <a href="${pageContext.request.contextPath}/products?category=${cat.categoryId}" class="dept-tile">
                    <div class="dept-icon-circle bg-primary bg-opacity-10 text-primary">
                        <c:choose>
                            <c:when test="${cat.categoryId == 1}"><i class="bi bi-laptop"></i></c:when>
                            <c:when test="${cat.categoryId == 2}"><i class="bi bi-bag-heart-fill"></i></c:when>
                            <c:when test="${cat.categoryId == 3}"><i class="bi bi-house-heart-fill"></i></c:when>
                            <c:when test="${cat.categoryId == 4}"><i class="bi bi-book-half"></i></c:when>
                            <c:when test="${cat.categoryId == 5}"><i class="bi bi-activity"></i></c:when>
                            <c:when test="${cat.categoryId == 6}"><i class="bi bi-snow"></i></c:when>
                            <c:when test="${cat.categoryId == 7}"><i class="bi bi-stopwatch-fill"></i></c:when>
                            <c:when test="${cat.categoryId == 8}"><i class="bi bi-stars"></i></c:when>
                            <c:when test="${cat.categoryId == 9}"><i class="bi bi-headphones"></i></c:when>
                            <c:when test="${cat.categoryId == 10}"><i class="bi bi-controller"></i></c:when>
                            <c:when test="${cat.categoryId == 11}"><i class="bi bi-camera-fill"></i></c:when>
                            <c:otherwise><i class="bi bi-briefcase-fill"></i></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="fw-bold text-dark small mb-1 dept-title text-center text-truncate w-100" title="${cat.name}">
                        ${cat.name}
                    </div>
                    <span class="badge bg-light text-primary border border-primary border-opacity-10 rounded-pill px-2 py-0.5" style="font-size: 0.68rem;">
                        Shop &rarr;
                    </span>
                </a>
            </div>
        </c:forEach>
    </div>

    <!-- Flash Deals Section -->
    <c:if test="${not empty flashDeals}">
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-5">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div class="d-flex align-items-center gap-3">
                    <span class="badge bg-danger text-white px-3 py-2 rounded-pill fw-bold flash-deal-badge">
                        <i class="bi bi-lightning-charge-fill me-1"></i> FLASH SALE
                    </span>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Super Deals of the Day</h4>
                        <span class="text-muted small">Special limited-time discounts up to 30% off</span>
                    </div>
                </div>
                <div class="d-flex align-items-center gap-2 mt-2 mt-md-0">
                    <span class="small text-muted fw-semibold">Offer ends in:</span>
                    <span class="badge bg-dark text-warning px-3 py-2 rounded-pill font-monospace fw-bold">
                        <i class="bi bi-clock me-1"></i> 08 : 45 : 12
                    </span>
                    <a href="${pageContext.request.contextPath}/products?sort=discount" class="btn btn-outline-danger btn-sm rounded-pill px-3 ms-2">
                        See All Deals
                    </a>
                </div>
            </div>

            <div class="row">
                <c:forEach var="prod" items="${flashDeals}">
                    <tags:productCard product="${prod}" />
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- Promotional Dual Split Banners -->
    <div class="row g-4 mb-5">
        <div class="col-lg-6">
            <div class="promo-split-banner rounded-4 p-4 p-md-5 h-100 shadow-sm d-flex flex-column justify-content-between position-relative overflow-hidden"
                 style="background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 60%, #4338ca 100%) !important; color: #ffffff !important;">
                <div class="position-relative" style="z-index: 2;">
                    <span class="badge bg-info bg-opacity-25 text-info border border-info border-opacity-25 rounded-pill px-3 py-1 fw-bold mb-3 d-inline-block">
                        TECH &amp; AUDIO FEST
                    </span>
                    <h3 class="fw-bold text-white mb-2">Next-Gen Acoustic Performance</h3>
                    <p class="text-light text-opacity-75 small mb-4">
                        Experience lossless wireless audio, studio monitors, and active noise cancellation drivers.
                    </p>
                </div>
                <div class="position-relative" style="z-index: 2;">
                    <a href="${pageContext.request.contextPath}/products?category=1" class="btn btn-primary rounded-pill px-4 fw-bold shadow">
                        Shop Tech Essentials &rarr;
                    </a>
                </div>
                <!-- Aesthetic Background Watermark Icon -->
                <i class="bi bi-headphones position-absolute" style="right: -15px; bottom: -20px; font-size: 140px; color: rgba(255,255,255,0.06); pointer-events: none;"></i>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="promo-split-banner rounded-4 p-4 p-md-5 h-100 shadow-sm d-flex flex-column justify-content-between position-relative overflow-hidden"
                 style="background: linear-gradient(135deg, #4c0519 0%, #881337 50%, #e11d48 100%) !important; color: #ffffff !important;">
                <div class="position-relative" style="z-index: 2;">
                    <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 rounded-pill px-3 py-1 fw-bold mb-3 d-inline-block">
                        STYLE &amp; FOOTWEAR
                    </span>
                    <h3 class="fw-bold text-white mb-2">Urban Modern Footwear &amp; Apparel</h3>
                    <p class="text-light text-opacity-75 small mb-4">
                        Cushioned marathon runners, casual sneakers, and tailored cotton shirts crafted for daily comfort.
                    </p>
                </div>
                <div class="position-relative" style="z-index: 2;">
                    <a href="${pageContext.request.contextPath}/products?category=6" class="btn btn-warning text-dark rounded-pill px-4 fw-bold shadow">
                        Explore Footwear &rarr;
                    </a>
                </div>
                <!-- Aesthetic Background Watermark Icon -->
                <i class="bi bi-fire position-absolute" style="right: -15px; bottom: -20px; font-size: 140px; color: rgba(255,255,255,0.06); pointer-events: none;"></i>
            </div>
        </div>
    </div>

    <!-- Tech & Gadgets Spotlight -->
    <c:if test="${not empty techProducts}">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1"><i class="bi bi-cpu text-primary me-2"></i>Electronics, Gaming &amp; Gadgets</h3>
                <p class="text-muted small mb-0">High-performance laptops, mechanical peripherals, and smart devices</p>
            </div>
            <a href="${pageContext.request.contextPath}/products?category=1" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                View Tech <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>

        <div class="row mb-5">
            <c:forEach var="prod" items="${techProducts}">
                <tags:productCard product="${prod}" />
            </c:forEach>
        </div>
    </c:if>

    <!-- Fashion & Lifestyle Spotlight -->
    <c:if test="${not empty fashionProducts}">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1"><i class="bi bi-gem text-accent me-2"></i>Fashion, Footwear &amp; Luxury</h3>
                <p class="text-muted small mb-0">Trendy wardrobe essentials, automatic watches, and athletic footwear</p>
            </div>
            <a href="${pageContext.request.contextPath}/products?category=2" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                View Fashion <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>

        <div class="row mb-5">
            <c:forEach var="prod" items="${fashionProducts}">
                <tags:productCard product="${prod}" />
            </c:forEach>
        </div>
    </c:if>

    <!-- New Arrivals Section -->
    <c:if test="${not empty newArrivals}">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1"><i class="bi bi-stars text-warning me-2"></i>New Season Arrivals</h3>
                <p class="text-muted small mb-0">Freshly added products to our ever-expanding catalog</p>
            </div>
            <a href="${pageContext.request.contextPath}/products?sort=newest" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                See All New <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>

        <div class="row mb-5">
            <c:forEach var="prod" items="${newArrivals}">
                <tags:productCard product="${prod}" />
            </c:forEach>
        </div>
    </c:if>

    <!-- Complete Featured Essentials Section -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="bi bi-trophy text-primary me-2"></i>Best-Selling Essentials</h3>
            <p class="text-muted small mb-0">Top customer favorites handpicked for unmatched quality and reliability</p>
        </div>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm rounded-pill px-3">
            Browse All Products <i class="bi bi-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row mb-5">
        <c:forEach var="prod" items="${featuredProducts}">
            <tags:productCard product="${prod}" />
        </c:forEach>
    </div>

    <!-- Why Shop With Us Trust Banner -->
    <div class="p-4 p-md-5 rounded-4 shadow-sm mb-5" style="background: linear-gradient(135deg, #ffffff 0%, #f1f5f9 50%, #e0e7ff 100%); border: 1px solid #cbd5e1;">
        <div class="text-center mb-4">
            <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill fw-bold mb-2">
                THE QUICKKART ADVANTAGE
            </span>
            <h3 class="fw-bold">Why Thousands of Shoppers Choose QuickKart</h3>
            <p class="text-muted small">Built with enterprise reliability, high performance, and customer satisfaction at heart.</p>
        </div>
        <div class="row g-4 text-center">
            <div class="col-md-3">
                <i class="bi bi-patch-check-fill fs-1 text-primary mb-2 d-block"></i>
                <h6 class="fw-bold">100% Authentic Products</h6>
                <p class="small text-muted">Directly sourced from verified manufacturers and trusted premium brands.</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-lightning-charge-fill fs-1 text-warning mb-2 d-block"></i>
                <h6 class="fw-bold">Lightning Fast Fulfillment</h6>
                <p class="small text-muted">Automated warehousing with same-day dispatch and live delivery tracking.</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-credit-card-2-front-fill fs-1 text-success mb-2 d-block"></i>
                <h6 class="fw-bold">Zero-Risk Checkout</h6>
                <p class="small text-muted">Supports Credit Cards, Debit Cards, Net Banking, and Cash on Delivery.</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-gift-fill fs-1 text-danger mb-2 d-block"></i>
                <h6 class="fw-bold">Exclusive Member Rewards</h6>
                <p class="small text-muted">Earn reward points, member-only discounts, and seasonal bonus coupons.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/fragments/footer.jsp"/>
