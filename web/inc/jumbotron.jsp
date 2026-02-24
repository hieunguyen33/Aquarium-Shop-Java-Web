<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Best Seller Showcase</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #fafafa;
      margin: 0;
      padding: 0;
    }

    .section-header {
      text-align: center;
      margin: 40px 0 20px;
    }

    .section-header h2 {
      font-weight: 700;
      font-size: 32px;
      color: #ff5722;
      margin-bottom: 8px;
    }

    .section-header p {
      color: #555;
      font-size: 15px;
    }

    /* ==== Carousel ==== */
    .showcase-carousel {
      position: relative;
      max-width: 800px;
      margin: 0 auto;
      overflow: hidden;
    }

    .showcase-track {
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      height: 420px;
    }

    .showcase-slide {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) scale(0.5) rotate(-5deg);
      opacity: 0;
      transition: all 0.6s ease-in-out;
      z-index: 0;
      filter: blur(2px);
    }

    .showcase-slide.active {
      opacity: 1;
      transform: translate(-50%, -50%) scale(1) rotate(0deg);
      z-index: 3;
      filter: none;
    }

    .showcase-slide.prev {
      opacity: 0.6;
      transform: translate(-140%, -50%) scale(0.8) rotate(-8deg);
      z-index: 2;
    }

    .showcase-slide.next {
      opacity: 0.6;
      transform: translate(40%, -50%) scale(0.8) rotate(8deg);
      z-index: 2;
    }

    .showcase-card {
      background: linear-gradient(135deg, #ffffff, #f8f9fa);
      border-radius: 18px;
      box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
      padding: 18px;
      width: 320px;
      text-align: center;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .showcase-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 28px rgba(0, 0, 0, 0.25);
    }

    .showcase-card img {
      width: 75%;
      border-radius: 10px;
      margin-bottom: 12px;
    }

    .showcase-card h5 {
      margin: 6px 0;
      font-size: 19px;
      font-weight: bold;
    }

    .showcase-card p {
      color: #777;
      font-size: 14px;
    }

    /* Nút điều hướng */
    .nav-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background: #ff5722;
      border: none;
      color: white;
      font-size: 20px;
      padding: 10px 14px;
      border-radius: 10px;
      cursor: pointer;
      z-index: 10;
      transition: background 0.3s;
    }

    .nav-btn:hover {
      background: #e64a19;
    }

    .nav-btn.prev { left: 10px; }
    .nav-btn.next { right: 10px; }

    /* Indicators */
    .carousel-progress {
      display: flex;
      justify-content: center;
      gap: 6px;
      margin-top: 18px;
    }

    .carousel-progress span {
      display: block;
      height: 6px;
      width: 40px;
      background: #ddd;
      border-radius: 4px;
      overflow: hidden;
      position: relative;
    }

    .carousel-progress span.active {
      background: #ff5722;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <div class="section-header">
    <h2>🔥 Best Seller 🔥</h2>
    <p>Top trending products you should not miss</p>
  </div>

  <!-- Carousel -->
  <div class="showcase-carousel">
    <div class="showcase-track">
      <!-- Slide 1 -->
      <div class="showcase-slide active">
        <div class="showcase-card">
          <img src="assets/images/Guppy Full Red.png" alt="sp1">
          <h5>Guppy Full Red</h5>
          <p>Bán chạy #1</p>
        </div>
      </div>
      <!-- Slide 2 -->
      <div class="showcase-slide next">
        <div class="showcase-card">
          <img src="assets/images/Tôm Blue Dream.png" alt="sp2">
          <h5>Tôm Blue Dream</h5>
          <p>Bán chạy #2</p>
        </div>
      </div>
      <!-- Slide 3 -->
      <div class="showcase-slide">
        <div class="showcase-card">
          <img src="assets/images/Guppy Lace.png" alt="sp3">
          <h5>Guppy Lace</h5>
          <p>Bán chạy #3</p>
        </div>
      </div>
      <!-- Slide 4 -->
      <div class="showcase-slide">
        <div class="showcase-card">
          <img src="assets/images/Betta Plakat (PK).webp" alt="sp4">
          <h5>Betta Plakat (PK)</h5>
          <p>Bán chạy #4</p>
        </div>
      </div>
    </div>

    <!-- Nút điều hướng -->
    <button class="nav-btn prev">&#10094;</button>
    <button class="nav-btn next">&#10095;</button>

    <!-- Progress indicator -->
    <div class="carousel-progress">
      <span class="active"></span>
      <span></span>
      <span></span>
      <span></span>
      <span></span>
    </div>
  </div>

  <script>
    const showcaseSlides = document.querySelectorAll(".showcase-slide");
    const prevBtn = document.querySelector(".nav-btn.prev");
    const nextBtn = document.querySelector(".nav-btn.next");
    const bars = document.querySelectorAll(".carousel-progress span");
    const carousel = document.querySelector(".showcase-carousel");

    let currentIndex = 0;
    let autoPlayInterval;

    function updateShowcase() {
      showcaseSlides.forEach((slide, index) => {
        slide.classList.remove("active", "prev", "next");
        if (index === currentIndex) {
          slide.classList.add("active");
        } else if (index === (currentIndex + 1) % showcaseSlides.length) {
          slide.classList.add("next");
        } else if (index === (currentIndex - 1 + showcaseSlides.length) % showcaseSlides.length) {
          slide.classList.add("prev");
        }
      });

      bars.forEach((bar, i) => {
        bar.classList.toggle("active", i === currentIndex);
      });
    }

    function prevSlide() {
      currentIndex = (currentIndex - 1 + showcaseSlides.length) % showcaseSlides.length;
      updateShowcase();
    }

    function nextSlide() {
      currentIndex = (currentIndex + 1) % showcaseSlides.length;
      updateShowcase();
    }

    prevBtn.addEventListener("click", () => {
      prevSlide();
      resetAutoPlay();
    });

    nextBtn.addEventListener("click", () => {
      nextSlide();
      resetAutoPlay();
    });

    bars.forEach((bar, i) => {
      bar.addEventListener("click", () => {
        currentIndex = i;
        updateShowcase();
        resetAutoPlay();
      });
    });

    // Auto-play
    function startAutoPlay() {
      autoPlayInterval = setInterval(nextSlide, 3500); // 4 giây
    }

    function resetAutoPlay() {
      clearInterval(autoPlayInterval);
      startAutoPlay();
    }

    // Pause khi hover
    carousel.addEventListener("mouseenter", () => {
      clearInterval(autoPlayInterval);
    });

    carousel.addEventListener("mouseleave", () => {
      startAutoPlay();
    });

    // Init
    updateShowcase();
    startAutoPlay();
  </script>

</body>
</html>
