<script>
  let index = 0;
  let images = [
      "img/Promo1.png",
      "img/Promo2.png",
      "img/Promo3.png"
  ];
  let startX = 0;
  let endX = 0;
  
  function nextImage() {
      index = (index + 1) % images.length;
  }
  
  function prevImage() {
      index = (index - 1 + images.length) % images.length;
  }
  
  let interval = setInterval(nextImage, 5000);
  
  function handleTouchStart(event) {
      startX = event.touches[0].clientX;
  }
  
  function handleTouchEnd(event) {
      endX = event.changedTouches[0].clientX;
      if (startX - endX > 50) {
          nextImage();
      } else if (endX - startX > 50) {
          prevImage();
      }
  }
</script>

<div class="carousel" on:touchstart={handleTouchStart} on:touchend={handleTouchEnd}>
  {#each images as image, i}
      <img 
          src={image} 
          alt="Imagen" 
          class="carousel__image {index === i ? 'active' : ''}"
      >
  {/each}
</div>

<style>
  .carousel {
      width: 100%;
      height: 350px;
      overflow: hidden;
      position: relative;
      border: 2px solid #333;
      margin: 80px auto;
      display: flex;
      justify-content: center;
      align-items: center;
  }

  .carousel__image {
      max-width: 100%;
      max-height: 100%;
      position: absolute;
      opacity: 0;
      transition: opacity 0.5s ease-in-out;
  }

  .carousel__image.active {
      opacity: 1;
  }
</style>
