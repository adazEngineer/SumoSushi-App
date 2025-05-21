<!-- SVELTE 5 + TYPESCRIPT - RESUMEN BÁSICO CON RUNAS -->

<script lang="ts">
    // ------------------------------------------
    // 🧠 INTRODUCCIÓN A SVELTE 5 CON TYPESCRIPT
    // ------------------------------------------
    // Svelte 5 usa "runas" para una reactividad clara y tipada.
    // TypeScript ayuda a detectar errores en tiempo de compilación.
  
    import { $state, $effect, $computed, $props, $derived } from 'svelte';
  
    // ------------------------------------------
    // 🌀 $state: Declaración de estado reactivo tipado
    // ------------------------------------------
    const count = $state<number>(0);
  
    type User = {
      name: string;
      age: number;
    };
  
    const user = $state<User>({ name: 'Alice', age: 25 });
  
    // ------------------------------------------
    // 🔁 $effect: Efectos secundarios reactivos
    // ------------------------------------------
    $effect(() => {
      console.log('Count ha cambiado:', count);
    });
  
    // ------------------------------------------
    // 🧮 $computed: Derivar valores reactivamente
    // ------------------------------------------
    const double = $computed<number>(() => count * 2);
  
    // ------------------------------------------
    // 📦 $props: Acceder a props de forma reactiva
    // ------------------------------------------
    const { title } = $props<{ title: string }>();
  
    // ------------------------------------------
    // 🔄 $derived: Combinar múltiples estados
    // ------------------------------------------
    const summary = $derived<string, [number, User]>(
      [count, user],
      ([c, u]) => `Hola ${u.name}, el contador está en ${c}`
    );
  
    // ------------------------------------------
    // 📤 FUNCIONES DE MANEJO TIPADAS
    // ------------------------------------------
    function increment(): void {
      count++;
    }
  
    function changeName(newName: string): void {
      user.name = newName;
    }
  </script>
  
  <!-- ------------------------------------------
  📄 INTERFAZ DE USUARIO
  ------------------------------------------ -->
  <h1>{title}</h1>
  <p>Contador: {count}</p>
  <p>Doble: {double}</p>
  <p>{summary}</p>
  
  <button on:click={increment}>Incrementar</button>
  <button on:click={() => changeName('Bob')}>Cambiar nombre</button>
  
  <!-- ------------------------------------------
  🎯 NOTAS FINALES
  ------------------------------------------
  - `lang="ts"` habilita TypeScript en el componente.
  - Tipar las runas mejora el autocompletado y la detección de errores.
  - Puedes combinar tipos simples, objetos e incluso arrays con reactividad.
  -->
  