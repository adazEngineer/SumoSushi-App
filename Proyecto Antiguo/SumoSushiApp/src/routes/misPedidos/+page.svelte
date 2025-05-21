<script lang="ts">
    // import '../lib/styles/global.css';

    import Encabezado from '../../lib/components/Encabezado.svelte';
    import MenuInferior from '../../lib/components/menuInferior.svelte';

    let pedidos = [
        { id: 1, fecha: '2025-04-05', total: 5500, estado: 'Completado' },
        { id: 2, fecha: '2025-03-28', total: 4300, estado: 'Completado' },
        { id: 3, fecha: '2025-03-20', total: 12000, estado: 'Completado' }
    ];

    let pedidosActivos = [
    { id: 4, fecha: '2025-04-08', total: 6000, estado: 'En preparación' },
    { id: 5, fecha: '2025-04-08', total: 3000, estado: 'En camino' }
];

</script>

<Encabezado />

<div class="contenedor-principal">

    <!-- Pedidos Activos -->
    <div class="activos">
        <h1 class="activos__titulo">Pedidos Activos</h1>

        <div class="activos__contenedor">
            {#each pedidosActivos as pedido}
                <div class="activos__pedido">
                    <h3 class="activos__pedido-titulo">Pedido #{pedido.id}</h3>
                    <p class="activos__pedido-fecha">Fecha: {pedido.fecha}</p>
                    <p class="activos__pedido-total">Total: ₡{pedido.total}</p>
                    <p class="activos__pedido-estado">Estado: {pedido.estado}</p>
                </div>
            {/each}
        </div>
    </div>

    <!-- Historial -->
    <div class="historial">
        <h2 class="historial__titulo">Historial de Pedidos</h2>

        <div class="historial__filtro">
            
            <label for="fecha-inicio" class="historial__filtro-label">Fecha:</label>
            <input type="date" id="fecha-inicio" class="historial__filtro-input" />
            

        </div>

        <div class="historial__contenedor">
            {#each pedidos as pedido}
                <div class="historial__pedido">
                    <h3 class="historial__pedido-titulo">Pedido #{pedido.id}</h3>
                    <p class="historial__pedido-fecha">Fecha: {pedido.fecha}</p>
                    <p class="historial__pedido-total">Total: ₡{pedido.total}</p>
                    <p class="historial__pedido-estado">Estado: {pedido.estado}</p>
                </div>
            {/each}
        </div>
    </div>

</div>

<MenuInferior pedidos="iconoActivo" />



<style>
        
    .historial {
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

    .historial__contenedor {
        display: flex;
        flex-direction: column;
        gap: 20px;
        width: 100%;
        max-width: 500px;

        justify-content: center;
        align-items: center;
        text-align: center;


    }

    .historial__pedido {
        width: 100%;
        padding: 10px;
        border-radius: var(--border-radius);
        background-color: var(--color-fondo-principal);
        /* border: 1px solid var(--color-texto-principal); */
    }

    .activos {
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

.activos__contenedor {
    display: flex;
    flex-direction: column;
    gap: 20px;
    width: 100%;
    max-width: 500px;
    justify-content: center;
    align-items: center;
    text-align: center;
}

.activos__pedido {
    width: 100%;
    padding: 10px;
    border-radius: var(--border-radius);
    background-color: var(--color-fondo-principal);
}

.activos__pedido,
.historial__pedido {
    text-align: left;
}

.historial__filtro {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    align-items: center;
    justify-content: center;
    background-color: var(--color-fondo-principal);
    padding: 15px;
    border-radius: var(--border-radius);
    width: 90%;
    max-width: 400px;
}

.historial__filtro-label {
    font-weight: bold;
}

.historial__filtro-input {
    background-color: var(--color-fondo-secundario);
    border: 1px solid var(--color-texto-principal);
    border-radius: 5px;
    padding: 5px 10px;
    color: var(--color-texto-principal);
    font-size: var(--tamanio-texto);
}

.historial__pedido-titulo, 
    .activos__pedido-titulo{
        margin-bottom: 10px;
    }



.historial__filtro-input::-webkit-calendar-picker-indicator {
    filter: invert(1); /* invierte el color del icono */
    opacity: 0.8;
    cursor: pointer;
}

</style>