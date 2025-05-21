
<script>

    let imagenes = [
      "img/Promo1.png",
      "img/Promo2.png",
      "img/Promo3.png"
    ];

</script>


<div class='slider'>
    {#each imagenes as img}
    <img src={img} alt="Imagen promocion">
    {/each}
</div>


<style>
    .slider{
        margin-top: 85px;
        /* aspect-ratio: 16/9; */
        width: 100%;
        position: relative;
        display: flex;
        overflow: scroll;
        scroll-snap-type: x mandatory;
    }

    .slider img{
        width: 100%;
        left: 0;
        position: sticky;
        object-fit: cover;
        border-radius: var(--border-radius);
        scroll-snap-align: center;
    }

</style>