#!/bin/bash
cd /zap/ || return
if [ -n "$SOOS_PROJECT_NAME" ]; then
    SOOS_PROJECT_NAME="${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}"
fi
PARAMS="--clientId ${SOOS_CLIENT_ID} --apiKey ${SOOS_API_KEY} --projectName ${SOOS_PROJECT_NAME} --scanMode ${SOOS_SCAN_MODE} --apiURL ${SOOS_API_BASE_URL} --integrationName ${SOOS_INTEGRATION_NAME} --commitHash ${CIRCLE_SHA1} --branchName ${CIRCLE_BRANCH}"
if [  "$SOOS_DEBUG" == "true" ]; then
    PARAMS+=" --debug True"
fi
if [  "$SOOS_AJAX_SPIDER" == "true" ]; then
    PARAMS+=" --ajaxSpider True"
fi
if  [ -n "$SOOS_RULES" ]; then
    PARAMS+=" --rules ${SOOS_RULES}"
fi
if  [ -n "$SOOS_CONTEXT_FILE" ]; then
    PARAMS+=" --contextFile ${SOOS_CONTEXT_FILE}"
fi
if  [ -n "$SOOS_CONTEXT_USER" ]; then
    PARAMS+=" --contextUser ${SOOS_CONTEXT_USER}"
fi
if  [ -n "$SOOS_FULL_SCAN_MINUTES" ]; then
    PARAMS+=" --fullScanMinutes ${SOOS_FULL_SCAN_MINUTES}"
fi
if  [ -n "$SOOS_API_SCAN_FORMAT" ]; then
    PARAMS+=" --apiScanFormat ${SOOS_API_SCAN_FORMAT}"
fi
if  [ -n "$SOOS_LEVEL" ]; then
    PARAMS+=" --level ${SOOS_LEVEL}"
fi
if  [ -n "$SOOS_BRANCH_URI" ]; then
    PARAMS+=" --branchUri ${SOOS_BRANCH_URI}"
fi
if  [ -n "$SOOS_BUILD_URI" ]; then
    PARAMS+=" --buildUri ${SOOS_BUILD_URI}"
fi
if  [ -n "$SOOS_BUILD_VERSION" ]; then
    PARAMS+=" --buildVersion ${SOOS_BUILD_VERSION}"
fi
if  [ -n "$SOOS_OPERATING_ENVIRONMENT" ]; then
    PARAMS+=" --operatingEnvironment ${SOOS_OPERATING_ENVIRONMENT}"
fi
if  [ -n "$SOOS_ZAP_OPTIONS" ]; then
    PARAMS+=" --zapOptions ${SOOS_ZAP_OPTIONS}"
fi
if  [ -n "$SOOS_REQUEST_COOKIES" ]; then
    PARAMS+=" --requestCookies ${SOOS_REQUEST_COOKIES}"
fi
if  [ -n "$SOOS_REQUEST_HEADERS" ]; then
    PARAMS+=" --requestHeader ${SOOS_REQUEST_HEADERS}"
fi
if [  "$SOOS_GENERATE_SARIF_REPORT" -eq 1 ]; then
    PARAMS+=" --sarif=True --gpat ${SOOS_GITHUB_PAT}"
fi
set -x
python3 main.py ${SOOS_TARGET_URL} ${PARAMS}
