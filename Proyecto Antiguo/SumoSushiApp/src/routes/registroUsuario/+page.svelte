<script lang="ts">
    import '../../lib/styles/global.css';

    import Encabezado from '../../lib/components/Encabezado.svelte';
    import Boton from '../../lib/components/boton.svelte';

    let nombre = '';
    let telefono = '';
    let correo = '';
    let contrasenna = '';
    let confirmarContrasenna = '';

    function registrarUsuario() {
        if (contrasenna !== confirmarContrasenna) {
            alert('Las contraseñas no coinciden');
            return;
        }

        console.log('Registrando usuario:', { nombre, telefono, correo, contrasenna });
    }
</script>

<Encabezado />

<div class="contenedor-principal">    

    <h1>Registrarse</h1>

    <form class="formulario-login" on:submit|preventDefault={registrarUsuario}>

        <input 
            class="formulario-login__input"
            type="text" 
            placeholder="Nombre completo" 
            bind:value={nombre} 
            required
        />

        <input 
            class="formulario-login__input"
            type="tel" 
            placeholder="Teléfono" 
            bind:value={telefono} 
            required
        />

        <input 
            class="formulario-login__input"
            type="email" 
            placeholder="Correo electrónico" 
            bind:value={correo} 
            required
        />

        <input 
            class="formulario-login__input"
            type="password" 
            placeholder="Contraseña" 
            bind:value={contrasenna} 
            required
        />

        <input 
            class="formulario-login__input"
            type="password" 
            placeholder="Confirmar contraseña" 
            bind:value={confirmarContrasenna} 
            required
        />

        <p>¿Ya tienes una cuenta? / <a href="/inicioSesion" class="registrate">Iniciar Sesión</a></p>

        <Boton 
            texto={'Registrarme'} 
            clase={'btn'}
            onClick={registrarUsuario}
        />
    </form>

</div>

<style>

    .contenedor-principal{
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

    .formulario-login {
        display: flex;
        flex-direction: column;
        gap: 20px;
        width: 100%;
        max-width: 400px;
        align-items: center;
    }

    .formulario-login input {
        width: 95%;
        padding: 12px 15px;
        background-color: var(--color-fondo-secundario);
        border: 1px solid var(--color-texto-principal);
        border-radius: var(--border-radius);
        color: var(--color-texto-principal);
        font-size: var(--tamanio-texto);
        outline: none;
    }

    .formulario-login input:focus {
        border: 1px solid var(--color-secundario);
    }

    .registrate {
        color: var(--color-secundario);
        cursor: pointer;
        text-decoration: underline;
    }

</style>
