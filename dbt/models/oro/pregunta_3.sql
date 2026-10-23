-- ORO · Pregunta 3: ¿qué cafetera acumula más incidencias por cada 100 tazas? (de mayor a menor)
select
    cafetera,
    round(100.0 * count(*) filter (where con_incidencia) / sum(tazas), 2)   as incidencias_100tazas,
    count(*) filter (where con_incidencia)                                 as incidencias,
    sum(tazas)::integer                                                    as tazas
from {{ ref('fact_pedidos') }}
group by cafetera
order by incidencias_100tazas desc
