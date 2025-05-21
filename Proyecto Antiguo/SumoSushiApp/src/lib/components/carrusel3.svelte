<script lang="ts">
    // Definición de tipo básico para productos
    interface Promocion {
      id: string;
      imagen: string;
    }
    
    import { onMount, onDestroy } from 'svelte';  
    export let itemsVisibles: number =3;    
    let currentIndex: number = 0;
    let actualItemsVisibles: number = itemsVisibles;
    const intervaloMilisegundos = 4000; 
    let promociones: Promocion[] = [
        { id: '123', imagen: 'img/Promo1.png' },
        { id: '456', imagen: 'img/Promo2.png' },
        { id: '789', imagen: 'img/Promo3.png' }
    ];
    
    
    // Navegación
    function nextSlide(): void {
      if (currentIndex < promociones.length - actualItemsVisibles) {
        currentIndex++;
      }
    }
    
    function prevSlide(): void {
      if (currentIndex > 0) {
        currentIndex--;
      }
    }     

  // Importante utilizar la funcion almacenada en una variable para poder 
  // eliminar el intervalo al destruir el componente
  let intervalo: ReturnType<typeof setInterval>;
  onMount(() => {
    updateVisibleItems();
    window.addEventListener('resize', updateVisibleItems);

    // Empieza el auto-slide
    intervalo = setInterval(() => {
      if (currentIndex < promociones.length - actualItemsVisibles) {
        currentIndex++;
      } else {
        currentIndex = 0; 
      }
    }, intervaloMilisegundos);

    return () => {
      window.removeEventListener('resize', updateVisibleItems);
      clearInterval(intervalo); 
    };
  });

  onDestroy(() => {
    clearInterval(intervalo); 
  });
    
    // *** MODIFICAR PARA TOMAR EN CUENTA LA CANTIDAD DE ITEMS VISIBLES DISPONIBLES*** //
    function updateVisibleItems(): void {
      if (window.innerWidth < 768) {
        actualItemsVisibles = 1;
      } else if (window.innerWidth < 992) {
        actualItemsVisibles = Math.min(2, itemsVisibles);
      } else {
        actualItemsVisibles = itemsVisibles;
      }
      
      if (currentIndex > promociones.length - actualItemsVisibles) {
        currentIndex = Math.max(0, promociones.length - actualItemsVisibles);
      }
    }

    $: offsetX = `translateX(-${currentIndex * 100 / actualItemsVisibles}%)`;
    $: itemWidth = `${100 / actualItemsVisibles}%`;
  </script>
  
  <!-- Carrusel -->
  <div class="carousel">
    <div class="carousel__container">
      <div class="carousel__track" style="transform: {offsetX}">
        {#each promociones as producto}
          <div class="carousel__item" style="width: {itemWidth}">
            <a href="/producto/{producto.id}">
              <img class="carousel__image" src={producto.imagen} alt="Producto {producto.id}" data-id={producto.id}>
            </a>
          </div>
        {/each}
      </div>
    </div>

    <!-- Indicadores -->
  <div class="indicadores">
    {#each Array(promociones.length - actualItemsVisibles + 1).fill(0) as _, index}
      <div 
        class="indicador {index === currentIndex ? 'activo' : ''}">
      </div>
    {/each}
  </div>

  <!-- Botones -->
    {#if promociones.length > actualItemsVisibles}
      <div class="carousel__controls">
        <button class="carousel__button carousel__button--prev" on:click={prevSlide} disabled={currentIndex === 0}>
          &lt;
        </button>
        <button class="carousel__button carousel__button--next" on:click={nextSlide}
                disabled={currentIndex >= promociones.length - actualItemsVisibles}>
          &gt;
        </button>
      </div>
    {/if}
  </div>
  
  
  
  <style>
    .carousel {
    position: relative;
    width: 100%;
    margin: 0 auto;
  }

  .carousel__container {
    overflow: hidden;
  }

  .carousel__track {
    display: flex;
    transition: transform 0.3s ease-out;
  }

  .carousel__item {
    flex-shrink: 0;
    padding: 0 0px;
  }

  .carousel__image {
    width: 100%;
    height: auto;
    border-radius: 4px;
    display: block;
  }

  .carousel__controls {
    display: flex;
    justify-content: space-between;
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    transform: translateY(-50%);
    pointer-events: none;
  }

  .carousel__button {
    background: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    font-size: 18px;
    cursor: pointer;
    pointer-events: auto;
  }

  .carousel__button:disabled {
    opacity: 0.3;
    cursor: not-allowed;
  }

  .carousel__button--prev {
    margin-left: 10px;
  }

  .carousel__button--next {
    margin-right: 10px;
  }

  .indicadores {
    display: flex;
    justify-content: center;
    margin-top: 10px;
    gap: 15px;
  }

  .indicador {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: var(--color-principal); /* Color por defecto */
    transition: background-color 0.3s;    
  }

  .activo {
    background-color: var(--color-secundario); 
  }

  </style>