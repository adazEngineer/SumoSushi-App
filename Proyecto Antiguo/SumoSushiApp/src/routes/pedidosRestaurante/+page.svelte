<script lang="ts">
    import Encabezado from '../../lib/components/Encabezado.svelte';
    import Boton from '../../lib/components/boton.svelte';
  
    type Producto = {
      nombre: string;
      cantidad: number;
    };
  
    type Pedido = {
      numero: number;
      tipo: 'llevar' | 'retirar';
      cliente: string;
      productos: Producto[];
      estado: 'pendiente' | 'aceptado' | 'cancelado';
    };
  
    export let pedidos: Pedido[] = [
      {
        numero: 101,
        tipo: 'llevar',
        cliente: 'Carlos Pérez',
        productos: [
          { nombre: 'Sushi de salmón', cantidad: 2 },
          { nombre: 'Rollo California', cantidad: 1 },
          { nombre: 'Agua mineral', cantidad: 3 }
        ],
        estado: 'pendiente'
      },
      {
        numero: 102,
        tipo: 'retirar',
        cliente: 'Laura Gómez',
        productos: [
          { nombre: 'Ramen miso', cantidad: 1 },
          { nombre: 'Té verde', cantidad: 2 }
        ],
        estado: 'pendiente'
      },
      {
        numero: 103,
        tipo: 'llevar',
        cliente: 'Andrés Ramírez',
        productos: [
          { nombre: 'Yakimeshi', cantidad: 2 },
          { nombre: 'Gyozas', cantidad: 1 }
        ],
        estado: 'pendiente'
      }
    ];
  
    const aceptar = (numero: number) => {
      console.log(`Aceptar pedido ${numero}`);
    };
  
    const cancelar = (numero: number) => {
      console.log(`Cancelar pedido ${numero}`);
    };
  </script>
  
  <Encabezado />
  
  <div class="contenedor-principal">
    <section class="pedidos">
      <h2 class="pedidos__titulo">Pedidos entrantes</h2>
  
      {#if pedidos.length === 0}
        <p>No hay pedidos nuevos.</p>
      {/if}
  
      {#each pedidos as pedido}
        <div class="pedidos__card">
          <div class="pedidos__info">
            <div class="pedidos__encabezado">
                <h3 class="pedidos__numero">Pedido #{pedido.numero}</h3>
                <p>06:57pm</p>
            </div>            
            <p class="pedidos__detalle"><strong>Tipo:</strong> {pedido.tipo}</p>
            <p class="pedidos__detalle"><strong>Cliente:</strong> {pedido.cliente}</p>
            <p class="pedidos__detalle">
              <strong>Productos:</strong>
              {#each pedido.productos as producto, i}
                {producto.cantidad}x {producto.nombre}{i < pedido.productos.length - 1 ? ' / ' : ''}
              {/each}
            </p>
            <p><strong>Nota: </strong></p>
            <p class="pedidos__detalle"><strong>Estado:</strong> {pedido.estado}</p>
          </div>
          <div class="pedidos__acciones">
            <Boton texto="Cancelar" onClick={() => cancelar(pedido.numero)} clase="btn" />
            <Boton texto="Aceptar" onClick={() => aceptar(pedido.numero)} clase="btn btn--oscuro" />
          </div>
        </div>
      {/each}
    </section>
  </div>
  
  <style>
    .pedidos {
      width: 100%;
      max-width: 900px;
      padding: 2rem;
    }

    .pedidos__encabezado{
        display:flex;
        justify-content: space-between;
    }
  
    .pedidos__titulo {
      margin-bottom: 2rem;
      text-align: center;
    }
  
    .pedidos__card {
      background-color: var(--color-fondo-secundario);
      border-radius: var(--border-radius);
      padding: 2rem;
      margin-bottom: 2rem;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    }
  
    .pedidos__numero {
      margin-bottom: 1rem;
    }
  
    .pedidos__detalle {
      margin: 0.5rem 0;
    }
  
    .pedidos__acciones {
      width: 100%;
      margin-top: 1.5rem;
      display: flex;
      gap: 1.5rem;
    }
  </style>
  