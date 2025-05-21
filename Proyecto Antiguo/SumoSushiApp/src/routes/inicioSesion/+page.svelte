<script lang="ts">
    import '../../lib/styles/global.css';

    import Encabezado from '../../lib/components/Encabezado.svelte';
    import Boton from '../../lib/components/boton.svelte';

    let correo = '';
    let contrasenna = '';

    function iniciarSesion() {
        console.log('Iniciando sesión con:', correo, contrasenna);
    }
</script>

<Encabezado />

<div class="contenedor-principal">    

        <h1>Iniciar Sesión</h1>
        <form class="formulario-login" on:submit|preventDefault={iniciarSesion}>
            
            <input class="formulario-login__input"
                type="email" 
                placeholder="Correo electrónico" 
                bind:value={correo} 
                required
            />

            <input 
                type="password" 
                placeholder="Contraseña" 
                bind:value={contrasenna} 
                required
            />

            <p>¿Aun no tienes una cuenta? / <a href="/registroUsuario" class="registrate">Registrate</a></p>

            <Boton 
                texto={'Ingresar'} 
                clase={'btn'}
                onClick={iniciarSesion}
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
        transition: border 0.3s;
    }

    .formulario-login input:focus {
        border: 1px solid var(--color-secundario);
    }

    .registrate{
        color: var(--color-secundario);
        cursor: pointer;
        text-decoration: underline;
    }
</style>
