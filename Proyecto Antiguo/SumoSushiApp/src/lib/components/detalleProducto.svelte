<script lang="ts">
    import { menu } from '../../stores/menu.js';
    import { detalleProducto, ocultarDetalle } from '../../stores/detalleProducto.js';
    import Boton from '../components/boton.svelte';

    let cantidad: number = $state(0);

    function Aumentarcantidad(){
        cantidad ++;
    }

    function DisminuirCantidad(){
        if(cantidad > 0) cantidad--;        
    }

</script>

<div class="modal">
    <div class="producto">
        {#each $menu as categoriaMenu}            
            {#each categoriaMenu.Productos as producto}
                {#if producto.IdProducto === $detalleProducto.IdProducto}
                <form class="producto__form"> 
                    <div class="producto__img-container">
                        <img class="producto__img" src={producto.ImagenUrl} alt="Imagen de {producto.Nombre}" />

                        <div class="producto__cantidad">

                            <button aria-label="Restar cantidad" onclick={DisminuirCantidad}>
                                <i class="fas fa-minus producto__icono-cantidad"></i>
                            </button>

                            <p class="producto__cantidad-num">{cantidad}</p>

                            <button aria-label="Sumar cantidad" onclick={Aumentarcantidad}>
                                <i class="fas fa-plus producto__icono-cantidad"></i>
                            </button>

                        </div>
                    </div>

                    <div class="producto__info">
                        <div class="producto__titulo">
                            <h3 class="producto__nombre">{producto.Nombre}</h3>
                            <div class="producto__estrella-container">
                                <i class="producto__estrella">★</i>
                                <i class="producto__estrella">★</i>
                                <i class="producto__estrella">★</i>
                                <i class="producto__estrella">★</i>
                                <i class="producto__estrella">★</i>
                            </div>
                        </div>
                        <p class="producto__precio">₡{producto.Precio}</p>
                        <p class="producto__descripcion">{producto.Descripcion}</p>
                        
                        {#if producto.Etiquetas.length > 0}
                            <div class="producto__etiquetas">
                            {#each producto.Etiquetas as etiqueta }
                                <p class="producto__etiqueta">-{etiqueta}</p>
                            {/each}
                            </div>
                        {/if}
                        <hr class="producto__separador">

                        <textarea class="producto__notaCliente" 
                            id="notaCliente"
                            name="notaCliente" 
                            placeholder="Instrucciones adicionales..."
                            rows=2></textarea>          
                        
                        <div class="producto__botones">                                 
                            <input type="hidden" name="productoId" value={producto.IdProducto} />
                            <Boton 
                                texto={'Agregar ₡5500'} 
                                onClick={ocultarDetalle}
                                clase={'btn'}
                            />
                            
                            <Boton 
                                texto={'Cancelar'} 
                                onClick={ocultarDetalle}
                                clase={'btn btn--cancelar'}
                            />

                        
                        </div>
                    </div>               

                </form>
                {/if}
            {/each}
        {/each}
    </div>
</div>

<style>
    .producto__icono-cantidad{
        font-size:15px;
    }
    .producto__titulo{
        display: flex;
        justify-content: space-between;
    }

    .producto__estrella{
        color: var(--color-secundario);
    }

    .producto__form{
        width:100%;
    }

    .producto__etiquetas{
        display:flex;
        gap:10px;
    }
    
    .producto__botones {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px;
        width:100%;
    }

    .modal {
        display: flex;
        justify-content: center;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(0, 0, 0, 0.8);
        z-index: 1000;
        pointer-events: all;
    }

    .producto {
        background-color: var(--color-fondo-principal);
        border-radius: var(--border-radius);
        padding: 10px;
        width: 98%;
        gap:10px;
        max-width:500px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .producto__img-container {    
        display:flex;
        justify-content: center;
        margin:auto;
        width: 100%;
        max-width: 500px;
        border-radius: var(--border-radius);
        overflow: hidden;
        position: relative;
    }

    .producto__img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .producto__info{
        width: 95%;
        display: flex;
        flex-direction: column;
        margin:10px;
        gap:10px;
    }

    .producto__cantidad{
        position: absolute; 
        bottom: 0; 
        right: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 20px;
        margin: 9px 25px;
        padding: 10px;
        border-radius: var(--border-radius);
        background-color: var(--color-fondo-principal);
        opacity: 0.8;
    }

    .producto__cantidad p{
        background-color: var(--color-fondo-secundario);
        padding: 10px 15px;
        border-radius: var(--border-radius);
    }

    .producto__cantidad button{    
        border: 2px solid var(--color-texto-principal);    
        padding: 6px 10px;
        border-radius: 50%;
    }

    .producto__notaCliente {
        width: 100%;
        padding: 10px 15px;
        background-color: var(--color-fondo-secundario);
        border: 1px solid var(--color-texto-principal); 
        border-radius: var(--border-radius);
        color: var(--color-texto-principal);
        resize: none; 
        font-size: var(--tamanio-texto);
        font-family: inherit;
        outline: none;
        transition: border 0.5s;
    }

    .producto__notaCliente:focus {
        border: 1px solid var(--color-principal); 
        box-shadow: 0 0 5px var(--color-primario-transparente);
    }

    .producto__separador {
        width: 100%; 
        border: 1px solid var(--color-texto-principal); 
        opacity: 0.3;
    }

</style>
