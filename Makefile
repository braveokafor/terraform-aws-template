.PHONY: all init plan apply destroy test fmt lint security doc clean help

# Define variables
TERRAFORM := terraform
ENV ?= $(shell echo $$ENV)

# If ENV is not set, default to 'default'
ifeq ($(ENV),)
    ENV := default
    $(info ENV not set, defaulting to 'default')
endif

# Check for necessary tools
ifeq (, $(shell which $(TERRAFORM)))
	$(error "Terraform not found. Please install Terraform")
endif

# Default target
all: init fmt test plan apply

# Initialize Terraform, backend, modules, and select workspace
init:
	@echo "Initializing Terraform..."
	@$(TERRAFORM) init \
		-backend=true \
		-get=true \
		-input=false \
		-reconfigure \
		-upgrade
	@echo "Switching to workspace $(ENV)..."
	@$(TERRAFORM) workspace select $(ENV) || $(TERRAFORM) workspace new $(ENV)

# Plan changes
plan: init
	@echo "Planning changes for $(ENV) environment..."
	@$(TERRAFORM) plan -out=tfplan

# Apply changes
apply:
	@if [ ! -f tfplan ]; then \
		echo "tfplan file not found. Running 'make plan' first..."; \
		$(MAKE) plan; \
	fi
	@echo "Applying changes for $(ENV) environment..."
	@$(TERRAFORM) apply tfplan

# Destroy resources
destroy: init
	@echo "Destroying resources in $(ENV) environment..."
	@$(TERRAFORM) destroy -auto-approve

# Run tests
test:
	@echo "Running Terraform validation..."
	@$(TERRAFORM) validate

# Format Terraform files
fmt:
	@echo "Formatting Terraform files..."
	@$(TERRAFORM) fmt -recursive

# Run static code analysis with TfLint
lint:
	@if command -v tflint >/dev/null 2>&1; then \
		echo "Running tflint..."; \
		tflint; \
	else \
		echo "tflint not found. Please install TFLint to run static code analysis."; \
		exit 1; \
	fi
	
# Run security scan with Checkov
security:
	@if command -v checkov >/dev/null 2>&1; then \
		echo "Running Checkov security scan..."; \
		checkov -d .; \
	else \
		echo "Checkov not found. Please install Checkov to run security scans."; \
		exit 1; \
	fi
	
# Generate module documentation with terraform-docs
doc:
	@if command -v terraform-docs >/dev/null 2>&1; then \
		echo "Updating module documentation..."; \
		terraform-docs --config=.terraform-docs.yml --output-file README.md --output-mode inject . ; \
	else \
		echo "terraform-docs not found. Please install terraform-docs to generate module documentation."; \
		exit 1; \
	fi

# Clean up Terraform files
clean:
	@echo "Cleaning up Terraform files..."
	@rm -rf .terraform tfplan
	@echo "Cleaned .terraform directory and tfplan file."

# Help
help:
	@echo "Available targets:"
	@echo "  init     - Initialize Terraform and select workspace"
	@echo "  plan     - Plan changes for the specified environment"
	@echo "  apply    - Apply changes for the specified environment"
	@echo "  destroy  - Destroy resources in the specified environment"
	@echo "  test     - Run Terraform validation"
	@echo "  fmt      - Format Terraform files recursively"
	@echo "  lint     - Run static code analysis (if tflint is available)"
	@echo "  security - Run Checkov security scan (if checkov is available)"
	@echo "  doc      - Run terraform-docs documentation generator (if terraform-docs is available)"
	@echo "  clean    - Remove .terraform directory and tfplan file"
	@echo ""
	@echo "Usage: make [target] ENV=[terraform workspace (default=default)]"
