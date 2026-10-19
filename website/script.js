const menuButton = document.querySelector('.menu-button');
const navigation = document.querySelector('nav');
menuButton.addEventListener('click', () => {
  const open = menuButton.getAttribute('aria-expanded') === 'true';
  menuButton.setAttribute('aria-expanded', String(!open));
  navigation.classList.toggle('is-open', !open);
});
document.querySelectorAll('nav a').forEach((link) => link.addEventListener('click', () => {
  menuButton.setAttribute('aria-expanded', 'false'); navigation.classList.remove('is-open');
}));
document.getElementById('year').textContent = new Date().getFullYear();

const observer = new IntersectionObserver((entries) => entries.forEach((entry) => {
  if (entry.isIntersecting) { entry.target.classList.add('visible'); observer.unobserve(entry.target); }
}), { threshold: 0.14 });
document.querySelectorAll('.reveal').forEach((item) => observer.observe(item));

const dialog = document.querySelector('.lightbox');
const dialogImage = dialog.querySelector('img');
const dialogCaption = dialog.querySelector('p');
document.querySelectorAll('.gallery-item').forEach((item) => item.addEventListener('click', () => {
  dialogImage.src = item.dataset.full; dialogImage.alt = item.querySelector('img').alt; dialogCaption.textContent = item.dataset.caption; dialog.showModal();
}));
dialog.querySelector('.close-lightbox').addEventListener('click', () => dialog.close());
dialog.addEventListener('click', (event) => { if (event.target === dialog) dialog.close(); });
