import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './styles.css';
import App from './App.jsx';
import Privacy from './Privacy.jsx';

const isPrivacy = window.location.pathname.replace(/\/+$/, '') === '/privacy';
if (isPrivacy) document.title = 'Privacy Policy | The Forgotten House';
createRoot(document.getElementById('root')).render(<StrictMode>{isPrivacy ? <Privacy /> : <App />}</StrictMode>);
