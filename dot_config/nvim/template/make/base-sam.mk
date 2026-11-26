.PHONY: deploy
deploy:
	cfn-lint template.yaml
	sam build
	sam deploy

