#!/usr/bin/env bash
# ==============================================================================
# QuickKart - Start Web Application (Apache Tomcat 10.1 + Jakarta EE 10)
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOMCAT_DIR="/home/devops-user/tools/apache-tomcat-10.1.20"
JDK_DIR="/home/devops-user/tools/jdk-21.0.12.1+1"

export JAVA_HOME="$JDK_DIR"
export PATH="$JAVA_HOME/bin:$PATH"

if curl -s -I http://localhost:8080/ > /dev/null 2>&1; then
    echo "=================================================================="
    echo "  QuickKart Web Application is ALREADY RUNNING!"
    echo "  Open in your web browser: http://localhost:8080/"
    echo "=================================================================="
    exit 0
fi

echo "Starting QuickKart Web Application on Tomcat 10.1..."
"$TOMCAT_DIR/bin/startup.sh"

echo "Waiting for server to initialize..."
for i in {1..15}; do
    if curl -s -I http://localhost:8080/ > /dev/null 2>&1; then
        echo ""
        echo "=================================================================="
        echo "  🎉 QuickKart is LIVE at: http://localhost:8080/"
        echo "=================================================================="
        exit 0
    fi
    sleep 1
done

echo "Server started. Logs available at: $TOMCAT_DIR/logs/catalina.out"
