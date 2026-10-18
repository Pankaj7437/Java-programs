package com.quickkart.dao.db;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Automatically initializes tables and default seed data when running in embedded or fresh database mode.
 */
public class DatabaseInitializer {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseInitializer.class);

    public static void initializeIfEmpty(Connection conn) {
        try (Statement stmt = conn.createStatement()) {
            boolean tablesExist = false;
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users")) {
                if (rs.next()) {
                    tablesExist = true;
                }
            } catch (Exception ignored) {
                // Table does not exist
            }

            if (tablesExist) {
                return;
            }

            logger.info("Fresh database detected. Initializing QuickKart schema and default catalog seed data...");

            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "user_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(150) NOT NULL UNIQUE, " +
                    "password VARCHAR(255) NOT NULL, " +
                    "mobile VARCHAR(20), " +
                    "role VARCHAR(20) DEFAULT 'CUSTOMER', " +
                    "status VARCHAR(20) DEFAULT 'ACTIVE', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS addresses (" +
                    "address_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "address_line VARCHAR(255) NOT NULL, " +
                    "city VARCHAR(100) NOT NULL, " +
                    "state VARCHAR(100) NOT NULL, " +
                    "pincode VARCHAR(20) NOT NULL, " +
                    "address_type VARCHAR(20) DEFAULT 'HOME', " +
                    "is_default BOOLEAN DEFAULT FALSE, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS categories (" +
                    "category_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL UNIQUE, " +
                    "slug VARCHAR(120) NOT NULL UNIQUE, " +
                    "description TEXT, " +
                    "image_url VARCHAR(500), " +
                    "status BOOLEAN DEFAULT TRUE, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS products (" +
                    "product_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "category_id INT NOT NULL, " +
                    "name VARCHAR(200) NOT NULL, " +
                    "brand VARCHAR(100) DEFAULT 'Generic', " +
                    "description TEXT, " +
                    "price DECIMAL(10, 2) NOT NULL, " +
                    "discount DECIMAL(5, 2) DEFAULT 0.00, " +
                    "stock INT NOT NULL DEFAULT 0, " +
                    "image_url VARCHAR(500), " +
                    "status BOOLEAN DEFAULT TRUE, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS cart (" +
                    "cart_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "product_id INT NOT NULL, " +
                    "quantity INT NOT NULL DEFAULT 1, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "UNIQUE (user_id, product_id))");

            stmt.execute("CREATE TABLE IF NOT EXISTS wishlist (" +
                    "wishlist_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "product_id INT NOT NULL, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "UNIQUE (user_id, product_id))");

            stmt.execute("CREATE TABLE IF NOT EXISTS orders (" +
                    "order_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "address_id INT NOT NULL, " +
                    "total_amount DECIMAL(10, 2) NOT NULL, " +
                    "discount DECIMAL(10, 2) DEFAULT 0.00, " +
                    "shipping_fee DECIMAL(10, 2) DEFAULT 0.00, " +
                    "final_amount DECIMAL(10, 2) NOT NULL, " +
                    "payment_method VARCHAR(20) DEFAULT 'COD', " +
                    "payment_status VARCHAR(20) DEFAULT 'PENDING', " +
                    "order_status VARCHAR(20) DEFAULT 'CONFIRMED', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS order_items (" +
                    "order_item_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "order_id INT NOT NULL, " +
                    "product_id INT NOT NULL, " +
                    "quantity INT NOT NULL, " +
                    "price DECIMAL(10, 2) NOT NULL, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS payments (" +
                    "payment_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "order_id INT NOT NULL, " +
                    "payment_method VARCHAR(50) NOT NULL, " +
                    "transaction_reference VARCHAR(100) NOT NULL UNIQUE, " +
                    "amount DECIMAL(10, 2) NOT NULL, " +
                    "payment_status VARCHAR(30) DEFAULT 'SUCCESS', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS reviews (" +
                    "review_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "product_id INT NOT NULL, " +
                    "rating INT NOT NULL, " +
                    "review_text TEXT, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS coupons (" +
                    "coupon_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "code VARCHAR(50) NOT NULL UNIQUE, " +
                    "discount_type VARCHAR(20) DEFAULT 'PERCENTAGE', " +
                    "discount_value DECIMAL(10, 2) NOT NULL, " +
                    "minimum_order DECIMAL(10, 2) DEFAULT 0.00, " +
                    "maximum_discount DECIMAL(10, 2), " +
                    "expiry_date TIMESTAMP NOT NULL, " +
                    "status BOOLEAN DEFAULT TRUE, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.execute("CREATE TABLE IF NOT EXISTS coupon_usage (" +
                    "usage_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "coupon_id INT NOT NULL, " +
                    "user_id INT NOT NULL, " +
                    "order_id INT NOT NULL, " +
                    "used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            // Seed Users
            stmt.execute("INSERT INTO users (user_id, name, email, password, mobile, role, status) VALUES " +
                    "(1, 'Administrator', 'admin@quickkart.com', '$2a$12$gzhjxdPAfuh1b3UIN8NQpOcwVy3VNVsVT8AQryz0Vw60l3cSWhkPi', '9876543210', 'ADMIN', 'ACTIVE'), " +
                    "(2, 'John Doe', 'john@example.com', '$2a$12$ZNjkMXfVX8QZ331qPnKOleSlr8YrpbJW7oeSthBokLYqn1CZwxHbO', '9876543211', 'CUSTOMER', 'ACTIVE'), " +
                    "(3, 'Sarah Connor', 'sarah@example.com', '$2a$12$ZNjkMXfVX8QZ331qPnKOleSlr8YrpbJW7oeSthBokLYqn1CZwxHbO', '9876543212', 'CUSTOMER', 'ACTIVE'), " +
                    "(4, 'Administrator', 'admin@shopsphere.com', '$2a$12$gzhjxdPAfuh1b3UIN8NQpOcwVy3VNVsVT8AQryz0Vw60l3cSWhkPi', '9876543210', 'ADMIN', 'ACTIVE')");

            // Seed Addresses
            stmt.execute("INSERT INTO addresses (address_id, user_id, address_line, city, state, pincode, address_type, is_default) VALUES " +
                    "(1, 2, 'Flat 402, Skyline Residency, MG Road', 'Bengaluru', 'Karnataka', '560001', 'HOME', TRUE), " +
                    "(2, 2, 'Tech Park, Tower B, Electronic City', 'Bengaluru', 'Karnataka', '560100', 'WORK', FALSE)");

            // Seed Categories
            stmt.execute("INSERT INTO categories (category_id, name, slug, description, image_url, status) VALUES " +
                    "(1, 'Electronics & Gadgets', 'electronics', 'Smartphones, laptops, headphones, smartwatches and accessories', 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=600', TRUE), " +
                    "(2, 'Fashion & Apparel', 'fashion', 'Trendy men and women clothing, footwear, and designer accessories', 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600', TRUE), " +
                    "(3, 'Home & Living', 'home-kitchen', 'Cookware, modern home decor, bedding, and smart appliances', 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=600', TRUE), " +
                    "(4, 'Books & Media', 'books', 'Bestselling fiction, technical handbooks, journals, and art supplies', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600', TRUE), " +
                    "(5, 'Fitness & Sports', 'sports', 'Gym gear, yoga mats, running footwear, and sports equipment', 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=600', TRUE), " +
                    "(6, 'Footwear & Sneakers', 'footwear', 'Running shoes, casual sneakers, trainers, and slip-on loafers', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600', TRUE), " +
                    "(7, 'Watches & Luxury', 'watches', 'Chronographs, automatic luxury timepieces, and smart bands', 'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=600', TRUE), " +
                    "(8, 'Beauty & Skincare', 'beauty', 'Organic skincare, wellness serums, luxury fragrances, and care kits', 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=600', TRUE), " +
                    "(9, 'Smart Audio & Sound', 'audio', 'Hi-Fi portable speakers, studio monitors, and wireless earbuds', 'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=600', TRUE), " +
                    "(10, 'Gaming & Consoles', 'gaming', 'Mechanical keyboards, esports mice, headsets, and controllers', 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=600', TRUE), " +
                    "(11, 'Cameras & Photography', 'cameras', '4K mirrorless cameras, action cams, vlogging lenses, and tripods', 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600', TRUE), " +
                    "(12, 'Office & Workspace', 'office', 'Ergonomic chairs, standing desk risers, organizers, and productivity accessories', 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600', TRUE)");

            // Seed Products
            stmt.execute("INSERT INTO products (product_id, category_id, name, brand, description, price, discount, stock, image_url, status) VALUES " +
                    "(1, 1, 'ProSound Wireless Noise-Cancelling Headphones', 'AuraAudio', 'Premium over-ear wireless headphones with active noise cancellation, 40-hour battery life, and crystal-clear acoustic drivers.', 14999.00, 15.00, 45, '/assets/img/hero-headphones.jpg', TRUE), " +
                    "(2, 1, 'UltraBook Pro 15.6 Retina Display Laptop', 'ApexTech', 'High-performance laptop featuring 12th Gen Intel Core i7, 16GB LPDDR5 RAM, 1TB NVMe SSD, and 120Hz vivid screen.', 89999.00, 10.00, 20, 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600', TRUE), " +
                    "(3, 1, 'PulseSync Smart Fitness Watch Series 7', 'PulseHealth', 'Advanced health tracking with continuous ECG, SpO2 monitor, GPS tracking, and 7-day battery life in a water-resistant chassis.', 4999.00, 20.00, 60, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', TRUE), " +
                    "(4, 1, 'HyperCharge 65W GaN Multi-Port USB-C Adapter', 'VoltPower', 'Compact fast charger equipped with dual USB-C PD and one USB-A port for simultaneous smartphone and laptop charging.', 2499.00, 10.00, 120, 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=600', TRUE), " +
                    "(5, 2, 'Classic Tailored Oxford Cotton Shirt', 'HeritageCo', '100% combed breathable cotton with button-down collar, slim modern fit, and wrinkle-resistant finish.', 1899.00, 15.00, 85, 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=600', TRUE), " +
                    "(6, 2, 'Everyday Indigo Denim Slim-Fit Jeans', 'BlueDenim', 'Stretch denim crafted with sustainable indigo wash, 5-pocket styling, and reinforced brass rivets.', 2799.00, 10.00, 70, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=600', TRUE), " +
                    "(7, 2, 'Urban Minimalist Hooded Sweatshirt', 'UrbanTrend', 'Plush French terry cotton hoodie with double-layer drawstring hood, kangaroo pouch, and ribbed cuffs.', 2299.00, 15.00, 50, 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=600', TRUE), " +
                    "(8, 3, 'Cast Iron Pre-Seasoned Dutch Oven 6-Quart', 'KitchenCraft', 'Heavy-duty enameled cast iron Dutch oven with tight-fitting lid for braising, baking sourdough bread, and stews.', 4499.00, 15.00, 25, 'https://images.unsplash.com/photo-1585515320310-259814833e62?w=600', TRUE), " +
                    "(9, 3, 'Precision Conical Burr Coffee Grinder', 'BaristaTech', '35 grind settings from French press to fine espresso, featuring digital timer and antistatic stainless burrs.', 6999.00, 10.00, 30, 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=600', TRUE), " +
                    "(10, 4, 'Designing Data-Intensive Applications', 'OReilly', 'The definitive guide to the principles and architectures of distributed data systems by Martin Kleppmann.', 1650.00, 10.00, 50, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=600', TRUE), " +
                    "(11, 4, 'Effective Java 3rd Edition', 'AddisonWesley', 'Essential best practices for the Java platform by Joshua Bloch covering modern idioms and OOP design patterns.', 1490.00, 10.00, 40, 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600', TRUE), " +
                    "(12, 5, 'Non-Slip High Density Eco Yoga Mat 6mm', 'ZenFlex', 'Eco-friendly TPE foam with alignment lines, waterproof texture, and carrying strap for studio workouts.', 1299.00, 10.00, 90, 'https://images.unsplash.com/photo-1592432678016-e910b452f9a2?w=600', TRUE), " +
                    "(13, 5, 'Adjustable Quick-Select Dumbbell Set 5-52.5 lbs', 'IronGym', 'Space-saving selectorized dumbbells replacing 15 sets of weights with ergonomic contoured grips.', 18999.00, 15.00, 8, 'https://images.unsplash.com/photo-1586401100295-7a8096fd231a?w=600', TRUE), " +
                    "(14, 6, 'AeroStride Pro Running Sneakers', 'AeroSport', 'Breathable flyknit mesh upper with high-rebound cushioned midsole for marathon training and daily walking.', 5499.00, 20.00, 45, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600', TRUE), " +
                    "(15, 6, 'Streetwear Low-Top Canvas Sneakers', 'VibeFootwear', 'Vulc construction with durable cotton canvas and gum rubber waffle outsole for effortless urban style.', 2999.00, 15.00, 60, 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600', TRUE), " +
                    "(16, 6, 'CloudAir Cushioned Trail Trainers', 'PeakTrail', 'All-weather traction lugs and responsive cushioning designed for trail exploration and all-day comfort.', 6799.00, 15.00, 35, 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600', TRUE), " +
                    "(17, 7, 'ChronoMaster Sapphire Automatic Watch', 'VanguardHorology', 'Swiss-movement mechanical watch with genuine alligator strap, sapphire crystal glass, and 100m water resistance.', 28500.00, 20.00, 15, 'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=600', TRUE), " +
                    "(18, 7, 'Heritage Minimalist Silver Mesh Watch', 'NordicTime', 'Ultra-thin 38mm stainless steel casing with Milanese mesh strap and sunburst minimalist dial.', 8999.00, 10.00, 28, 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=600', TRUE), " +
                    "(19, 8, 'HydraGlow Organic Botanical Face Serum', 'LuxeBotanics', 'Nourishing facial elixir enriched with hyaluronic acid, cold-pressed jojoba, and Vitamin C for radiant skin.', 1250.00, 10.00, 75, 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=600', TRUE), " +
                    "(20, 9, 'BassBoom 360 Waterproof Bluetooth Speaker', 'SoundWave', 'Rugged outdoor wireless speaker delivering 360-degree stereo sound, IPX7 waterproofing, and 24-hour battery.', 4999.00, 25.00, 55, 'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=600', TRUE), " +
                    "(21, 9, 'AirPod Pro Acoustic Wireless Earbuds', 'AuraAudio', 'Ergonomic in-ear design with adaptive audio transparency, spatial audio tracking, and wireless charging case.', 11999.00, 15.00, 80, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600', TRUE), " +
                    "(22, 10, 'Vortex RGB Hot-Swappable Mechanical Keyboard', 'GamerForge', 'Tactile mechanical switches with per-key RGB backlighting, aircraft aluminum frame, and sound-dampening foam.', 6499.00, 15.00, 40, 'https://images.unsplash.com/photo-1618384887929-16ec33fab9ef?w=600', TRUE), " +
                    "(23, 10, 'ProGrip Wireless Esports Gaming Mouse', 'GamerForge', 'Ultra-lightweight 58g chassis with 26,000 DPI optical sensor, optical switches, and lag-free 2.4GHz wireless.', 3499.00, 15.00, 65, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600', TRUE), " +
                    "(24, 11, 'Lumix 4K Mirrorless Digital Camera Body', 'OptiView', '24.2 MP full-frame sensor, in-body 5-axis image stabilization, 4K 60p video capture, and dual card slots.', 78999.00, 10.00, 12, 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600', TRUE), " +
                    "(25, 12, 'ErgoFit High-Back Breathable Mesh Chair', 'ComfortDesk', 'Ergonomic lumbar support with 3D adjustable armrests, pneumatic height control, and breathable mesh back.', 14499.00, 15.00, 20, 'https://images.unsplash.com/photo-1593062096033-9a26b09da705?w=600', TRUE), " +
                    "(26, 12, 'Solid Walnut Magnetic Desk Organizer & Dock', 'CraftWood', 'Handcrafted American walnut tray with phone stand, cable slots, and precision magnetic storage.', 2199.00, 10.00, 45, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600', TRUE)");

            // Seed Coupons
            stmt.execute("INSERT INTO coupons (coupon_id, code, discount_type, discount_value, minimum_order, maximum_discount, expiry_date, status) VALUES " +
                    "(1, 'WELCOME10', 'PERCENTAGE', 10.00, 999.00, 500.00, '2028-12-31 23:59:59', TRUE), " +
                    "(2, 'FLAT20', 'FIXED', 250.00, 1999.00, 250.00, '2028-12-31 23:59:59', TRUE)");

            // Seed Sample Reviews
            stmt.execute("INSERT INTO reviews (user_id, product_id, rating, review_text) VALUES " +
                    "(2, 1, 5, 'Exceptional noise cancellation and punchy bass. Battery lasts almost an entire work week!'), " +
                    "(3, 1, 4, 'Very comfortable memory foam earcups. Microphone could be slightly clearer on conference calls.'), " +
                    "(2, 2, 5, 'Blazing fast compile times for Java and Docker builds. Screen colors are gorgeous.')");

            // Seed Sample Orders
            stmt.execute("INSERT INTO orders (order_id, user_id, address_id, total_amount, discount, shipping_fee, final_amount, payment_method, payment_status, order_status) VALUES " +
                    "(1001, 2, 1, 14999.00, 1500.00, 0.00, 13499.00, 'CARD', 'PAID', 'DELIVERED')");

            stmt.execute("INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (1001, 1, 1, 14999.00)");
            stmt.execute("INSERT INTO payments (order_id, payment_method, transaction_reference, amount, payment_status) VALUES (1001, 'CARD', 'TXN_CARD_123456', 13499.00, 'SUCCESS')");

            logger.info("Database schema and sample seed data successfully initialized.");
        } catch (Exception e) {
            logger.error("Database initialization warning: {}", e.getMessage(), e);
        }
    }
}
