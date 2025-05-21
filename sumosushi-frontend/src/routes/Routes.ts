import Home from './Home.svelte';
import Login from './Login.svelte';
import { push } from 'svelte-spa-router';

// Rutas centralizadas
export const ROUTE_PATHS = {
  HOME: '/',
  LOGIN: '/login',
  NOT_FOUND: '*'
} as const;

// Rutas para el router
export const routes = {
  [ROUTE_PATHS.HOME]: Home,
  [ROUTE_PATHS.LOGIN]: Login,
  [ROUTE_PATHS.NOT_FOUND]: Home
};

// Funciones para navegación programática
export const goToHome = () => push(ROUTE_PATHS.HOME);
export const goToLogin = () => push(ROUTE_PATHS.LOGIN);

