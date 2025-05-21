<script lang="ts">
    import '../../lib/styles/global.css';
    import Encabezado from '../../lib/components/Encabezado.svelte';
    import Boton from '../../lib/components/boton.svelte';
    import MenuInferior from '../../lib/components/menuInferior.svelte';

    type Direccion = {
        id: number;
        distrito: string;
        detalle: string;
    };

    let nombre = 'Adrian Alvarado';
    let telefono = '8888-8888';
    let correo = 'adrian@correo.com';

    let nombreTemp = nombre;
    let telefonoTemp = telefono;

    let editandoPerfil = false;

    let direcciones: Direccion[] = [
        { id: 1, distrito: 'San José', detalle: 'Avenida Central, edificio 3' },
        { id: 2, distrito: 'Escazú', detalle: 'Detrás del centro comercial XYZ' }
    ];

    function editarDireccion(id: number) {
        console.log('Editar dirección con ID:', id);
    }

    function eliminarDireccion(id: number) {
        direcciones = direcciones.filter(d => d.id !== id);
    }

    function activarEdicion() {
        nombreTemp = nombre;
        telefonoTemp = telefono;
        editandoPerfil = true;
    }

    function guardarCambios() {
        nombre = nombreTemp;
        telefono = telefonoTemp;
        editandoPerfil = false;
    }

    function cancelarCambios() {
        editandoPerfil = false;
    }
</script>

<Encabezado />

<div class="contenedor-principal perfil">
    <h1>Mi perfil</h1>

    <!-- Información del usuario -->
    <section class="perfil__info">
        <div class="perfil__encabezado">
            <h3 class="perfil__titulo-seccion">Información del usuario</h3>
            {#if !editandoPerfil}
                <button aria-label="Editar perfil" on:click={activarEdicion}>
                    <i class="fas fa-pen-to-square"></i>
                </button>
            {/if}
        </div>

        {#if editandoPerfil}
            <label>
                <strong>Nombre:</strong>
                <input type="text" bind:value={nombreTemp} />
            </label>
            <label>
                <strong>Teléfono:</strong>
                <input type="text" bind:value={telefonoTemp} />
            </label>
            <div class="perfil__acciones">
                <Boton texto="Guardar" clase="btn" onClick={guardarCambios} />
                <Boton texto="Cancelar" clase="btn btn--oscuro" onClick={cancelarCambios} />
            </div>
        {:else}
            <p><strong>Nombre:</strong> {nombre}</p>
            <p><strong>Teléfono:</strong> {telefono}</p>
        {/if}
        <p><strong>Correo:</strong> {correo}</p>
    </section>

    <!-- Direcciones del usuario -->
    <section class="perfil__direcciones">
        <div class="perfil__encabezado">
            <h3 class="perfil__titulo-seccion">Direcciones guardadas</h3>
            <button aria-label="Agregar dirección">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        {#each direcciones as direccion (direccion.id)}
            <div class="perfil__direccion">
                <p><strong>Distrito:</strong> {direccion.distrito}</p>
                <p><strong>Detalle:</strong> {direccion.detalle}</p>

                <div class="perfil__acciones">
                    <Boton texto="Editar" clase="btn btn--cancelar" onClick={() => editarDireccion(direccion.id)} />
                    <Boton texto="Eliminar" clase="btn" onClick={() => eliminarDireccion(direccion.id)} />
                </div>
            </div>
        {/each}
    </section>
</div>

<MenuInferior perfil="iconoActivo"/>


<style>
    .perfil__info,
    .perfil__direcciones {
        width: 95%;
        max-width: 600px;
        background-color: var(--color-fondo-secundario);
        padding: 20px;
        margin-bottom: 30px;
        border-radius: var(--border-radius);
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .perfil__titulo-seccion {
        margin-bottom: 10px;
        /* color: var(--color-secundario); */
    }

    .perfil__direccion {
        border: 1px solid var(--color-principal);
        border-radius: var(--border-radius);
        padding: 15px;
        margin-top: 10px;
        background-color: #1e1e1e;
    }

    .perfil__acciones {
        margin-top: 10px;
        display: flex;
        gap: 15px;
    }

    .perfil__encabezado {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

</style>
