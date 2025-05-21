import { writable } from 'svelte/store';

interface Producto {
    IdProducto: number;
    Nombre: string;
    Precio: number;
    Descripcion: string;
    ImagenUrl: string;
    Etiquetas: string[];  // Etiquetas disponibles: "picante", "vegetariano"
}

interface Categoria {
    NombreCategoria: string;
    Productos: Producto[];
}

export const menu = writable<Categoria[]>([
    {
        NombreCategoria: "Sushi",
        Productos: [
            {
                IdProducto: 1,
                Nombre: "Sushi de Salmón",
                Precio: 5500,
                Descripcion: "Sushi de salmón fresco con arroz de calidad.",
                ImagenUrl: "img/producto1.png",
                Etiquetas: []
            },
            {
                IdProducto: 2,
                Nombre: "Sushi de Atún",
                Precio: 5000,
                Descripcion: "Sushi de atún fresco acompañado de aguacate y arroz.",
                ImagenUrl: "img/producto2.png",
                Etiquetas: []  
            },
            {
                IdProducto: 3,
                Nombre: "Sushi Vegetariano",
                Precio: 4500,
                Descripcion: "Sushi de vegetales frescos como pepino, zanahoria y aguacate.",
                ImagenUrl: "img/producto3.png",
                Etiquetas: ["vegetariano", "picante"]
            }
        ]
    },
    {
        NombreCategoria: "Especialidades",
        Productos: [
            {
                IdProducto: 4,
                Nombre: "Ramen de Cerdo",
                Precio: 6000,
                Descripcion: "Sopa de ramen con cerdo, huevo y verduras.",
                ImagenUrl: "img/producto4.png",
                Etiquetas: ["picante"]  
            },
            {
                IdProducto: 5,
                Nombre: "Tempura de Camarones",
                Precio: 4700,
                Descripcion: "Camarones empanizados y fritos, servidos con salsa.",
                ImagenUrl: "img/producto5.png",
                Etiquetas: [] 
            },
            {
                IdProducto: 6,
                Nombre: "Ternera a la Plancha",
                Precio: 3500,
                Descripcion: "Ternera cocinada a la plancha con salsa teriyaki y arroz.",
                ImagenUrl: "img/producto1.png",
                Etiquetas: []  
            }
        ]
    },
    {
        NombreCategoria: "Combos",
        Productos: [
            {
                IdProducto: 7,
                Nombre: "Combo Sushi 12 piezas",
                Precio: 5000,
                Descripcion: "12 piezas de sushi variados (atún, salmón, aguacate).",
                ImagenUrl: "img/producto2.png",
                Etiquetas: []  
            },
            {
                IdProducto: 8,
                Nombre: "Combo Ramen y Sushi",
                Precio: 4750,
                Descripcion: "Un ramen de cerdo acompañado de 6 piezas de sushi.",
                ImagenUrl: "img/producto3.png",
                Etiquetas: ["picante"]  
            },
            {
                IdProducto: 9,
                Nombre: "Combo Familiar",
                Precio: 5250,
                Descripcion: "2 ramen, 2 temaki y 18 piezas de sushi.",
                ImagenUrl: "img/producto4.png",
                Etiquetas: []  
            }
        ]
    },
    {
        NombreCategoria: "Bebidas",
        Productos: [
            {
                IdProducto: 10,
                Nombre: "Té Verde",
                Precio: 1500,
                Descripcion: "Refresco natural de té verde servido frío.",
                ImagenUrl: "img/producto5.png",
                Etiquetas: [] 
            },
            {
                IdProducto: 11,
                Nombre: "Soda de Lichi",
                Precio: 2000,
                Descripcion: "Soda refrescante de sabor lichi.",
                ImagenUrl: "img/producto1.png",
                Etiquetas: [] 
            },
            {
                IdProducto: 12,
                Nombre: "Agua Mineral",
                Precio: 1250,
                Descripcion: "Agua mineral refrescante.",
                ImagenUrl: "img/producto2.png",
                Etiquetas: []  
            }
        ]
    }
]);
