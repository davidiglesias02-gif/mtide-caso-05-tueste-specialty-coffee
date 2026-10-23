-- ORO · Pregunta 1: ¿qué bebida deja menos ingreso por taza? (€ sin IVA por taza, de menor a mayor)
select
    bebida,
    round(sum(importe_eur) / sum(tazas), 3)   as ingreso_taza,
    sum(tazas)::integer                       as tazas
from {{ ref('fact_pedidos') }}
group by bebida
order by ingreso_taza asc
