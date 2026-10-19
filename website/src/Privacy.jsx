// Shown at /privacy. Keep this in step with the game: if a new SDK, analytics
// or online feature is added, the "What the game collects" section must change.
const EFFECTIVE_DATE = 'October 19, 2026';
const CONTACT_EMAIL = 'heyitswajeeha@gmail.com';

const sections = [
  ['Who we are', <>
    <p><em>The Forgotten House</em> (“the game”, “we”, “us”) is a hidden-object mystery game for Android, published on Google Play under the package name <code>com.theforgottenhouse.game</code>. This policy explains what information the game and this website handle, and why.</p>
  </>],
  ['The short version', <>
    <ul>
      <li>You do not create an account, and we never ask for your name, email address, phone number or photos.</li>
      <li>Your progress and settings are saved only on your own device. We do not receive them.</li>
      <li>The game shows ads through Google AdMob. Google may collect some device information to deliver and measure those ads, as described below.</li>
      <li>We do not sell personal information, and we do not run our own analytics or tracking.</li>
    </ul>
  </>],
  ['What is stored on your device', <>
    <p>To remember where you are in the story, the game keeps a small save file in its private storage on your phone. It contains:</p>
    <ul>
      <li>which chapters you have completed and which are unlocked;</li>
      <li>objects already found and containers already opened in an unfinished room;</li>
      <li>your best result for each chapter (stars and best time) and the clues collected in your Journal;</li>
      <li>your settings: sound, music and effects volume, and vibration.</li>
    </ul>
    <p>This file never leaves your device and is not sent to us or anyone else. You can delete it at any time by clearing the game’s storage in your phone’s settings or by uninstalling the game.</p>
  </>],
  ['Advertising (Google AdMob)', <>
    <p>The game is free and is supported by ads served by Google AdMob, a service of Google LLC. You may be offered an optional video ad in exchange for a hint, and a full-screen ad may appear between some chapters. To show, limit and measure these ads, and to prevent fraud, the AdMob software in the game may collect and send to Google:</p>
    <ul>
      <li>your device’s advertising ID (Android Advertising ID);</li>
      <li>your IP address, from which an approximate location can be inferred;</li>
      <li>device and app information, such as device model, operating system version, language and app version;</li>
      <li>ad interactions, such as which ads were shown and whether they were tapped or watched;</li>
      <li>diagnostic information, such as crash logs and performance data related to the ads.</li>
    </ul>
    <p>We do not receive this information in a form that identifies you; we only see summary reports such as the number of ads shown. Google’s use of this data is governed by Google’s own policies: <a href="https://policies.google.com/privacy" target="_blank" rel="noreferrer">Google Privacy Policy</a> and <a href="https://policies.google.com/technologies/partner-sites" target="_blank" rel="noreferrer">How Google uses information from apps that use its services</a>.</p>
    <p>If you are offline, no ads are requested and no information is sent to Google.</p>
  </>],
  ['Your choices and consent', <>
    <p>If you are in the European Economic Area, the United Kingdom or Switzerland, the game shows Google’s consent form before any ad is requested. There you can agree to or refuse personalised ads and the use of your data for advertising. If you refuse, Google may still show non-personalised ads, which use only limited data such as your approximate location.</p>
    <p>Wherever you live, you can control ad personalisation on Android by opening <strong>Settings → Google → Ads</strong> (or <strong>Settings → Privacy → Ads</strong> on some phones) and resetting or deleting your advertising ID. You can also review your choices at <a href="https://adssettings.google.com" target="_blank" rel="noreferrer">adssettings.google.com</a>.</p>
  </>],
  ['Permissions the game uses', <>
    <ul>
      <li><strong>Internet and network state</strong> — to load ads. The game itself plays fully offline.</li>
      <li><strong>Advertising ID</strong> — used by Google AdMob as described above.</li>
      <li><strong>Vibration</strong> — for gentle haptic feedback, which you can turn off in the game’s settings.</li>
    </ul>
    <p>The game does not use your camera, microphone, contacts, precise location or files.</p>
  </>],
  ['Children', <>
    <p>The game is not directed at children under 13, and we do not knowingly collect personal information from them. If you believe a child has provided personal information through the game, contact us and we will help remove it.</p>
  </>],
  ['This website', <>
    <p>This website does not use cookies, analytics or advertising. It is hosted by Cloudflare, which processes basic technical information such as your IP address and browser type to deliver the pages and protect them from abuse. See <a href="https://www.cloudflare.com/privacypolicy/" target="_blank" rel="noreferrer">Cloudflare’s Privacy Policy</a>.</p>
  </>],
  ['Data security and retention', <>
    <p>Because we do not collect personal information ourselves, we hold none to store or delete. Your save file stays on your device until you remove it. Data collected by Google is kept according to Google’s retention policies.</p>
  </>],
  ['Your rights', <>
    <p>Depending on where you live (for example under the GDPR in Europe or the CCPA in California), you may have rights to access, correct or delete personal information and to object to its use. Because the game does not send us personal information, requests about advertising data are best made to Google through the links above. You are welcome to contact us with any question and we will help where we can.</p>
  </>],
  ['Changes to this policy', <>
    <p>If the game changes in a way that affects your privacy, we will update this page and the date at the top. Continuing to use the game after a change means you accept the updated policy.</p>
  </>],
  ['Contact', <>
    <p>Questions about this policy or your privacy can be sent to <a href={`mailto:${CONTACT_EMAIL}`}>{CONTACT_EMAIL}</a>.</p>
  </>],
];

export default function Privacy() {
  return <>
    <a className="skip-link" href="#main">Skip to content</a>
    <header className="site-header"><a className="brand" href="/"><span>✦</span> The Forgotten House</a><nav><a href="/">Back to the house</a></nav></header>
    <main id="main" className="privacy section">
      <p className="eyebrow">Privacy policy</p>
      <h1>What the house keeps, and what it does not.</h1>
      <p className="privacy-date">Effective {EFFECTIVE_DATE}</p>
      {sections.map(([title, body], index) => <section key={title}><h2><span>{String(index + 1).padStart(2, '0')}</span>{title}</h2>{body}</section>)}
    </main>
    <footer><a className="brand" href="/"><span>✦</span> The Forgotten House</a><p>© {new Date().getFullYear()} The Forgotten House. All rights reserved.</p><a href="/">Home ↑</a></footer>
  </>;
}
