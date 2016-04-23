# Check & Config [Cloud SDK](https://cloud.google.com/sdk/)

This project form a base for working on [Google Cloud Platform](https://cloud.google.com/). 

It use a Makefile for:

* check and update [Google Cloud SDK](https://cloud.google.com/sdk/) installation
* check [Terraform](https://www.terraform.io/intro/getting-started/install.html) and Jq installation
* config gcloud

## Prerequisites

1. **[Setup Google Account and Tools](https://cloud.google.com/container-engine/docs/before-you-begin)**

	Create a gcloud configuration by:

	```
	$ gcloud init
	```

1. **[Install Terraform](https://www.terraform.io/intro/getting-started/install.html)**

	We'll use Terraform as the main codification tool for building platform.


## Config [Cloud SDK](https://cloud.google.com/sdk/)

First edit env.sh and validate all the env values for the project.

```
$ source env.sh
$ make
```
__Reference:__ [Google Cloud SDK Configurations](https://cloud.google.com/sdk/gcloud/reference/topic/configurations)

