const btn = document.getElementById("bloomBtn");
const garden = document.getElementById("garden");
const messageBox = document.getElementById("message");

// Liste des messages
const messages = [
  "for the prettiest boy ever",
  "you are so precious",
  "Thank you for being so good, so sweet, so kind"
];

// Liste des sprites de fleurs (SVG inclus dans le repo)
const flowerSprites = [
  "flower_pink.svg",
  "flower_blue.svg",
  "flower_white.svg",
  "flower_yellow.svg"
];

btn.addEventListener("click", () => {
  // Changer le message
  const randomMsg = messages[Math.floor(Math.random() * messages.length)];
  messageBox.textContent = randomMsg;
  // show message briefly
  messageBox.style.opacity = '1';
  messageBox.style.transform = 'translate(-50%, -52%) scale(1.02)';
  clearTimeout(messageBox._hideTimeout);
  messageBox._hideTimeout = setTimeout(() => {
    messageBox.style.opacity = '0';
    messageBox.style.transform = 'translate(-50%, -50%) scale(1)';
  }, 2400);

  // Générer une fleur
  const flower = document.createElement("div");
  flower.classList.add("flower");

  // Sprite aléatoire
  const sprite = flowerSprites[Math.floor(Math.random() * flowerSprites.length)];
  flower.style.backgroundImage = `url(${sprite})`;

  // Position aléatoire
  const x = Math.random() * window.innerWidth;
  const y = Math.random() * window.innerHeight;

  flower.style.left = x + "px";
  flower.style.top = y + "px";

  garden.appendChild(flower);
});
