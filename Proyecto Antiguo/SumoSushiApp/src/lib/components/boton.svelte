<script lang="ts">
    const { clase = "", texto = "", tipo = "button", onClick = () => {} } = $props<{
      clase?: string;
      texto?: string;
      tipo?: string;
      onClick?: () => void;
    }>();
  </script>
  
  <button 
    class={clase} 
    type={tipo}
    onclick={onClick}>
    {texto}
  </button>
  
  <style>
    .btn {
        width:95%;
        padding: 15px;
        background-color: var(--color-principal);
        border-radius: var(--border-radius);
        cursor: pointer;
        text-align: center;
        font-weight: 700;
    }
  
    .btn--cancelar {
        background-color: var(--color-fondo-secundario);
    }

    .btn--oscuro{
      background-color: var(--color-fondo-principal);
    }
  </style>
  