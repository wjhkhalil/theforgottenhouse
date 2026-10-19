# The Forgotten House website

This is a React website built with Vite. It has no server-side requirement.

## Publish

Run `npm run build`, then upload the generated `dist` folder to Netlify, Cloudflare Pages, GitHub Pages, or any ordinary web host. Set the build command to `npm run build` and the publish directory to `dist` if the host asks.

Before publishing, replace the `href="#"` on the Google Play button in `index.html` with the final store URL. The button currently announces that the game is coming soon, so it cannot accidentally send visitors to the wrong place.

## Test locally

Install dependencies once with `npm install`, then run `npm run dev`. Vite will show a local address such as `http://localhost:5173` to open in your browser. All images are local, responsive, and included in `public/assets`.
