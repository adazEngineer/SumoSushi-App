
import { writable } from 'svelte/store';

interface DetalleProducto {
    Visible: boolean;
    IdProducto: number | null;
}

export const detalleProducto = writable<DetalleProducto>({
    Visible: false,
    IdProducto: null
});

export function mostrarDetalle(IdProducto: number) {
    detalleProducto.set({ Visible: true, IdProducto });
}

export function ocultarDetalle() {
    detalleProducto.set({ Visible: false, IdProducto: null });
}