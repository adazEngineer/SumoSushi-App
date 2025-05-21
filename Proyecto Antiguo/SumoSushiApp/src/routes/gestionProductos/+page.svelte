<script lang="ts">
    import '../../lib/styles/global.css';
    import Encabezado from '../../lib/components/Encabezado.svelte';
    import MenuInferior from '../../lib/components/menuInferior.svelte';
    import Boton from '../../lib/components/boton.svelte';
    import CategoriasMenu from '../../lib/components/menuCategorias.svelte';      
    import ListaProductos from '../../lib/components/listaProductos.svelte';
  
    import { menu } from '../../stores/menu.js';
    import { get } from 'svelte/store';
  
    interface Categoria {
      NombreCategoria: string;
      Productos: {
        IdProducto: number;
        Nombre: string;
        Precio: number;
        Descripcion: string;
        ImagenUrl: string;
        Etiquetas: string[];
      }[];
    }
  
    let categorias: Categoria[] = get(menu);
  
    // Modal
    let mostrarModal = false;
    let categoriaSeleccionada: Categoria | null = null;
    let mostrarModalNuevoProducto = false;

    function abrirModalNuevoProducto() {
    mostrarModalNuevoProducto = true;
    }

    function cerrarModalNuevoProducto() {
    mostrarModalNuevoProducto = false;
    }

  
    function abrirModal(categoria: Categoria) {
      categoriaSeleccionada = categoria;
      mostrarModal = true;
    }
  
    function cerrarModal() {
      categoriaSeleccionada = null;
      mostrarModal = false;
    }
  </script>
  
  <Encabezado />
  <CategoriasMenu/>
  
  <div class="contenedor-principal contenedor-principal--categorias">
    <section class="categorias">
      <table class="categorias__tabla">
        <thead class="categorias__cabecera">
          <tr>
            <th>Nombre</th>
            <th>Cantidad de productos</th>
          </tr>
        </thead>
        <tbody class="categorias__cuerpo">
          {#each categorias as categoria}
            <tr class="categorias__fila" on:click={() => abrirModal(categoria)}>
              <td>{categoria.NombreCategoria}</td>
              <td>{categoria.Productos.length}</td>
            </tr>
          {/each}
        </tbody>
    </table>

    <Boton 
        texto={'Nueva categoría'} 
        onClick={cerrarModal}
        clase={'btn btn--oscuro'}
    />

    <Boton 
        texto={'Nuevo Producto'} 
        onClick={abrirModalNuevoProducto}
        clase={'btn btn--oscuro'}
    />

    </section>

    {#each $menu as categoriaMenu}
        <ListaProductos categoria = {categoriaMenu.NombreCategoria}/>
    {/each} 
  
    {#if mostrarModal}
      <div class="modal">
        <div class="modal__contenido">
          <h3>¿Qué desea hacer con "{categoriaSeleccionada?.NombreCategoria}"?</h3>
          <div class="modal__acciones">
            <Boton 
                texto={'Deshabilitar'} 
                onClick={cerrarModal}
                clase={'btn'}
            />
            
            <Boton 
                texto={'Editar'} 
                onClick={cerrarModal}
                clase={'btn btn--oscuro'}
            />

            <Boton 
                texto={'Cerrar'} 
                onClick={cerrarModal}
                clase={'btn btn--oscuro'}
            />
          </div>
        </div>
      </div>
    {/if}

    {#if mostrarModalNuevoProducto}
  <div class="modal">
    <div class="modal__contenido">
      <h3>Crear nuevo producto</h3>

      <form class="formulario">
        <input type="text" placeholder="Nombre del producto" class="formulario__input" />
        <input type="number" placeholder="Precio" class="formulario__input" />
        <textarea placeholder="Descripción" class="formulario__input formulario__input--textarea"></textarea>
        <input type="text" placeholder="URL de la imagen" class="formulario__input" />
        <input type="text" placeholder="Etiquetas (separadas por comas)" class="formulario__input" />

        <div class="modal__acciones">
          <Boton 
            texto={'Cancelar'} 
            onClick={cerrarModalNuevoProducto} 
            clase={'btn'}
          />
          <Boton 
            texto={'Guardar'} 
            onClick={cerrarModalNuevoProducto} 
            clase={'btn btn--oscuro'}
          />
        </div>
      </form>
    </div>
  </div>
{/if}

  </div>
  
  <MenuInferior />
  
<style>
.formulario {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.formulario__input {
    background: #1e1e1e;
    color: var(--color-texto-principal);
    padding: 10px;
    border: 1px solid #555;
    border-radius: var(--border-radius);
    font-size: var(--tamanio-texto);
}

.formulario__input--textarea {
    resize: vertical;
    min-height: 80px;
}

.categorias{
    display:flex;
    flex-direction: column;
    margin-top: 20px;
    align-items: center;
    gap:10px;    
    width:95%;
    max-width: 800px;
    padding: 10px;
    border-radius: var(--border-radius);
    background-color: var(--color-fondo-secundario);
}

th, td{
    color: var(--color-texto-principal);
    font-size: var(--tamanio-texto);
}

.categorias__tabla {
    width: 100%;
    border-collapse: collapse;
}

.categorias__cabecera{
    background-color: var(--color-principal);
    background-color: var(--color-fondo-principal);
}

.categorias__cabecera th {
    text-align: left;
    padding: 1rem;
    background-color: var(--color-fondo-principal);
}

.categorias__cuerpo td {
    padding: 1rem;
    border-top: 1px solid #444;
}

.categorias__fila {
    cursor: pointer;
    transition: background-color 0.3s;
}

.categorias__fila:hover {
    background-color: #3d3d3d;
}

.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal__contenido {
    width: 90%;
    display:flex;
    flex-direction: column;
    gap: 10px;
    background: var(--color-fondo-secundario);
    padding: 2rem;
    border-radius: var(--border-radius);
    text-align: center;
}  

.modal__acciones{
    display: flex;
    justify-content: space-around;
    gap: 5px;

}

  </style>
  