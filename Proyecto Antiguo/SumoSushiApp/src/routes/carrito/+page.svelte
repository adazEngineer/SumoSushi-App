<script lang="ts">
    import '../../lib/styles/global.css';

    import Encabezado from '../../lib/components/Encabezado.svelte';
    import MenuInferior from '../../lib/components/menuInferior.svelte';
    import ListaCarrito from '../../lib/components/carrito.svelte';

    import { detalleProducto } from '../../stores/detalleProducto.js';
    import DetalleProducto from '../../lib/components/detalleProducto.svelte';
    import { mostrarDetalle } from '../../stores/detalleProducto.js';
    import Boton from '../../lib/components/boton.svelte';

    function redireccion(){
        window.location.href='/checkout';
    };

</script>

<Encabezado />

<div class="contenedor-principal" >
    
    <h1>Carrito</h1>

    <div class="contenedor-secundario">
    <ListaCarrito />

    <textarea class="producto__notaCliente" 
                            id="notaCliente"
                            name="notaCliente" 
                            placeholder="Instrucciones adicionales..."
                            rows=2></textarea>          
    
    
        <Boton 
            texto={'Aceptar ₡5500'} 
            clase={'btn'}
            onClick={redireccion}
        />        

    </div>
</div>

<MenuInferior carrito="iconoActivo"/>


<!-- MODAL -->
{#if $detalleProducto.Visible}
<DetalleProducto/>
{/if}



<style>
    .producto__notaCliente {
        width: 95%;
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

    .contenedor-secundario{
        display: flex;
        flex-direction: column;
        gap: 20px;
        align-items: center;
    }
</style>