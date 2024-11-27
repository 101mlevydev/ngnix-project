// Add a hover effect to the NGINX logo
const nginxLogo = document.querySelectorAll('.nginx-logo span');

nginxLogo.forEach(letter => {
  letter.addEventListener('mouseover', () => {
    letter.style.color = '#ff6347'; // Change color to tomato
  });

  letter.addEventListener('mouseout', () => {
    letter.style.color = ''; // Reset color
  });
});
