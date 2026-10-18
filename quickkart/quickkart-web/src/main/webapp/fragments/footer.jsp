<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="py-5 mt-5 border-top border-secondary border-opacity-10">
    <div class="container">
        <div class="row g-4">
            <div class="col-12 col-md-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <img src="${pageContext.request.contextPath}/assets/img/quickkart-icon.png" alt="QuickKart" height="34" class="rounded-2">
                    <span class="fs-4 fw-bold text-white">QuickKart</span>
                </div>
                <p class="small text-secondary mb-3">
                    Discover premium lifestyle essentials, cutting-edge technology, and modern fashion with lightning-fast delivery and bank-grade checkout security.
                </p>
                <div class="d-flex flex-wrap gap-2">
                    <span class="badge bg-white bg-opacity-10 text-light border border-white border-opacity-10 rounded-pill px-3 py-1.5"><i class="bi bi-shield-check text-success me-1"></i> 100% Authentic</span>
                    <span class="badge bg-white bg-opacity-10 text-light border border-white border-opacity-10 rounded-pill px-3 py-1.5"><i class="bi bi-truck text-primary me-1"></i> Fast Delivery</span>
                    <span class="badge bg-white bg-opacity-10 text-light border border-white border-opacity-10 rounded-pill px-3 py-1.5"><i class="bi bi-arrow-repeat text-info me-1"></i> Easy Returns</span>
                </div>
            </div>

            <div class="col-6 col-md-2">
                <h6 class="text-white fw-bold mb-3">Customer Service</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/orders">Order Tracking</a></li>
                    <li><a href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart">Shopping Cart</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile">My Account</a></li>
                </ul>
            </div>

            <div class="col-6 col-md-3">
                <h6 class="text-white fw-bold mb-3">Popular Categories</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/products?category=1">Electronics &amp; Gadgets</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2">Fashion &amp; Apparel</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=3">Home &amp; Living</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=6">Footwear &amp; Sneakers</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=7">Watches &amp; Luxury</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=10">Gaming &amp; Consoles</a></li>
                </ul>
            </div>

            <div class="col-12 col-md-3">
                <h6 class="text-white fw-bold mb-3">Stay Connected</h6>
                <p class="small text-secondary mb-3">
                    Subscribe to receive exclusive deals, weekly flash sales, and new collection launches directly to your inbox.
                </p>
                <div class="input-group input-group-sm">
                    <input type="email" class="form-control rounded-start-pill bg-dark text-white border-secondary" placeholder="Your email address">
                    <button class="btn btn-primary rounded-end-pill px-3" type="button">Subscribe</button>
                </div>
            </div>
        </div>

        <hr class="border-secondary border-opacity-25 my-4">

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center small text-secondary">
            <div>&copy; 2026 QuickKart Inc. All rights reserved. Premium Shopping Destination.</div>
            <div class="d-flex gap-3 mt-2 mt-md-0">
                <span><i class="bi bi-shield-lock-fill text-success me-1"></i> 256-Bit SSL Secured</span>
                <span><i class="bi bi-credit-card-2-front-fill text-info me-1"></i> Safe Payments</span>
                <span><i class="bi bi-patch-check-fill text-warning me-1"></i> Quality Guaranteed</span>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5.3 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
