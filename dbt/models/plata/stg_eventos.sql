-- PLATA · registro de tickets del TPV del 2026-04-02: una línea por ticket, a la hora en que se cobró.
-- Lo exploramos antes de modelarlo: 391 líneas y 391 ticket_id distintos (sin duplicados ni eventos de
-- varias fases), todo del mismo día entre las 07:01 y las 18:55. Aun así nos quedamos con una fila por
-- ticket por si el TPV reenvía alguno en otra exportación.
-- EL GIRO: los tickets llegan a ráfagas (de 8 a 10 y de 13 a 14 entra entre el triple y seis veces más que el resto del
-- día). Por eso guardamos la hora de cada ticket: la pregunta 4 se contesta hora a hora y no con la media.
select
    ticket_id                     as ticket,
    ts::timestamp                 as ts,
    hour(ts::timestamp)           as hora,
    trim(bebida)                  as bebida,
    tazas::integer                as tazas,
    upper(trim(barista))          as barista
from {{ source('bronce', 'eventos') }}
qualify row_number() over (partition by ticket_id order by ts) = 1
