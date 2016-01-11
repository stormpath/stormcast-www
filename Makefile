# Makefile
#
# This file contains some helper scripts for building / deploying this site.

build:
	rm -rf build
	hugo

develop:
	rm -rf build
	hugo server --watch

deploy:
	aws --profile stormcast s3 website s3://www.stormca.st/ --index-document index.html
	aws --profile stormcast s3 sync build/ s3://www.stormca.st --acl public-read --delete
