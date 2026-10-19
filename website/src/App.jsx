import { useEffect, useState } from 'react';

const places = [
  ['01', 'Ashworth Manor', 'A family estate, sealed in silence.', 'manor.png'],
  ['02', 'Blackwater Boathouse', 'Where the tide carries old secrets in.', 'boathouse.png'],
  ['03', 'Hollowmere Sanatorium', 'Its records were never meant to survive.', 'sanatorium.png'],
  ['04', 'Vane Cottage', 'A small home with a long memory.', 'vane-cottage.png'],
  ['05', 'The Gate Lodge', 'The first keeper never truly left.', 'gate-lodge.png'],
  ['06', 'The Ice House', 'Even the cold could not preserve the truth.', 'ice-house.png'],
];
const gallery = [['tall', 'lighthouse.png', 'The way to the lighthouse'], ['', 'chapel.png', 'Island Chapel'], ['', 'attic.png', 'Ashworth Manor attic']];
const asset = (name) => `/assets/${name}`;

function Reveal({ children, className = '' }) {
  const [visible, setVisible] = useState(false);
  const observe = (node) => { if (!node || node.dataset.observed) return; node.dataset.observed = '1'; new IntersectionObserver(([entry], observer) => { if (entry.isIntersecting) { setVisible(true); observer.disconnect(); } }, { threshold: 0.12 }).observe(node); };
  return <div ref={observe} className={`reveal ${visible ? 'visible' : ''} ${className}`}>{children}</div>;
}

export default function App() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [selected, setSelected] = useState(null);
  useEffect(() => { const close = (event) => event.key === 'Escape' && setSelected(null); window.addEventListener('keydown', close); return () => window.removeEventListener('keydown', close); }, []);
  return <>
    <a className="skip-link" href="#main">Skip to content</a>
    <header className="site-header" id="top"><a className="brand" href="#top"><span>✦</span> The Forgotten House</a><button className="menu-button" aria-expanded={menuOpen} aria-controls="navigation" onClick={() => setMenuOpen(!menuOpen)}>Menu</button><nav id="navigation" className={menuOpen ? 'is-open' : ''}>{['Story', 'Places', 'Gameplay', 'Gallery'].map((item) => <a key={item} href={`#${item.toLowerCase()}`} onClick={() => setMenuOpen(false)}>{item}</a>)}</nav></header>
    <main id="main">
      <section className="hero"><div className="hero-shade" /><div className="mist mist-one" /><div className="mist mist-two" /><div className="hero-content"><p className="eyebrow">A gothic hidden-object mystery</p><h1>The Forgotten<br /><em>House</em></h1><p className="hero-copy">Every abandoned room holds a secret. Every secret was left behind for a reason.</p><div className="hero-actions"><a className="button primary" href="#download">Play the game <span>→</span></a><a className="button secondary" href="#story">Enter the estate</a></div></div><a className="scroll-cue" href="#story">Scroll to uncover <span>↓</span></a></section>
      <section className="story section" id="story"><Reveal className="story-copy"><div className="section-mark">I</div><p className="eyebrow">What was left behind</p><h2>The house remembers.</h2><p>Three abandoned houses sit quietly at the edge of a story no one wanted told. Search through dust, locked drawers, forgotten letters, and the possessions of people who vanished.</p><p>Find what was hidden. Read what was never meant to be read. Piece together the truth.</p></Reveal><Reveal className="story-image"><figure><img src={asset('attic.png')} alt="A shadowy, cluttered attic in an abandoned house" /><figcaption>Ashworth Manor — the first door opens.</figcaption></figure></Reveal></section>
      <section className="places section" id="places"><Reveal className="section-intro"><div className="section-mark">II</div><div><p className="eyebrow">Six places. One buried truth.</p><h2>Follow the clues.</h2></div></Reveal><div className="place-grid">{places.map(([number, title, copy, image]) => <Reveal className="place-card" key={title}><img src={asset(image)} alt={title} loading="lazy" /><div><p>{number}</p><h3>{title}</h3><span>{copy}</span></div></Reveal>)}</div></section>
      <section className="gameplay section" id="gameplay"><Reveal className="gameplay-photo"><img src={asset('chapel.png')} alt="The worn interior of an abandoned island chapel" loading="lazy" /></Reveal><Reveal className="gameplay-copy"><div className="section-mark">III</div><p className="eyebrow">Look closer</p><h2>Nothing is quite where it should be.</h2><ul>{['Search richly detailed, hand-painted rooms.', 'Uncover hidden objects and meaningful keepsakes.', 'Open containers, solve locks, and find the next clue.', 'Reconstruct the stories buried in each house.'].map((item, index) => <li key={item}><span>0{index + 1}</span>{item}</li>)}</ul></Reveal></section>
      <section className="gallery section" id="gallery"><Reveal className="section-intro"><div className="section-mark">IV</div><div><p className="eyebrow">A glimpse inside</p><h2>Rooms that wait in the dark.</h2></div></Reveal><div className="gallery-grid">{gallery.map(([kind, image, caption]) => <Reveal className={`gallery-item ${kind}`} key={caption}><button onClick={() => setSelected({ image, caption })}><img src={asset(image)} alt={caption} loading="lazy" /></button></Reveal>)}</div></section>
      <section className="download" id="download"><div className="download-overlay" /><Reveal className="download-content"><img src={asset('keyhole.png')} alt="" className="keyhole" /><p className="eyebrow">The door is waiting</p><h2>Will you uncover what was forgotten?</h2><p>Begin your investigation in <em>The Forgotten House.</em></p><a className="button primary" href="#">Coming soon on Google Play <span>→</span></a><small>Replace this button’s link with your Google Play URL before publishing.</small></Reveal></section>
    </main><footer><a className="brand" href="#top"><span>✦</span> The Forgotten House</a><p>© {new Date().getFullYear()} The Forgotten House. All rights reserved. · <a href="/privacy">Privacy Policy</a></p><a href="#top">Back to top ↑</a></footer>
    {selected && <div className="lightbox" role="dialog" aria-modal="true" aria-label="Image preview" onClick={() => setSelected(null)}><div className="lightbox-content" onClick={(event) => event.stopPropagation()}><button className="close-lightbox" onClick={() => setSelected(null)} aria-label="Close image preview">×</button><img src={asset(selected.image)} alt={selected.caption} /><p>{selected.caption}</p></div></div>}
  </>;
}
