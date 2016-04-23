# Following ENV must be defined before make \
GCP_PROJECT_DIR=<project directory> \
GCP_CONFIGURATION=<configuration, e.g. default> \
GCP_KEY_FILE=<service_account_key.json> \
GCP_PROJECT_ID=<project_id>	\
GCP_ZONE=<gcp-zone>	\
GCP_ENVIRONMENT=<dev|stage|prod> \
GCP_DNS_ZONE=<dns-zone, e.g. somdev> \
GCP_DNS_DOMAIN=<example.com.> \
GCP_CLUSTER_NAME=<cluster_name>	 \
GCP_GSDATA_BUCKET=${GCP_PROJECT_ID}-gsdata \
See env.sh

all: config

help:
	@echo "Usage: make (auth | check-tools | config | help)"

# Make sure I am authanticated
auth: check-tools
	@if [ ! -z ${GCP_KEY_FILE} ] && [ -f ${GCP_KEY_FILE} ] ; \
	then \
		gcloud auth activate-service-account --key-file ${GCP_KEY_FILE} ; \
	fi

check-tools:
	@if command -v gcloud >/dev/null 2>&1 ; then \
		gcloud components update ; \
	else \
		echo Google Copuld SDK is not installed. Please install the SDK: https://cloud.google.com/sdk/ ; \
		false ; \
	fi
	@if ! command -v terraform >/dev/null 2>&1 ; then \
		echo Terraform is not installed. Please install Terraform: https://www.terraform.io/downloads.html ;\
		false ; \
	fi
	@if ! command -v jq >/dev/null 2>&1 ; then \
		echo Jq is not installed. Please install Jq: https://stedolan.github.io/jq/download/ ;\
		false ; \
	fi
	@if ! command -v kubectl >/dev/null 2>&1 ; then \
		echo kubectl is not installed. Installing... ; \
		gcloud components install kubectl ; \
	fi
	
# Make sure I am woking on the right project!
config: auth
	@if gcloud config configurations list | grep ${GCP_CONFIGURATION} ; \
	then \
		gcloud config configurations activate ${GCP_CONFIGURATION} ; \
		gcloud config set project $$(cat ${GCP_KEY_FILE} | jq -r '.project_id') ; \
		gcloud config set compute/zone ${GCP_ZONE} ; \
		gcloud config set container/cluster ${GCP_CLUSTER_NAME} ; \
	else \
		gcloud config configurations list; \
		echo Configuration "${GCP_CONFIGURATION}" is missing. Please use "gcloud init" to create it. ; \
		false ; \
	fi

destroy:
	# do nothing
	# should be "logout" ??

.PHONY: all auth check-tools config destroy help 
