<script lang="ts">
  import './styles/variables.css';
  import './styles/reset.css';
  import './styles/global.css';

  import Router from 'svelte-spa-router';
  import { routes } from './routes/Routes'; 
</script>

<main>
  <Router {routes} />
</main>