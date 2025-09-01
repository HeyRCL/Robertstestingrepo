const API_URL = "__API_URL__";

async function sendName() {
  const name = document.getElementById('name').value;
  const response = await fetch(API_URL, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ name })
  });
  const data = await response.json();
  document.getElementById('output').textContent = data.message;
}
