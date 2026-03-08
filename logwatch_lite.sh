#!/usr/bin/env bash

# ==========================================================
# Logwatch Lite
# Author: Ushan Perera
# Description:
# Lightweight Linux log analysis helper for sysadmins
# ==========================================================

set -euo pipefail

MODE="${1:-summary}"
LOG_FILE="${2:-}"
LINES="${3:-50}"

line() {
    printf '%*s\n' "${COLUMNS:-70}" '' | tr ' ' '='
}

section() {
    echo
    line
    echo "$1"
    line
}

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

usage() {
    cat <<EOF
Usage:
  $0 summary <log_file> [lines]
  $0 errors <log_file> [lines]
  $0 warnings <log_file> [lines]
  $0 auth-fail <log_file> [lines]
  $0 ssh <log_file> [lines]
  $0 tail <log_file> [lines]

Examples:
  $0 summary /var/log/syslog 100
  $0 errors /var/log/messages 50
  $0 auth-fail /var/log/auth.log 30
  $0 ssh /var/log/secure 40
EOF
}

require_log_file() {
    if [[ -z "$LOG_FILE" ]]; then
        echo "Log file path is required."
        usage
        exit 1
    fi

    if [[ ! -f "$LOG_FILE" ]]; then
        echo "Log file not found: $LOG_FILE"
        exit 1
    fi
}

show_summary() {
    section "LOG SUMMARY"
    log "Log file : $LOG_FILE"
    log "Lines    : $LINES"

    echo "Total lines:"
    wc -l "$LOG_FILE"

    echo
    echo "Recent entries:"
    tail -n "$LINES" "$LOG_FILE"
}

show_errors() {
    section "ERROR ENTRIES"
    grep -i "error" "$LOG_FILE" | tail -n "$LINES" || echo "No error entries found."
}

show_warnings() {
    section "WARNING ENTRIES"
    grep -i "warn" "$LOG_FILE" | tail -n "$LINES" || echo "No warning entries found."
}

show_auth_failures() {
    section "AUTHENTICATION FAILURES"
    grep -Ei "failed password|authentication failure|invalid user" "$LOG_FILE" | tail -n "$LINES" || echo "No authentication failures found."
}

show_ssh_activity() {
    section "SSH RELATED ENTRIES"
    grep -Ei "sshd|ssh" "$LOG_FILE" | tail -n "$LINES" || echo "No SSH-related entries found."
}

show_tail() {
    section "RAW LOG TAIL"
    tail -n "$LINES" "$LOG_FILE"
}

main() {
    case "$MODE" in
        summary)
            require_log_file
            show_summary
            ;;
        errors)
            require_log_file
            show_errors
            ;;
        warnings)
            require_log_file
            show_warnings
            ;;
        auth-fail)
            require_log_file
            show_auth_failures
            ;;
        ssh)
            require_log_file
            show_ssh_activity
            ;;
        tail)
            require_log_file
            show_tail
            ;;
        *)
            echo "Invalid mode: $MODE"
            usage
            exit 1
            ;;
    esac
}

main "$@"
