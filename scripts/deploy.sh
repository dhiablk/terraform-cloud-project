#!/usr/bin/env bash
# Helper: init/plan/apply/destroy for one environment.
# Usage: ./scripts/deploy.sh <dev|test|prod> <init|plan|apply|destroy>
set -euo pipefail

ENVIRONMENT="${1:?usage: deploy.sh <dev|test|prod> <init|plan|apply|destroy>}"
ACTION="${2:?usage: deploy.sh <dev|test|prod> <init|plan|apply|destroy>}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/environments/$ENVIRONMENT"

case "$ACTION" in
  init)    terraform init -input=false ;;
  plan)    terraform plan -input=false -out=tfplan ;;
  apply)   terraform apply -input=false tfplan ;;
  destroy) terraform destroy -input=false ;;
  *) echo "unknown action: $ACTION (init|plan|apply|destroy)"; exit 1 ;;
esac
