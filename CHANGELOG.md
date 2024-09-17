# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The changes documented here do not include those from the original repository.

## 5.0.0-OS12

### Features
- Feat: Android | Update dependency to Firebase Dynamic Links Android library (https://outsystemsrd.atlassian.net/browse/RMET-3608).

## 5.0.0-OS11

### Features
- Update `FirebaseDynamicLinks` iOS pod to version `10.23.0`. This includes the Privacy Manifest (https://outsystemsrd.atlassian.net/browse/RMET-3274).

### Fixes
- Update the `com.android.tools.build:gradle` and `com.google.gms:google-services` gradle dependencies (https://outsystemsrd.atlassian.net/browse/RMET-3165).

## [5.0.0-OS10]

### 11-08-2023
- Feat: update firebase core version (https://outsystemsrd.atlassian.net/browse/RMET-2451).

## [5.0.0-OS9]

### 16-12-2022
- Replaced jcenter with more up to date mavenCentral [RMET-2036](https://outsystemsrd.atlassian.net/browse/RMET-2036)

### 2022-11-10
- Use fixed versions (https://outsystemsrd.atlassian.net/browse/RMET-2045).

## [5.0.0-OS8]

## 2022-10-28
- Android 13 changes  [RMET-813](https://outsystemsrd.atlassian.net/browse/RMET-1813)

## [5.0.0-OS7]

## 2022-07-14
- Remove dependency to Firebase Analytics  [RMET-1715](https://outsystemsrd.atlassian.net/browse/RMET-1717)

## [5.0.0-OS6]

## 2022-07-12
- Firebase Analytics dependency tag updated  [RMET-1715](https://outsystemsrd.atlassian.net/browse/RMET-1715)

## [5.0.0-OS5]
## 2022-05-16
- Firebase Analytics dependency tag updated  [RMET-1538](https://outsystemsrd.atlassian.net/browse/RMET-1538)

## [5.0.0-OS4]
## 2022-05-10
- Firebase Analytics dependency tag updated  [RMET-1547](https://outsystemsrd.atlassian.net/browse/RMET-1547)

## [5.0.0-OS3]
## 2022-04-19
- Hook to add google services dependency to build.gradle. [RMET-1497](https://outsystemsrd.atlassian.net/browse/RMET-1497)

## [5.0.0-OS2]

## 2021-11-05
- New plugin release to include metadata tag in Extensibility Configurations in the OS wrapper

## 2021-08-24
- Updated Firebase plugin versions to 8.6.0 on iOS and 20.1.+ on Android RMET-732

## [5.0.0-OS1]

## 2021-07-22
- Firebase Analytics dependency tag updated  [RMET-904](https://outsystemsrd.atlassian.net/browse/RMET-904)

## 2021-07-13
- Migrating package upload to newer Saucelabs API [RMET-761](https://outsystemsrd.atlassian.net/browse/RMET-761)

## [5.0.0-OS]

## 2021-05-20
- chore: Added OS to plugin version in plugin.xml and package.json.

## 2021-05-18
- fix: Changed the dependency to our firebase analytics plugin to use the repository url.

## 2021-05-04
- feat: added pipelines configuration (https://outsystemsrd.atlassian.net/browse/RMET-588)

## 2021-05-03
- fix: changed Android implementation of respondWithDynamicLink to only deal with the same dynamic link once (https://outsystemsrd.atlassian.net/browse/RMET-585)

## 2021-03-26
- feature: added hooks to configure domain uri prefix for dynamic link (iOS and Android) (https://outsystemsrd.atlassian.net/browse/RMET-436) (https://outsystemsrd.atlassian.net/browse/RMET-455)
