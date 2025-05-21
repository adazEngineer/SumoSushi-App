<script>
    import '../lib/styles/global.css';
    
    import Encabezado from '../lib/components/Encabezado.svelte';
    import MenuInferior from '../lib/components/menuInferior.svelte';
    import Carrusel3 from '../lib/components/carrusel3.svelte';
    import ListaProductos from '../lib/components/listaProductos.svelte';
    import CategoriasMenu from '../lib/components/menuCategorias.svelte';    

    import { menu } from '../stores/menu.js';

    import { detalleProducto } from '../stores/detalleProducto.js';
    import DetalleProducto from '../lib/components/detalleProducto.svelte';
    
</script>

<Encabezado />

<div class="contenedor-principal contenedor-principal--categorias" > 
<CategoriasMenu/>
<Carrusel3/> 
{#each $menu as categoriaMenu}
    <ListaProductos categoria = {categoriaMenu.NombreCategoria}/>
{/each} 
</div>

<!-- MODAL -->
{#if $detalleProducto.Visible}
<DetalleProducto/>
{/if}

<MenuInferior inicio="iconoActivo"/>



