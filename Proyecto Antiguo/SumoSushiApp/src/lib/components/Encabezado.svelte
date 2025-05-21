<script lang="ts">
    let {estadoRestaurante = "Cerrado"}: {estadoRestaurante?:string} = $props();
    
    let menuActivo: "menuInactivo" | "menuActivo" = $state("menuInactivo");

    function toggleMenu(){
        menuActivo = menuActivo === "menuInactivo" ? "menuActivo" : "menuInactivo";
    }

</script>

<div class="encabezado">
    <div class="encabezado__contenido">
        <h3 class="encabezado__estado">{estadoRestaurante}</h3>
        <img class="encabezado__logo" src="img/logo.png" alt="Logo"/>        
        <button class="encabezado__boton" onclick={toggleMenu} aria-label="Abrir menú">
            <i class="fas fa-user"></i>
        </button>        
    </div>  



    <div class={menuActivo}>
        <a href="/inicioSesion">Iniciar sesión</a>
        <a href="/">Cerrar sesión</a>
        <hr>
        <a href="/pedidosRestaurante">Pedidos</a>
        <a href="/gestionProductos">Productos</a>
        <a href="/">Promociones</a>
        <a href="/">Finanzas</a>
    </div>

</div>

<style>
    .encabezado{
        background-color: var(--color-principal);
        height: 75px;
        /* height: clamp(3rem, 8vh, 10rem) ; */
        position: fixed; /* Esto hace que el encabezado se quede fijo en la parte superior */
        top: 0; /* Lo mantiene en la parte superior */
        width:100%;
        position: fixed;
        z-index: 10;

        display: flex;
        justify-content: center;
    }    


    .encabezado__contenido{        
        width: 90%;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        height: 100%;        
    }

    .encabezado__estado, .encabezado__boton{
        margin-bottom: 10px;
    }




    .encabezado__logo{
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        max-height: 100%;
        width: auto;
    }

    .menuInactivo{
        display: none;
    }

    .menuActivo{
        display: block;     
        position: absolute;
        top: 99%; /* Lo posiciona justo debajo del encabezado */
           
        padding: 1vh 2vw;
        right: 0;
        background-color: var(--color-principal);
        width: auto;     
        
        display: flex;
        flex-direction: column;
        gap:10px;

        z-index: 10;

        border-bottom-left-radius: var(--border-radius);
    }

    .menuActivo a{
        font-weight: bold;
    }


</style>
