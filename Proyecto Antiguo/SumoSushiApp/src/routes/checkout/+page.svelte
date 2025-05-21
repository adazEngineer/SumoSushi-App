<script lang="ts">

    import {onMount} from 'svelte';
    import '../../lib/styles/global.css';    
    import Encabezado from '../../lib/components/Encabezado.svelte';
    import MenuInferior from '../../lib/components/menuInferior.svelte';
    import {carrito} from '../../stores/carrito.js';
    import Boton from '../../lib/components/boton.svelte';

    function totalProducto(precio: number, cantidad: number): number{
        return precio * cantidad;
    }

    
</script>

<Encabezado />

<div class="contenedor-principal" > 
    <div class="checkout">
        <div class="checkout__encabezado">
            <h1>Checkout</h1>
            <select id="servicio" name="servicio" class="dropdown">
                <option value="" selected disabled>Seleccione un servicio</option>
                <option class="dropdown__opcion">Recoger en el local</option>
                <option class="dropdown__opcion">Enviar a dirección</option>
            </select>
        </div>
        
        <hr>        
        
        <table class="tabla">
            <thead>
                <tr>
                    <th><p class="tabla__titulo">Producto</p></th>
                    <th><p class="tabla__titulo">Precio</p></th>
                    <th class="tabla__cantidad"><p class="tabla__titulo">Cantidad</p></th>
                    <th class="tabla__total"><p class="tabla__titulo">Total</p></th>
                </tr>
            </thead>
            
            <tbody>
                {#each $carrito as producto}
                <tr>
                    <td><p>{producto.Nombre}</p></td>
                    <td><p>₡{producto.Precio}</p></td>
                    <td class="tabla__cantidad"><p>{producto.Cantidad}</p></td>
                    <td class="tabla__total"><p>₡{totalProducto(producto.Precio, producto.Cantidad)}</p></td>
                </tr>
                {/each}
            </tbody>
        </table>

        <hr>

        <div class="detalles">
            <div class="detalles__item">
                <p>Costo de envio: </p>
                <p>₡1000</p>
            </div>

            <div class="detalles__item">
                <p>Impuestos: </p>
                <p>₡350</p>
            </div>

            <div class="detalles__item">
                <p>Total: </p>
                <p>₡17000</p>
            </div>     
        </div>


        <div class="checkout__boton">
            <Boton texto={'Completar compra'} clase={'btn'} />
        </div>


    </div>
</div>

<MenuInferior inicio="iconoActivo"/>

<style>
    .checkout{
        width: 95%;
        max-width: 600px;
        background-color: var(--color-fondo-secundario);
        height: auto;
        border-radius: var(--border-radius);

        display: flex;
        flex-direction: column;
        padding: 10px;
        gap: 10px;
    }

    .tabla {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 8px 1px;
        text-align: left;
    }

    th{
        font-weight: 700;
    }

    .tabla__cantidad{
        text-align: center;
    }

    .tabla__total{
        text-align: right;
    }

    .tabla__titulo{
        font-weight: bold;
    }

    

    .detalles__item, .checkout__encabezado{
        display: flex;
        justify-content: space-between;
    }

    .checkout__boton {
        display: flex;
        justify-content: center;
        width: 100%;
    }
</style>