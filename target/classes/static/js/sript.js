function navFun() {
  let nav = document.getElementById("nav");
  let navbtn = document.getElementById("navbtn");

  nav.classList.toggle("hidden");

  if (navbtn.innerHTML === `<i class="fa-solid fa-xmark mx-[2px]"></i>`) {
    navbtn.innerHTML = `<i class="fa-solid fa-bars"></i>`;
  } else {
    navbtn.innerHTML = `<i class="fa-solid fa-xmark mx-[2px]"></i>`;
  }
}
function openModal() {
  const modal = document.getElementById("videoModal");
  const video = document.getElementById("modalVideo");

  modal.classList.remove("hidden"); // Show the modal
  video.play(); // Play the video in the modal
}

function closeModal() {
  const modal = document.getElementById("videoModal");
  const video = document.getElementById("modalVideo");

  modal.classList.add("hidden"); // Hide the modal
  video.pause(); // Pause the video
  video.currentTime = 0; // Reset video to start
}

function openLoginModal() {
  document.getElementById("authModal").classList.remove("hidden");
  showLoginForm(); // Show login form by default
}

function openRegisterModal() {
  document.getElementById("authModal").classList.remove("hidden");
  showRegisterForm(); // Show register form by default
}

function closeAuthModal() {
  document.getElementById("authModal").classList.add("hidden");
}

function showLoginForm() {
  document.getElementById("loginForm").classList.remove("hidden");
  document.getElementById("registerForm").classList.add("hidden");
  document.getElementById("loginTab").classList.add("border-blue-500");
  document.getElementById("registerTab").classList.remove("border-blue-500");
}

function showRegisterForm() {
  document.getElementById("registerForm").classList.remove("hidden");
  document.getElementById("loginForm").classList.add("hidden");
  document.getElementById("registerTab").classList.add("border-blue-500");
  document.getElementById("loginTab").classList.remove("border-blue-500");
}
function togglePassword(id) {
  const passwordInput = document.getElementById(id);
  const passwordIcon = document.getElementById(id + "Icon");

  if (passwordInput.type === "password") {
    passwordInput.type = "text";
    passwordIcon.classList.remove("fa-eye");
    passwordIcon.classList.add("fa-eye-slash");
  } else {
    passwordInput.type = "password";
    passwordIcon.classList.remove("fa-eye-slash");
    passwordIcon.classList.add("fa-eye");
  }
}
const swiper = new Swiper(".swiper-container", {
  loop: true,
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
  navigation: {
    nextEl: ".swiper-button-next",
    prevEl: ".swiper-button-prev",
  },
  autoplay: {
    delay: 5000,
    disableOnInteraction: false,
  },
});
