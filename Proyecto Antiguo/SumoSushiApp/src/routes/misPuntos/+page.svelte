<script lang="ts">
    import '../../lib/styles/global.css';

    import Encabezado from '../../lib/components/Encabezado.svelte';
    import ListaProductos from '../../lib/components/listaProductos.svelte';
    import { menu } from '../../stores/menu.js';    
    import MenuInferior from '../../lib/components/menuInferior.svelte';

    // Valores simulados (luego los puedes traer de la base de datos)
    let puntosDisponibles = 1200;
    let puntosCanjeados = 350;
</script>

<Encabezado />

<div class="contenedor-principal contenedor-principal" > 

<div class="puntos">

    <h1 class="puntos__titulo">Mis Puntos</h1>

    <div class="puntos__info">
        <div class="puntos__card">
            <h3>Puntos Disponibles</h3>
            <h3 class="puntos__card-cantidad">{puntosDisponibles}</h3>
        </div>

        <div class="puntos__card">
            <h3>Total de Puntos Canjeados</h3>
            <h3 class="puntos__card-cantidad">{puntosCanjeados}</h3>
        </div>
    </div>

</div>

<h2>Productos canjeables</h2>

{#each $menu as categoriaMenu}
    <ListaProductos categoria = {categoriaMenu.NombreCategoria}/>
{/each} 

<MenuInferior puntos="iconoActivo"/>

</div>
<style>

    .puntos {
        width: 95%;
        max-width: 600px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        gap: 20px;
        padding: 20px;
        background-color: var(--color-fondo-secundario);
        border-radius: var(--border-radius);
    }

    .puntos__info {
        display: flex;
        flex-direction: column;
        gap: 20px;
        width: 100%;
    }

    .puntos__card {
        padding: 20px;
        border-radius: var(--border-radius);
        background-color: var(--color-fondo-principal);
        border: 1px solid var(--color-texto-principal);
    }

    .puntos__card-cantidad {
        font-weight: bold;
        color: var(--color-secundario);
    }

</style>
