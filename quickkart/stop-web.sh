#!/usr/bin/env bash
# ==============================================================================
# QuickKart - Stop Web Application
# ==============================================================================
TOMCAT_DIR="/home/devops-user/tools/apache-tomcat-10.1.20"
JDK_DIR="/home/devops-user/tools/jdk-21.0.12.1+1"

export JAVA_HOME="$JDK_DIR"
export PATH="$JAVA_HOME/bin:$PATH"

echo "Stopping QuickKart Tomcat Server..."
"$TOMCAT_DIR/bin/shutdown.sh" 2>/dev/null || true
pkill -9 -f "catalina" 2>/dev/null || true
echo "QuickKart Web Server stopped."
