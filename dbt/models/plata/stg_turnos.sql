-- PLATA · turnos: cuántos baristas hay programados en cada franja de dos horas.
-- Pasamos las horas de texto ('07:00') a hora entera (7) para poder cruzarlas con la hora de cada ticket.
select
    hour(franja_inicio::time)    as hora_inicio,
    hour(franja_fin::time)       as hora_fin,
    baristas::integer            as baristas
from {{ source('bronce', 'turnos') }}
