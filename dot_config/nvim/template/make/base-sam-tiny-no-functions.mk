CONFIG_ENV=default
DEPLOY_OPTS=

STACK_NAME={{_input_:stack_name}}
SAM_CONFIG_FILE=samconfig.toml
CAPABILITIES=CAPABILITY_IAM # CAPABILITY_AUTO_EXPAND

.PHONY: default
default: deploy

ifeq (,$(wildcard $(SAM_CONFIG_FILE)))
  DEPLOY_OPTS2=--guided
else
  DEPLOY_OPTS2=
endif

.PHONY: deploy
deploy:
	( \
		sam build && \
		sam deploy \
			--confirm-changeset \
			--no-disable-rollback \
			--stack-name $(STACK_NAME) \
			--config-env $(CONFIG_ENV) \
			--capabilities $(CAPABILITIES) \
			$(DEPLOY_OPTS) \
	)
