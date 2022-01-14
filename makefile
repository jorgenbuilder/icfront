all:
	rm -rf service-worker/dist
	(cd service-worker; npm run build)
	ssh ic0.io "sudo rm -rf /var/www/html/service_worker/* /home/ubuntu/dist"
	scp -r service-worker/dist ic0.io:
	ssh ic0.io "sudo cp -r dist/* /var/www/html/service_worker"

build:
	(cd service-worker; npm run build)
	rm -f public/*
	cp service-worker/dist/* public
	firebase deploy

setup:
	echo install npm
	(cd service-worker; npm install)
	npm install -g firebase-tools
	firebase login
	echo "update CANSTER_ID and MY_DOMAIN in agent-js/apps/sw-cert/src/sw/http_request.ts"
	read
	$EDITOR service-worker/src/sw/http_request.ts
	mkdir public
	firebase init
