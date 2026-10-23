-- ORO · Pregunta 4: ¿a qué hora faltan más baristas?
-- Supuesto del encargo: un barista prepara 30 tazas por hora.
-- Nivel de respuesta: UNA FILA POR HORA. Llevamos cada parte a ese nivel por separado y después las unimos:
--   · demanda: tazas de los tickets del TPV en esa hora (no la media del día: los tickets llegan a ráfagas);
--   · oferta: baristas del turno cuya franja de dos horas contiene esa hora.
with demanda as (
    select hora, count(*) as tickets, sum(tazas)::integer as tazas
    from {{ ref('stg_eventos') }}
    group by hora
),
oferta as (
    select d.hora, t.baristas as baristas_turno
    from demanda d
    join {{ ref('stg_turnos') }} t on d.hora >= t.hora_inicio and d.hora < t.hora_fin
),
medias as (
    -- lo que saldría sin tener en cuenta el giro: la media de tazas por hora del día entero
    select sum(tazas) / count(*) as tazas_hora_media_dia from demanda
)
select
    lpad(d.hora::varchar, 2, '0') || ':00'                       as hora,
    d.tickets,
    d.tazas,
    ceil(d.tazas / 30.0)::integer                                as baristas_necesarios,
    o.baristas_turno,
    greatest(ceil(d.tazas / 30.0)::integer - o.baristas_turno, 0) as baristas_que_faltan,
    round(m.tazas_hora_media_dia, 1)                             as tazas_hora_media_dia,
    ceil(m.tazas_hora_media_dia / 30.0)::integer                 as baristas_necesarios_con_media
from demanda d
join oferta o using (hora)
cross join medias m
order by baristas_que_faltan desc, d.tazas desc
