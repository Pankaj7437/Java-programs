#!/usr/bin/env bash
# ==============================================================================
# QuickKart - Launch Desktop Swing Admin Application
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$JAVA_HOME" ]; then
    if [ -d "/home/devops-user/tools/jdk-21.0.12.1+1" ]; then
        export JAVA_HOME="/home/devops-user/tools/jdk-21.0.12.1+1"
    fi
fi

if [ -n "$JAVA_HOME" ]; then
    export PATH="$JAVA_HOME/bin:$PATH"
fi

if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

echo "=================================================================="
echo "  Starting QuickKart Desktop Swing Admin Application..."
echo "  DISPLAY: $DISPLAY"
echo "=================================================================="

# Check if direct classpath launcher is available
M2_REPO="${HOME}/.m2/repository"
SWING_CP="$SCRIPT_DIR/quickkart-swing-admin/target/classes:$SCRIPT_DIR/quickkart-dao/target/classes:$SCRIPT_DIR/quickkart-common/target/classes:$M2_REPO/com/formdev/flatlaf/3.4.1/flatlaf-3.4.1.jar:$M2_REPO/com/h2database/h2/2.2.224/h2-2.2.224.jar:$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar:$M2_REPO/org/slf4j/slf4j-api/2.0.12/slf4j-api-2.0.12.jar:$M2_REPO/ch/qos/logback/logback-classic/1.5.3/logback-classic-1.5.3.jar:$M2_REPO/ch/qos/logback/logback-core/1.5.3/logback-core-1.5.3.jar:$M2_REPO/org/mindrot/jbcrypt/0.4/jbcrypt-0.4.jar"

if [ -f "$M2_REPO/com/formdev/flatlaf/3.4.1/flatlaf-3.4.1.jar" ]; then
    exec java -cp "$SWING_CP" com.quickkart.swing.MainSwingAdmin
else
    # Fallback to Maven exec
    exec "$SCRIPT_DIR/mvnw" exec:java -pl quickkart-swing-admin -Dexec.mainClass="com.quickkart.swing.MainSwingAdmin"
fi
