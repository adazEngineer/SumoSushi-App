<script lang="ts">
    const {inicio="", puntos="", carrito="", pedidos="", perfil=""}: 
        {inicio?:string, puntos?:string, carrito?:string, pedidos?:string, perfil?:string} = $props();

    const cantidadItemsCarrito = 3;
</script>

<div class="menu">
    <div class="menu__contenido">

        <a href="/" class="boton" aria-label="Ir a inicio">
            <i class="fas fa-home {inicio}"></i>
        </a>   
        
        <a href="/misPuntos" class="boton" aria-label="Ver mis puntos">
            <i class="fas fa-coins {puntos}"></i>
        </a> 
        
        <a href="/carrito" class="boton menu__carrito" aria-label="Ir a mi carrito de compras">
            <i class="fas fa-shopping-cart {carrito}"></i>
            {#if cantidadItemsCarrito > 0}
                <p class="menu__badge">{cantidadItemsCarrito}</p>
            {/if}
        </a>   
        
        <a href="/misPedidos" class="boton" aria-label="Ir a mis pedidos">
            <i class="fas fa-receipt {pedidos}"></i>
        </a>   
        
        <a href="/perfilUsuario" class="boton" aria-label="Ir a mi perfil">
            <i class="fas fa-id-badge {perfil}"></i>
        </a> 

    </div>
</div>

<style>
    .menu {
        background-color: var(--color-fondo-secundario);
        height: clamp(3rem, 8vh, 10rem);
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
        border-radius: var(--border-radius) var(--border-radius) 0 0;
    }

    .menu__contenido {
        padding: 0.2vh 3vw;
        display: flex;
        justify-content: space-between;
        height: 100%;  
        align-items: center;      
    }

    .iconoActivo {
        color: var(--color-principal);
    }

    .menu__carrito {
        position: relative;
    }

    .menu__badge {
        position: absolute;
        top: -15px;
        right: -10px;
        background-color: var(--color-principal);
        color: white;
        border-radius: 50%;
        padding: 0 5px;
    }
</style>
