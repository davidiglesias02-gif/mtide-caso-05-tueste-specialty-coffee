-- ORO · hecho: un pedido (ticket) por fila, rodeado de las dimensiones barista, cafetera y bebida.
-- importe_eur va sin IVA en todo el parte (ver el arreglo de la remesa en stg_parte).
select
    ticket,
    fecha,
    barista,
    cafetera,
    bebida,
    tazas,
    gramos_cafe,
    importe_eur,
    incidencia is not null and trim(incidencia) <> ''   as con_incidencia
from {{ ref('stg_parte') }}
