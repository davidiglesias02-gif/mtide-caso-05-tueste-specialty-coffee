-- ORO · Pregunta 2: ¿qué barista gasta más café por taza? (gramos por taza, de mayor a menor)
select
    barista,
    round(sum(gramos_cafe) / sum(tazas), 2)   as g_taza,
    sum(tazas)::integer                       as tazas
from {{ ref('fact_pedidos') }}
group by barista
order by g_taza desc
