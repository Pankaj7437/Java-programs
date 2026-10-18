# QuickKart Enterprise Platform - Setup & Execution Guide
> Complete Step-by-Step Instructions to Install, Configure, Build, and Run QuickKart on **Windows** and **Linux**

---

## Table of Contents
1. [System Prerequisites & Installation](#1-system-prerequisites--installation)
   - [Windows Installation Guide](#windows-installation-guide)
   - [Linux (Ubuntu / Debian / CentOS) Installation Guide](#linux-ubuntu--debian--centos-installation-guide)
2. [Project Architecture & Deliverables](#2-project-architecture--deliverables)
3. [Database Configuration (Zero-Setup H2 vs. MySQL 8.0)](#3-database-configuration)
4. [Building the Platform](#4-building-the-platform)
5. [Running Every Component](#5-running-every-component)
   - [A. Web Storefront & Customer Portal (Port 8080)](#a-web-storefront--customer-portal-http-port-8080)
   - [B. Modern Swing Desktop Admin Panel](#b-modern-swing-desktop-admin-panel)
   - [C. Java Remote Method Invocation (RMI) Service](#c-java-remote-method-invocation-rmi-service)
   - [D. Java Socket Networking Daemon (java.net)](#d-java-socket-networking-daemon-javanet)
   - [E. Running via Docker & Docker Compose](#e-running-via-docker--docker-compose)
6. [Testing & Verification](#6-testing--verification)
7. [Default Access Credentials & Active Coupons](#7-default-access-credentials--active-coupons)
8. [Troubleshooting & FAQs](#8-troubleshooting--faqs)

---

## 1. System Prerequisites & Installation

To run all modules of QuickKart (Web Application, Swing Desktop Admin, RMI Distributed Service, and Network Daemon), you need:
- **Java Development Kit (JDK 17 or JDK 21 LTS)**
- **Apache Maven 3.9+** (or use the included wrapper `mvnw` / `mvnw.cmd`)
- **Database Engine**:
  - *Default Zero-Config Mode:* **Embedded H2 Database** (requires **NO** database installation; pre-configured and auto-initialized out-of-the-box!)
  - *Optional Production Mode:* **MySQL Server 8.0+**
- **Git**

---

### Windows Installation Guide

#### 1. Install Java Development Kit (JDK 21)
1. Download **Eclipse Temurin JDK 21** or **Oracle JDK 21** for Windows (x64 `.msi` installer) from [Adoptium](https://adoptium.net) or [Oracle](https://www.oracle.com/java/technologies/downloads/).
2. Run the installer and check the options to **"Set JAVA_HOME variable"** and **"Add to PATH"**.
3. Verify in Command Prompt (`cmd.exe`) or PowerShell:
   ```cmd
   java -version
   javac -version
   echo %JAVA_HOME%
   ```

#### 2. Install Apache Maven (Optional if using included `mvnw.cmd`)
1. Download Maven binary zip from [maven.apache.org](https://maven.apache.org/download.cgi).
2. Extract to `C:\Program Files\apache-maven-3.9.9`.
3. Add `C:\Program Files\apache-maven-3.9.9\bin` to your System `PATH` environment variable.
4. Verify:
   ```cmd
   mvn -version
   ```

#### 3. Install Git for Windows
1. Download and install Git from [git-scm.com](https://git-scm.com/download/win).
2. Choose default options (enables Git Bash and command-line git).

#### 4. (Optional) Install MySQL 8.0 Server
> **Note:** If you want zero-installation setup, you can skip MySQL! QuickKart automatically initializes an embedded H2 database with all 26 catalog items and users pre-seeded.
If you prefer MySQL:
1. Download **MySQL Community Server 8.0** installer from [dev.mysql.com](https://dev.mysql.com/downloads/installer/).
2. Run the MySQL installer, select Developer Default or Server Only, and set a root password (e.g., `rootpassword`).

#### 5. (Optional) Install Apache Tomcat 10.1 (Jakarta EE 10)
1. Download **Tomcat 10.1.x** core 64-bit Windows zip from [tomcat.apache.org](https://tomcat.apache.org/download-10.cgi).
2. Extract to `C:\apache-tomcat-10.1`.
3. Set environment variable `CATALINA_HOME=C:\apache-tomcat-10.1`.

---

### Linux (Ubuntu / Debian / CentOS) Installation Guide

#### On Ubuntu / Debian:
```bash
# 1. Update package index
sudo apt update

# 2. Install OpenJDK 21, Maven, Git, and cURL
sudo apt install -y openjdk-21-jdk maven git curl

# 3. Verify Java & Maven
java -version
mvn -version

# 4. Set JAVA_HOME in ~/.bashrc (if not automatically set)
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
source ~/.bashrc

# 5. (Optional) Install MySQL Server 8.0
sudo apt install -y mysql-server
sudo systemctl enable --now mysql
```

#### On CentOS / RHEL / Fedora:
```bash
sudo dnf install -y java-21-openjdk-devel maven git curl
```

---

## 2. Project Architecture & Deliverables

QuickKart is structured as an enterprise Maven multi-module reactor containing 7 isolated modules:

```
quickkart/
├── pom.xml                         # Root Reactor Parent POM
├── mvnw & mvnw.cmd                 # Linux & Windows Maven Wrappers
├── run-web.sh / run-web.bat        # Storefront Launcher
├── stop-web.sh / stop-web.bat      # Storefront Stopper
├── run-swing-admin.sh / .bat       # Desktop Swing Admin Launcher
├── run-rmi-test.sh / .bat          # Java RMI Distributed Service Launcher
├── run-network-test.sh / .bat      # Java Socket Network Daemon Launcher
├── run-tests.sh / .bat             # Integration & Unit Test Runner
├── database/
│   ├── quickkart.sql              # MySQL 8.0 Relational DDL & Seed Data
│   └── update_prices.sql          # Realistic INR Pricing Update Script
├── docker/
│   ├── Dockerfile.web             # Multi-stage container build (Temurin 21 + Tomcat 10.1)
│   ├── docker-compose.yml         # Full stack orchestrator (App + MySQL + Nginx)
│   └── nginx/default.conf         # Production Reverse Proxy with Gzip & SSL
├── docs/
│   ├── azure_vm_deployment_guide.md # Azure Linux VM Cloud Rollout Guide
│   └── rtu_viva_preparation_guide.md# Examination & Viva Preparation Guide
├── quickkart-common/               # Shared POJOs, Serializable models, BCrypt security
├── quickkart-dao/                  # HikariCP connection pool, DAOs, and service layer
├── quickkart-web/                  # Jakarta EE 10 Web Application (WAR)
├── quickkart-swing-admin/          # Desktop Admin Panel (FlatLaf Modern Look & Feel)
├── quickkart-network/              # java.net Socket/ServerSocket client-server daemon
└── quickkart-rmi/                  # Java RMI remote inventory & pricing service
```

---

## 3. Database Configuration

QuickKart supports two database operating modes:

### Mode A: Zero-Config Embedded Database (Default & Recommended for Local Testing)
- **No external server required.**
- When no external MySQL server is detected, QuickKart automatically boots an embedded, persistent H2 database in MySQL compatibility mode (`MODE=MySQL`).
- Tables, constraints, foreign keys, and 26 seed products across 12 departments are initialized automatically on first boot.
- Stored locally at `~/.quickkart/h2_quickkart.mv.db` (Linux) or `%USERPROFILE%\.quickkart\h2_quickkart.mv.db` (Windows).

### Mode B: MySQL 8.0 Production Database
1. Open MySQL command line client or Workbench:
   ```bash
   mysql -u root -p < database/quickkart.sql
   ```
2. Configure credentials via environment variables:
   - **Linux / macOS:**
     ```bash
     export DB_HOST=localhost
     export DB_PORT=3306
     export DB_NAME=quickkart
     export DB_USER=root
     export DB_PASSWORD=your_password
     ```
   - **Windows (Command Prompt):**
     ```cmd
     set DB_HOST=localhost
     set DB_PORT=3306
     set DB_NAME=quickkart
     set DB_USER=root
     set DB_PASSWORD=your_password
     ```

---

## 4. Building the Platform

Open a terminal or command prompt in the `quickkart` root folder:

### On Windows:
```cmd
mvn clean package -DskipTests
```
*(Or use `mvnw.cmd clean package -DskipTests`)*

### On Linux / macOS:
```bash
./mvnw clean package -DskipTests
```

**Build Output:**
- All 7 modules compile successfully.
- Web Application WAR generated at: `quickkart-web/target/quickkart-web.war`.
- Standalone JARs generated in each module's `target/` directory.

---

## 5. Running Every Component

### A. Web Storefront & Customer Portal (HTTP Port 8080)

#### Method 1: Using Standalone Apache Tomcat 10.1 (Direct Deployment)
1. Copy `quickkart-web/target/quickkart-web.war` into Tomcat's `webapps/` folder as `ROOT.war` (or `quickkart.war`).
2. Start Tomcat:
   - **Windows:**
     ```cmd
     %CATALINA_HOME%\bin\startup.bat
     ```
     *(Or double-click `run-web.bat`)*
   - **Linux:**
     ```bash
     ./run-web.sh
     ```
3. Open your browser and navigate to:
   - Storefront Home: **http://localhost:8080/**
   - Product Catalog: **http://localhost:8080/products**
   - Flagship Studio Headphones: **http://localhost:8080/product-details?id=1**
   - Shopping Cart: **http://localhost:8080/cart**
   - Admin Web Dashboard: **http://localhost:8080/admin/dashboard**

#### Method 2: Stopping Tomcat
- **Windows:** `%CATALINA_HOME%\bin\shutdown.bat` or `stop-web.bat`
- **Linux:** `./stop-web.sh`

---

### B. Modern Swing Desktop Admin Panel

The Swing Admin Application features a modern FlatLaf Light Look & Feel with font anti-aliasing, rounded input fields, real-time table search filtering, formatted currency (`₹`), low-stock indicators, and product management dialogs.

#### On Windows:
Double-click `run-swing-admin.bat` or run:
```cmd
mvn exec:java -pl quickkart-swing-admin -Dexec.mainClass="com.quickkart.swing.MainSwingAdmin"
```

#### On Linux:
Run the launch script or click the desktop shortcut:
```bash
./run-swing-admin.sh
```
*(If on Linux Desktop, you can also launch using `QuickKart-Admin.desktop`)*

**Admin Login Credentials:**
- Email: `admin@quickkart.com`
- Password: `Admin@123`

---

### C. Java Remote Method Invocation (RMI) Service

Demonstrates distributed enterprise object computing over Java RMI on port 1099.

#### On Windows:
Run the batch test runner:
```cmd
run-rmi-test.bat
```
*Or run manually:*
1. Terminal 1 (Start RMI Registry & Server):
   ```cmd
   mvn exec:java -pl quickkart-rmi -Dexec.mainClass="com.quickkart.rmi.server.RmiServerLauncher"
   ```
2. Terminal 2 (Run RMI Client Verification):
   ```cmd
   mvn exec:java -pl quickkart-rmi -Dexec.mainClass="com.quickkart.rmi.client.RmiClientTest"
   ```

#### On Linux:
```bash
./run-rmi-test.sh
```

---

### D. Java Socket Networking Daemon (`java.net`)

Demonstrates low-level TCP/IP client-server communication using `java.net.ServerSocket` and `java.net.Socket` transferring serialized Java objects on port 9090.

#### On Windows:
Run the batch test runner:
```cmd
run-network-test.bat
```
*Or run manually:*
1. Terminal 1 (Start Inventory Socket Server):
   ```cmd
   mvn exec:java -pl quickkart-network -Dexec.mainClass="com.quickkart.network.server.InventoryServer"
   ```
2. Terminal 2 (Run Inventory Socket Client):
   ```cmd
   mvn exec:java -pl quickkart-network -Dexec.mainClass="com.quickkart.network.client.InventoryClient"
   ```

#### On Linux:
```bash
./run-network-test.sh
```

---

### E. Running via Docker & Docker Compose

For containerized cloud deployment with automated multi-container orchestration:

1. Ensure Docker Desktop (Windows) or Docker Engine (Linux) is running.
2. From the project root:
   ```bash
   docker compose -f docker/docker-compose.yml up --build -d
   ```
3. View container health:
   ```bash
   docker compose -f docker/docker-compose.yml ps
   ```
4. Access the application at: `http://localhost:8080/`
5. Stop the containers:
   ```bash
   docker compose -f docker/docker-compose.yml down
   ```

---

## 6. Testing & Verification

### Run Automated Unit Tests (Surefire):
```bash
# Windows
mvn test

# Linux
./mvnw test
```

### Run End-to-End Integration Suite:
On Linux, execute the automated 5-suite verification harness:
```bash
./run-tests.sh
```
This tests:
1. Storefront & Product Catalog (`GET /`, `GET /product-details?id=1`)
2. Customer Authentication & BCrypt verification (`POST /login`, `GET /profile`)
3. Shopping Cart & Discount Calculations (`POST /cart`)
4. Role-Based Access Control (`AdminFilter` 403 enforcement & Admin Dashboard)
5. Academic Syllabus Demonstrations (Hindi i18n ResourceBundle, JSTL XML transform, JSTL SQL)

---

## 7. Default Access Credentials & Active Coupons

### User Accounts:
| Role | Email | Password | Access Level |
| :--- | :--- | :--- | :--- |
| **System Administrator** | `admin@quickkart.com` | `Admin@123` | Full Admin Dashboard, Product CRUD, Orders Management |
| **Verified Customer** | `customer@quickkart.com` | `Customer@123` | Storefront Shopping, Cart, Reviews, Wishlist, Order History |

*(New customer accounts can also be freely registered via `/register`)*

### Promotional Discount Coupons:
| Coupon Code | Discount | Minimum Order | Details |
| :--- | :--- | :--- | :--- |
| **`WELCOME10`** | **10% OFF** | ₹999.00 | First purchase special discount (Max ₹500 discount) |
| **`FLAT20`** | **₹250 OFF** | ₹1,999.00 | Flat discount on mid-tier cart values |
| **`FESTIVE50`** | **₹500 OFF** | ₹4,999.00 | Mega festive discount on premium orders |

*Shipping is **FREE** for all orders above ₹499 (otherwise flat ₹49 fee).*

---

## 8. Troubleshooting & FAQs

### Q1: Port 8080 is already in use
- **Windows:** Find and kill the process:
  ```cmd
  netstat -ano | findstr :8080
  taskkill /PID <PID_NUMBER> /F
  ```
- **Linux:**
  ```bash
  sudo fuser -k 8080/tcp
  ```

### Q2: Java version error (`UnsupportedClassVersionError`)
- Ensure you are running with **Java 17 or Java 21**:
  ```bash
  java -version
  ```
- Update your `JAVA_HOME` environment variable to point to JDK 17 or JDK 21.

### Q3: On Linux, scripts return `Permission denied`
- Add execution permissions:
  ```bash
  chmod +x *.sh mvnw
  ```

### Q4: Can I run without internet?
- Yes! All fonts, Bootstrap CSS, Bootstrap Icons, and images are cached and have local fallbacks. The embedded database runs entirely locally without any network access needed.
