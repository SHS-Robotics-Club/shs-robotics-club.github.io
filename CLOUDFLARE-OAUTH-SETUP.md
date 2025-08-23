# Cloudflare Workers OAuth Setup for Sveltia CMS

This guide walks through setting up free OAuth authentication for the Sveltia CMS on GitHub Pages.

## Overview

GitHub Pages is a static host - it can't handle the OAuth authentication callback. Cloudflare Workers acts as a tiny server to handle the authentication handshake.

## Steps

### 1. Create a GitHub OAuth App

1. Go to: https://github.com/settings/developers
2. Click **New OAuth App**
3. Fill in:
   - **Application name**: `SHS Robotics CMS`
   - **Homepage URL**: `https://shsrobotics.club`
   - **Authorization callback URL**: `https://YOUR-WORKER.workers.dev/callback` (we'll create this URL in step 2)
4. Click **Register application**
5. Note down the **Client ID**
6. Click **Generate a new client secret** and note that too

### 2. Deploy the Sveltia Auth Worker

1. Go to: https://github.com/sveltia/sveltia-cms-auth
2. Click **Fork**
3. In your forked repo, click **Deploy** (button on README)
4. You'll be redirected to Cloudflare

### 3. Configure Cloudflare Worker

1. On Cloudflare:
   - Create a new project name (e.g., `shs-robotics-cms-auth`)
   - Under **Environment Variables**, add:
     - `GITHUB_OAUTH_ID`: your Client ID from step 1
     - `GITHUB_OAUTH_SECRET`: your Client Secret from step 1
   - Click **Deploy**

2. After deploying, you'll get a URL like: `https://shs-robotics-cms-auth.YOUR-USER.workers.dev`

### 4. Update GitHub OAuth App

1. Go back to your GitHub OAuth App
2. Update the **Authorization callback URL** to:
   `https://YOUR-WORKER-URL.workers.dev/callback`
3. Save

### 5. Update CMS Config

Edit `static/admin/config.yml` and replace the placeholder:

```yaml
backend:
  name: github
  repo: SHS-Robotics-Club/shs-robotics-club.github.io
  branch: master
  base_url: https://YOUR-WORKER-URL.workers.dev  # <-- UPDATE THIS
  auth_endpoint: oauth
```

### 6. Test It

1. Visit: https://shsrobotics.club/admin
2. Click **Login with GitHub**
3. After authentication, you should see the CMS dashboard

## Troubleshooting

- **Redirect URI mismatch**: Ensure the callback URL in GitHub matches exactly (including `https://` and `/callback`)
- **Worker not found**: Check your Cloudflare worker URL is correct
- **Permission errors**: Ensure your OAuth app has `repo` scope

## Costs

This setup is **completely free**:
- Cloudflare Workers: 100,000 requests/day free
- GitHub OAuth: Free
- GitHub Pages: Free
