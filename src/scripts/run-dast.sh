#!/bin/bash
cd /zap/ || return
SOOS_INTEGRATION_NAME="CircleCI"
SOOS_INTEGRATION_TYPE="Plugin"
if [ -z "$SOOS_PROJECT_NAME" ]; then
    SOOS_PROJECT_NAME="${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}"
fi
PARAMS="--clientId ${!SOOS_CLIENT_ID_VAR_NAME} --apiKey ${!SOOS_API_KEY_VAR_NAME} --projectName ${SOOS_PROJECT_NAME} --scanMode ${SOOS_SCAN_MODE} --onFailure ${SOOS_ON_FAILURE} --apiURL ${SOOS_API_BASE_URL} --integrationName $SOOS_INTEGRATION_NAME --integrationType $SOOS_INTEGRATION_TYPE --commitHash ${CIRCLE_SHA1} --branchName ${CIRCLE_BRANCH}"
if [  "$SOOS_DEBUG" -eq 1 ]; then
    PARAMS+=" --debug True"
fi
if [  "$SOOS_AJAX_SPIDER" -eq 1 ]; then
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
if [  "$SOOS_REPORT_REQUEST_HEADERS" -eq 1 ]; then
    PARAMS+=" --reportRequestHeaders=true"
fi
if [ -n "$SOOS_BEARER_TOKEN" ]; then
    PARAMS+=" --bearerToken ${SOOS_BEARER_TOKEN}"
fi
if [ -n "$SOOS_AUTH_USERNAME" ]; then
    PARAMS+=" --authUsername ${SOOS_AUTH_USERNAME}"
fi
if [ -n "$SOOS_AUTH_PASSWORD" ]; then
    PARAMS+=" --authPassword ${SOOS_AUTH_PASSWORD}"
fi
if [ -n "$SOOS_AUTH_LOGIN_URL" ]; then
    PARAMS+=" --authLoginURL ${SOOS_AUTH_LOGIN_URL}"
fi
if [ -n "$SOOS_AUTH_USERNAME_FIELD" ]; then
    PARAMS+=" --authUsernameField ${SOOS_AUTH_USERNAME_FIELD}"
fi
if [ -n "$SOOS_AUTH_PASSWORD_FIELD" ]; then
    PARAMS+=" --authPasswordField ${SOOS_AUTH_PASSWORD_FIELD}"
fi
if [ -n "$SOOS_AUTH_SUBMIT_FIELD" ]; then
    PARAMS+=" --authSubmitField ${SOOS_AUTH_SUBMIT_FIELD}"
fi
if [ -n "$SOOS_AUTH_SUBMIT_ACTION" ]; then
    PARAMS+=" --authSubmitAction ${SOOS_AUTH_SUBMIT_ACTION}"
fi
if [ -n "$SOOS_OAUTH_TOKEN_URL" ]; then
    PARAMS+=" --oauthTokenUrl ${SOOS_OAUTH_TOKEN_URL}"
fi
if [ -n "$SOOS_OAUTH_PARAMETERS" ]; then
    PARAMS+=" --oauthParameters ${SOOS_OAUTH_PARAMETERS}"
fi
if [  -n "$SOOS_AUTH_SECOND_SUBMIT_FIELD" ]; then
    PARAMS+=" --authSecondSubmitField ${SOOS_AUTH_SECOND_SUBMIT_FIELD}"
fi
if [  -n "$SOOS_AUTH_FORM_TYPE" ]; then
    PARAMS+=" --authFormType ${SOOS_AUTH_FORM_TYPE}"
fi
if [  -n "$SOOS_AUTH_DELAY_TIME" ]; then
    PARAMS+=" --authDelayTime ${SOOS_AUTH_DELAY_TIME}"
fi
python3 main.py ${SOOS_TARGET_URL} ${PARAMS}
