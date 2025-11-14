# Aviation Weather Web App

A single-page aviation weather application providing TAF (Terminal Aerodrome Forecast), METAR (Meteorological Aerodrome Report), and PIREP (Pilot Reports) data.

Deployed at: [wx.hisenz.com](https://wx.hisenz.com)

## Features

- **TAF**: Terminal Aerodrome Forecasts with hourly breakdowns
- **METAR**: Current weather observations
- **PIREP**: Pilot weather reports
- Direct API access to aviationweather.gov
- Clean avionics-style UI
- Single HTML file - no build process required

## Project Structure

```
TAF/
├── index.html    # Single-page application (everything inline)
└── README.md     # This file
```

## Deployment to Cloudflare Pages

### Option 1: Via Wrangler CLI

1. Install Wrangler (if not already installed):
```bash
npm install -g wrangler
```

2. Login to Cloudflare:
```bash
wrangler login
```

3. Deploy:
```bash
wrangler pages deploy . --project-name=wx-hisenz --branch=main
```

4. Configure custom domain:
   - Go to Cloudflare Dashboard → **Pages** → **wx-hisenz** → **Custom domains**
   - Click **Set up a custom domain**
   - Enter `wx.hisenz.com`
   - Cloudflare will automatically configure DNS and SSL

### Option 2: Via Cloudflare Dashboard

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Navigate to **Workers & Pages** → **Create application** → **Pages** → **Connect to Git** (or **Direct Upload**)
3. Upload the `index.html` file
4. Set project name to `wx-hisenz`
5. Deploy
6. Configure custom domain `wx.hisenz.com` in **Custom domains** settings

### Option 3: GitHub Integration

1. Push this repo to GitHub
2. In Cloudflare Dashboard, go to **Workers & Pages** → **Create application** → **Pages** → **Connect to Git**
3. Select your repository
4. Set build settings:
   - **Build command**: (leave empty)
   - **Build output directory**: `/`
5. Deploy
6. Configure custom domain `wx.hisenz.com`

## Local Testing

Simply open `index.html` in a web browser. No build process or local server required.

## How It Works

The application makes direct API calls to `https://aviationweather.gov/api/data` to fetch weather data. All HTML, CSS, and JavaScript are contained in a single `index.html` file for maximum simplicity.

## License

MIT
