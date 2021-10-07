# FoundationDB (pre)release Builder [![Build branches](https://github.com/PierreZ/fdb-release-builder/actions/workflows/fdb-release.yml/badge.svg)](https://github.com/PierreZ/fdb-release-builder/actions/workflows/fdb-release.yml)

This Github action is creating **pre-release** version of FoundationDB. This releases are meant for testing only, **use official releases for production!**

## List of artifacts

The workflow is building every week:

* the documentation,
* server and client packages,
* correctness tests.

|             	| DEB 	| TAR.GZ | Doc 	| Joshua |
|-------------	|-----	|--------|-----	| ------ |
| Release 6.3 	| ✅   	| ✅     | ✅ 	| ✅      |
| Release 7.0 	| ✅   	| ✅     | ✅ 	| ✅      |

## Getting started with a pre-release

Artifacts can be found on the [latest CI run](https://github.com/PierreZ/fdb-prerelease-builder/actions/workflows/fdb-release.yml).

### Start fdbserver

```shell
# Download both client server targz
$ mkdir fdb-630
$ mv $HOME/Downloads/foundation-* fdb-630
$ cd fdb-630 && ls
foundationdb-clients_release-6.3.PRERELEASE.x86_64.tar.gz.zip
foundationdb-server_release-6.3.PRERELEASE.x86_64.tar.gz.zip

# Decompress
$ unzip foundationdb-clients_release-6.3.PRERELEASE.x86_64.tar.gz.zip 
$ unzip foundationdb-server_release-6.3.PRERELEASE.x86_64.tar.gz.zip 
$ tar -xvf foundationdb-clients*.tar.gz
$ tar -xvf foundationdb-server*.tar.gz
$ rm *.zip *.tar.gz

# Create cluster file
$ echo "local:local@127.0.0.1:4500" > fdb.cluster 

# Run fdbserver
$ mkdir {data,logs}
$ ./sbin/fdbserver -p 127.0.0.1:4500 -C $PWD/fdb.cluster -d $PWD/data -L $PWD/logs

# Init database
$ ./bin/fdbcli --exec "configure new single memory"
$ ./bin/fdbcli --exec "status"
```

### Use a pre-release client

You can either:

* change the [`LD_LIBRARY_PATH` env var](https://forums.foundationdb.org/t/using-foundationdb-without-installing-client-libraries/1667/2),
* use the [multi-version client](https://forums.foundationdb.org/t/how-to-setup-multi-version-clients-with-java/1549/2).