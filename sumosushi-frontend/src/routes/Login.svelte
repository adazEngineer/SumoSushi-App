<script lang="ts">

    import {goToHome} from './Routes';

    let usuario = '';
    let contrasena = '';
    
</script>

<section class="cont-main">
    <article class="cont">
        <h1 class="txt-titulo">Iniciar sesión</h1>
        <input bind:value={usuario} placeholder="Usuario" class="input-txt" />
        <input bind:value={contrasena} placeholder="Contraseña" type="password" class="input-txt" />
        <button class="btn" onclick={goToHome}>Entrar</button>
    </article>
</section>



