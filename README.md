# FoundationDB (pre)release Builder [![Build branches](https://github.com/PierreZ/fdb-release-builder/actions/workflows/fdb-release.yml/badge.svg)](https://github.com/PierreZ/fdb-release-builder/actions/workflows/fdb-release.yml)

This Github action is creating **pre-release** version of FoundationDB. This releases are meant for testing only, **use official releases for production!**

## List of artifacts

Artifacts can be found on the [latest CI run](https://github.com/PierreZ/fdb-prerelease-builder/actions/workflows/fdb-release.yml).

The workflow is building every week:

* the documentation,
* server and client packages,
* a derived Docker image.

|             	| DEB 	| TAR.GZ 	| Docker 	| Doc 	|
|-------------	|-----	|--------	|--------	|-----	|
| Release 6.3 	| ✅   	| ✅      	| ✅       	| ✅   	|
| Release 7.0 	| ✅   	| ✅      	| ✅     	| ✅   	|