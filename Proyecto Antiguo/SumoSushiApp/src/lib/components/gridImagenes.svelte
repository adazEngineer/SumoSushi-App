<script lang="ts">
    // Definición de tipo básico para productos
    interface Promocion {
      id: string;
      imagen: string;
    }
    
    // Props
    let promociones: Promocion[] = [
        { id: '123', imagen: 'img/Promo1.png' },
        { id: '456', imagen: 'img/Promo1.png' },
        { id: '789', imagen: 'img/Promo1.png' }
    ];
  </script>

<div class="grid">
    {#each promociones as promocion}
        <img class="grid__img" src={promocion.imagen} alt="Imagen de promoción">
    {/each}
</div>


<style>
    .grid{
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 10px;
        padding: 10px;
    }

    .grid__img{
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: var(--border-radius);
        box-shadow:2px 2px 5px rgba(0, 0, 0, 0.2);
    }
</style>