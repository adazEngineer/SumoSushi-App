<script>
    import { menu } from '../../stores/menu.js';
  </script>
  
  <div class="menuCategorias">
    <div class="scroll">
      {#each $menu as categoria}
        <a href={"#" + categoria.NombreCategoria}>
          <h3>{categoria.NombreCategoria}</h3>
        </a>
      {/each}
    </div>
  </div>
  
  <style>
  .menuCategorias {
    width: 100%;
    max-width: 900px;
    padding: 15px 0;
    background-color: var(--color-fondo-secundario);
    position: fixed;
    top: 75px;
    z-index: 5;
    overflow-x: auto;
  }
  
  .scroll {
    display: flex;
    gap: 20px;
    padding-left: 10px;
    padding-right: 10px;
  }
  
  /* Estilizar scroll opcional */
  .menuCategorias::-webkit-scrollbar {
    display: none; /* Oculta scrollbar en Chrome */
  }
  
  .menuCategorias {
    -ms-overflow-style: none;  /* IE y Edge */
    scrollbar-width: none;     /* Firefox */
  }
  </style>
  