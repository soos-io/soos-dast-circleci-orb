# SOOS DAST Analysis CircleCI

The SOOS DAST Analysis for CircleCI implements the SOOS DAST Analysis's integration for CircleCI.

## How to Use

Currently, you can integrate the SOOS DAST Analysis with CircleCI using the [SOOS DAST Analysis CircleCI Orb](https://circleci.com/developer/orbs/orb/soos-io/dast) in your workflow file. 

### Parameters
| Name              | Required                    | Description                                                                                          |
|-------------------|-----------------------------|------------------------------------------------------------------------------------------------------|
| `client_id`       | Yes                         | SOOS client id                                                                                       |
| `api_key`         | Yes                         | SOOS API key                                                                                         |
| `project_name`    | Yes                         | SOOS project name                                                                                    |
| `api_url`         | Yes                         | SOOS API URL. By Default: `https://api.soos.io/api/`                                                 |
| `on_failure`      |                             | Action to perform when the scan fails. Values available: fail_the_build, continue_on_failure (Default) |
| `debug`           |                             | show debug messages                                                                                  |
| `ajax_spider`     |                             | use the Ajax spider in addition to the traditional one                                               |
| `rules`           |                             | rules file to use for `INFO`, `IGNORE` or `FAIL` warnings                                            |
| `context_file`    |                             | context file which will be loaded prior to scanning the target. Required for authenticated URLs      |
| `context_user`    |                             | username to use for authenticated scans - must be defined in the given context file                  |
| `scan_mode`       |                             | SOOS DAST scan mode. Values available: baseline (Default), fullscan, and apiscan                     |
| `fullscan_minutes`| Required by `Full Analysis` | the number of minutes for spider to run                                                              |
| `apiscan_format`  | Required by `API Analysis`  | target API format: `openapi`, `soap`, or `graphql`                                                   |
| `level`           |                             | minimum level to show: `DEBUG`, `INFO`, `WARN`, `ERROR`, `CRITICAL`                                  |
| `target_url`      | Yes                         | target URL including the protocol, eg https://www.example.com                                        |


### Jobs
There's currently one main Job called dast-analysis which you can cofigure to perform a scan in three diferent ways:
- [Baseline Analysis](#baseline-analysis)
- [Full Analysis](#full-analysis)
- [API Analysis](#api-analysis)

#### Baseline Analysis
It runs the [ZAP](https://www.zaproxy.org/) spider against the specified target for (by default) 1 minute and then waits for the passive scanning to complete before reporting the results.

This means that the script doesn't perform any actual ‘attacks’ and will run for a relatively short period of time (a few minutes at most).

By default, it reports all alerts as WARNings but you can specify a config file which can change any rules to `FAIL` or `IGNORE`.

This mode is intended to be ideal to run in a `CI/CD` environment, even against production sites.

**Example**:
``` yaml
version: 2.1

orbs:
  soos: soos-io/dast@x.y.z
  
jobs:
  build:
    steps:
      - checkout
      # ... steps for building/testing app ...
      - soos/dast-analysis:
          client_id: $SOOS_CLIENT_ID
          api_key: $SOOS_API_KEY
          project_name: '...'
          scan_mode: 'baseline'
          debug: true
          ajax_spider: true
          api_base_url: 'https://api.soos-io/api/'
          rules: '...'
          context_file: '...'
          context_user: '...'
          fullscan_minutes: '...'
          apiscan_format: '...'
          level: '...'
          target_url: '...'
```

#### Full Analysis
It runs the [ZAP](https://www.zaproxy.org/) spider against the specified target (by default with no time limit) followed by an optional ajax spider scan and then a full active scan before reporting the results.

This means that the script does perform actual ‘attacks’ and can potentially run for a long period of time.

By default, it reports all alerts as WARNings but you can specify a config file which can change any rules to FAIL or IGNORE. The configuration works in a very similar way as the [Baseline Analysis](#baseline-analysis)

**Example**:
``` yaml
version: 2.1

orbs:
  soos: soos-io/dast@x.y.z
  
jobs:
  build:
    steps:
      - checkout
      # ... steps for building/testing app ...
      - soos/dast-analysis:
          client_id: $SOOS_CLIENT_ID
          api_key: $SOOS_API_KEY
          project_name: '...'
          scan_mode: 'fullscan'
          debug: true
          ajax_spider: true
          api_base_url: 'https://api.soos-io/api/'
          rules: '...'
          context_file: '...'
          context_user: '...'
          fullscan_minutes: '...'
          level: '...'
          target_url: '...'
```

#### API Analysis
It is tuned for performing scans against APIs defined by `OpenAPI`, `SOAP`, or `GraphQL` via either a local file or a URL.

It imports the definition that you specify and then runs an `Active Scan` against the URLs found. The `Active Scan` is tuned to APIs, so it doesn't bother looking for things like `XSSs`.

It also includes 2 scripts that:
- Raise alerts for any HTTP Server Error response codes
- Raise alerts for any URLs that return content types that are not usually associated with APIs

**Example**:
``` yaml
version: 2.1

orbs:
  soos: soos-io/dast@x.y.z
  
jobs:
  build:
    steps:
      - checkout
      # ... steps for building/testing app ...
      - soos/dast-analysis:
          client_id: $SOOS_CLIENT_ID
          api_key: $SOOS_API_KEY
          scan_mode: 'apiscan'
          project_name: '...'
          debug: true
          ajax_spider: true
          api_base_url: 'https://api.soos-io/api/'
          rules: '...'
          context_file: '...'
          context_user: '...'
          apiscan_format: 'openapi'
          level: '...'
          target_url: '...'
```

## References
 - [ZAP](https://www.zaproxy.org/)


### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info soos-io/dast | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/soos-io/soos-dast-circleci-orb/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.
