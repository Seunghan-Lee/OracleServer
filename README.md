# OracleServer Stack

Infrastructure-as-code workspace for Oracle Cloud-hosted workloads:

1. **peterosea-wp** – www.peterosea.com company site (WordPress).
2. **heworks-blog** – blog.he-works.co WordPress blog.
3. **openclaw** – OpenClaw self-hosted instance.
4. **heworks-static** – www.he-works.co static site on Cloudflare Pages.

## Repo Layout

```
oci-os/
  config/            # Nginx, deployment, TLS templates
  docker/            # Docker Compose stacks
  scripts/, terraform/
scripts/             # Local helper scripts (deploy, backups, sync)
sites/               # Application source (themes, static site)
.github/workflows/   # CI/CD automation
```

## Prerequisites
- Oracle Linux (or similar) VM with Docker Engine + Docker Compose.
- Domains managed via Cloudflare (recommended) or another registrar.
- GitHub repository with Actions enabled.
- Installed CLI tools locally: `docker`, `docker compose`, `npm`, `openssl`, `oci`.

## Local Workflow
1. Run `./scripts/bootstrap.sh` once to create `.env` files from templates.
2. For a stack (e.g., peterosea-wp) run `docker compose --env-file .env -f oci-os/docker/peterosea-wp/docker-compose.yml up`.
3. Develop themes/plugins under `sites/<stack>/wp-content/` and commit to git.
4. Push to `main` to trigger GitHub Actions which redeploy the Oracle host.
5. For the static site, pushing to `main` triggers Cloudflare Pages deployment.

## Deployment Overview
- **Nginx** on the Oracle VM proxies `www.peterosea.com` → `127.0.0.1:8081`, `blog.he-works.co` → `127.0.0.1:8082`, and `openclaw.<domain>` → `127.0.0.1:8090`.
- `certbot --nginx` issues/renews TLS certificates automatically.
- GitHub Actions use SSH to run `docker compose pull && docker compose up -d` for each stack.
- Nightly cron dumps MySQL data to `/opt/backups` and syncs to Object Storage via OCI CLI.

## Next Steps
- Fill each `.env` with strong credentials and salts.
- Publish DNS A records for the Oracle VM and CNAME for Cloudflare Pages.
- Connect GitHub repo to Cloudflare Pages project for `www.he-works.co`.
