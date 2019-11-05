.PHONY: test clean docker sh shell

REPO := $(shell basename $(shell git remote get-url origin) .git)

test: .terraform
	AWS_DEFAULT_REGION=us-east-2 terraform validate
	terraform fmt -check
	! egrep "TF-UPGRADE-TODO|cites-illinois|as-aws-modules" *.tf README.md
	# Do NOT put terraform-aws in the title
	! grep "#\s*terraform-aws-" README.md
	# Do NOT use type string when you can use type number or bool!
	! egrep '"\d+"|"true"|"false"' *.tf README.md
	# Do NOT use old style maps in docs
	! egrep "\w+\s*\{" README.md
	# Do NOT drop the "s" in outputs.tf or variables.tf!
	! find . -name output.tf -o -name variable.tf | grep '.*'
	# Do NOT define an output in files other than outputs.tf
	! egrep 'output\s+"\w+"\s*\{' $(shell find . -name '*.tf' ! -name outputs.tf)
	# Do NOT define a variable in files other than variables.tf
	! egrep 'variable\s+"\w+"\s*\{' $(shell find . -name '*.tf' ! -name variables.tf)
	# DO put a badge in README.md
	grep -q "\[\!\[Build Status\]([^)]*$(REPO)/status.svg)\]([^)]*$(REPO))" README.md
	# Do NOT use ?ref= in source lines in a README.md!
	! grep 'source\s*=.*?ref=' *.tf README.md
	# Do NOT start a source line with git::
	! grep 'source\s*=\s*"git::' *.tf README.md
	# Do NOT use .git in a source line
	! grep 'source\s*=.*\.git.*"' *.tf README.md

# Launches the Makefile inside a container
docker: 
	docker build . -t test/$(REPO)
	docker run --rm test/$(REPO)

# Create alias
sh: shell

# Launches the shell inside a container for debugging the Makefile
shell:
	docker build . -t test/$(REPO)
	docker run -it --rm --entrypoint=sh test/$(REPO)

clean:
	-rm -rf .terraform
	-docker rmi test/$(REPO)

# Create .terraform if does not exist
# A terraform init is requried to run a validate :-(
.terraform:
	terraform init -backend=false
	terraform version
