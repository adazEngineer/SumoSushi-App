
<script lang="ts">
    import { carrito } from '../../stores/carrito.js';
    import { mostrarDetalle } from '../../stores/detalleProducto.js';


</script>

<div class="lista-productos">   

    {#each $carrito as producto}

        <button class="producto" on:click={() => mostrarDetalle(producto.IdProducto)}> 

            <div class="producto__img-container">
                <img class="producto__img" src={producto.ImagenUrl} alt="Imagen de {producto.Nombre}" />
            </div>

            <div class="producto__info">
                <h3>{producto.Nombre}</h3>
                <p class="producto__precio">₡{producto.Precio}</p>
                <p class="producto__descripcion">{producto.Descripcion}</p>

                <div class="producto__cantidad">
                    <p>0</p>
                </div>
            </div>
        </button>

    {/each}
</div>

<style>
    
    .producto__img-container {
        width: 30%;
        border-radius: 12px;
        background-color: black;
        overflow: hidden;
        flex-shrink: 0; 
    }

    .producto__img {
        width: 100%;
        height: auto;
        object-fit: contain; 
        display: block;
    }

    .producto__cantidad {
        display: flex;
        position: relative;
        gap: 8px;
        position: absolute;
        top: 5px;
        right: 0;
    }
    
    .producto__cantidad p {
        background-color: var(--color-fondo-principal);
        padding: 5px 8px;
        border-radius: var(--border-radius);
        text-align: center;
    }

    .lista-productos {
        display: flex;
        flex-wrap: wrap;
        flex-direction: column;
        width: 95%;
        max-width: 800px;
        justify-content: center;
        gap: 8px;
        margin: 10px;
        scroll-margin-top: 145px;
    }

    .producto {
        display: flex;
        width: 100%;
        gap: 5px;
        padding: 5px;
        background-color: var(--color-fondo-secundario);
        border-radius: var(--border-radius);        
        display: flex;
        gap: 1rem;
        align-items: flex-start;
    }

    .producto__info {
        display: flex;
        flex-direction: column;
        text-align: left;
        gap: 5px;
        /* width: 65%;  */
        padding-bottom: 10px;
        position: relative;
    }

    .producto__cantidad {
        display: flex;
        position: relative;
        gap: 8px;
        position: absolute;
        top: 5px;
        right: 0;
    }
</style>
