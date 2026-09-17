# Forgejo Actions requirement

Forgejo Actions compatibility is a first-class project requirement.

A Forgejo Runner with OCI/container support MUST be able to execute the same `amiga-runtime` qualification contract as local execution and GitHub Actions. Provider-specific workflow files MAY orchestrate jobs, but substantive runtime and evidence logic MUST stay provider-neutral.

Self-hosted Forgejo runners are the preferred path for private AmigaOS qualification requiring user-owned proprietary system files and, later, attached real hardware.
