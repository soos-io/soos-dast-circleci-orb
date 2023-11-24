#!/bin/bash
cd /zap/ || return

SOOS_INTEGRATION_NAME="CircleCI"
SOOS_INTEGRATION_TYPE="Plugin"

if [ -z "$SOOS_PROJECT_NAME" ]; then
    SOOS_PROJECT_NAME="${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}"
fi

PARAMS=(
    "--clientId" "${!SOOS_CLIENT_ID_VAR_NAME}"
    "--apiKey" "${!SOOS_API_KEY_VAR_NAME}"
    "--projectName" "${SOOS_PROJECT_NAME}"
    "--scanMode" "${SOOS_SCAN_MODE}"
    "--onFailure" "${SOOS_ON_FAILURE}"
    "--apiURL" "${SOOS_API_BASE_URL}"
    "--integrationName" "$SOOS_INTEGRATION_NAME"
    "--integrationType" "$SOOS_INTEGRATION_TYPE"
    "--commitHash" "${CIRCLE_SHA1}"
    "--branchName" "${CIRCLE_BRANCH}"
)

# Add optional parameters only if they are set and non-empty
[ "${SOOS_DEBUG}" ] && PARAMS+=("--debug")
[ "${SOOS_AJAX_SPIDER}" ] && PARAMS+=("--ajaxSpider")
[ -n "${SOOS_RULES}" ] && PARAMS+=("--rules" "${SOOS_RULES}")
[ -n "${SOOS_CONTEXT_FILE}" ] && PARAMS+=("--contextFile" "${SOOS_CONTEXT_FILE}")
[ -n "${SOOS_FULL_SCAN_MINUTES}" ] && PARAMS+=("--fullScanMinutes" "${SOOS_FULL_SCAN_MINUTES}")
[ -n "${SOOS_API_SCAN_FORMAT}" ] && PARAMS+=("--apiScanFormat" "${SOOS_API_SCAN_FORMAT}")
[ -n "${SOOS_LOG_LEVEL}" ] && PARAMS+=("--logLevel" "${SOOS_LOG_LEVEL}")
[ -n "${SOOS_BRANCH_URI}" ] && PARAMS+=("--branchUri" "${SOOS_BRANCH_URI}")
[ -n "${SOOS_BUILD_URI}" ] && PARAMS+=("--buildUri" "${SOOS_BUILD_URI}")
[ -n "${SOOS_BUILD_VERSION}" ] && PARAMS+=("--buildVersion" "${SOOS_BUILD_VERSION}")
[ -n "${SOOS_OPERATING_ENVIRONMENT}" ] && PARAMS+=("--operatingEnvironment" "${SOOS_OPERATING_ENVIRONMENT}")
[ -n "${SOOS_ZAP_OPTIONS}" ] && PARAMS+=("--zapOptions" "${SOOS_ZAP_OPTIONS}")
[ -n "${SOOS_REQUEST_COOKIES}" ] && PARAMS+=("--requestCookies" "${SOOS_REQUEST_COOKIES}")
[ -n "${SOOS_REQUEST_HEADERS}" ] && PARAMS+=("--requestHeaders" "${SOOS_REQUEST_HEADERS}")
[ -n "${SOOS_BEARER_TOKEN}" ] && PARAMS+=("--bearerToken" "${SOOS_BEARER_TOKEN}")
[ -n "${SOOS_AUTH_USERNAME}" ] && PARAMS+=("--authUsername" "${SOOS_AUTH_USERNAME}")
[ -n "${SOOS_AUTH_PASSWORD}" ] && PARAMS+=("--authPassword" "${SOOS_AUTH_PASSWORD}")
[ -n "${SOOS_AUTH_LOGIN_URL}" ] && PARAMS+=("--authLoginURL" "${SOOS_AUTH_LOGIN_URL}")
[ -n "${SOOS_AUTH_USERNAME_FIELD}" ] && PARAMS+=("--authUsernameField" "${SOOS_AUTH_USERNAME_FIELD}")
[ -n "${SOOS_AUTH_PASSWORD_FIELD}" ] && PARAMS+=("--authPasswordField" "${SOOS_AUTH_PASSWORD_FIELD}")
[ -n "${SOOS_AUTH_SUBMIT_FIELD}" ] && PARAMS+=("--authSubmitField" "${SOOS_AUTH_SUBMIT_FIELD}")
[ -n "${SOOS_AUTH_SUBMIT_ACTION}" ] && PARAMS+=("--authSubmitAction" "${SOOS_AUTH_SUBMIT_ACTION}")
[ -n "${SOOS_OAUTH_TOKEN_URL}" ] && PARAMS+=("--oauthTokenUrl" "${SOOS_OAUTH_TOKEN_URL}")
[ -n "${SOOS_OAUTH_PARAMETERS}" ] && PARAMS+=("--oauthParameters" "${SOOS_OAUTH_PARAMETERS}")
[ -n "${SOOS_AUTH_SECOND_SUBMIT_FIELD}" ] && PARAMS+=("--authSecondSubmitField" "${SOOS_AUTH_SECOND_SUBMIT_FIELD}")
[ -n "${SOOS_AUTH_FORM_TYPE}" ] && PARAMS+=("--authFormType" "${SOOS_AUTH_FORM_TYPE}")
[ -n "${SOOS_AUTH_DELAY_TIME}" ] && PARAMS+=("--authDelayTime" "${SOOS_AUTH_DELAY_TIME}")
[ -n "${SOOS_DISABLE_RULES}" ] && PARAMS+=("--disableRules" "${SOOS_DISABLE_RULES}")
[ -n "${SOOS_AUTH_VERIFICATION_URL}" ] && PARAMS+=("--authVerificationURL" "${SOOS_AUTH_VERIFICATION_URL}")
[ -n "${SOOS_OTHER_OPTIONS}" ] && PARAMS+=("--otherOptions" "${SOOS_OTHER_OPTIONS}")
[ "${SOOS_VERBOSE}" ] && PARAMS+=("--verbose")

set -x
node dist/index.js "${SOOS_TARGET_URL}" "${PARAMS[@]}"