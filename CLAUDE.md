# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

MkDocs documentation site for the [Roar Supercomputer](https://docs.icds.psu.edu), operated by the Institute of Computational and Data Sciences (ICDS) at Penn State. All content lives in Markdown files under `docs/`.

## Local development

Install dependencies:
```bash
pip install -r requirements.txt
```

Build the site:
```bash
mkdocs build
```

Serve locally with live reload:
```bash
mkdocs serve
```

Preview at: http://127.0.0.1:8000/en/latest/

## Branch and deployment workflow

- `main` — live site at https://docs.icds.psu.edu (deploys every ~5 minutes)
- `staging` — preview at https://docs.icds.psu.edu/staging (deploys every ~5 minutes)
- **All PRs must target `staging`**, not `main`
- A GitHub Action automatically syncs `main` → `staging` after a PR to `main` is merged

## Site structure

Navigation is defined explicitly in `mkdocs.yml` under the `nav:` key. Adding a new page requires both:
1. Creating the Markdown file under `docs/`
2. Adding the path to the appropriate section in `mkdocs.yml`

All `docs/` paths in `mkdocs.yml` are relative to the `docs/` directory (e.g., `getting-started/faq.md` maps to `docs/getting-started/faq.md`).

## MkDocs extensions in use

- `admonition` — `!!! note`, `!!! warning`, etc.
- `pymdownx.details` — collapsible `??? note` blocks
- `pymdownx.superfences` — fenced code blocks with language tags
- `attr_list` — add HTML attributes to elements

## Content conventions

How-to guides (under `docs/getting-started/guides/`) follow a step-by-step format with `## Step N:` headings, `---` horizontal rules between steps, and an `## Additional resources` section at the end linking to related pages. Internal links use relative paths (e.g., `../running-jobs/resource-requests.md`).
