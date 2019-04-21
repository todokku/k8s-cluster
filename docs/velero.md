# Configuring Velero	

Configuring velero on a kubernetes cluster is fairly easy, I recommend you reading velero documentation before reading this document, I'm just going thorough steps quickly here and there are a few tips I like to share.

## Requirements
* Healthy kubernetes cluster
* A reliable S3 Storage, like minio
* Credentials and access information for the S3 

## General installation process
There is a directory in this repository named velero, all the manifests you need to get the velero up and runninng are there.
You just need to modify the following files and apply the manifests:
* `velero/10-s3-secret.yaml`
you need to put the S3 credentials(secret and key) in this manifest.
* `20-storage-location.yaml`
you need to put the S3 url in this manifest.
After applying these changes you can install velero using `kubectl create -f ./velero/*.yaml` in the root directory of the repository.
You can verify correct installation by checking `kubectl get pods -n velero`, all the pods should be **Running**
## Using Velero to manage backup process
velero has a client which you can download from [here](https://github.com/heptio/velero/releases).it very straightforward, you can create backups or restore a backup using this client.
you can find good examples about velero client usage in [here](https://heptio.github.io/velero/v0.11.0/install-overview).


## Keep in mind
* Velero is a very simple tools, if you encounter any problem during installation or usage, you can always try deleting the velero using `kubectl delete -f ./velero/*.yaml` and installing it again using `kubectl create -f ./velero/*.yaml` , which might fix many installation issues.

* Velero use the s3 as the soure of truth, so as long as you keep the S3 safe you are good, no matter what is the state of your cluster.

* It worth mentioning that velero doesn't backup node information(it's not possible) so I don't know what is the mess you're struggling with at the moment, don't expect velero to restore all your nodes back.

* in many cases you might need to restore only parts of the backup, it possible using velero, read the documentation.
* Velero backups are simply JSON manifests, so you always can restore velero backups manually.
