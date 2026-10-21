-- PLATA · el parte diario limpio: la limpieza que hiciste en la J3, ahora como modelo dbt.
-- Cada entrega del parte es una carpeta fecha_carga=… en bronce: aquí se leen todas juntas.
with bruto as (
    select *, parse_filename(filename) as archivo
    from {{ source('bronce', 'parte') }}
),
sin_dup as (
    -- una fila por ticket
    select * from bruto
    qualify row_number() over (partition by ticket order by fecha_carga desc) = 1
),
mediana_bebida as (
    select bebida, median(tazas::integer) as tazas_mediana
    from sin_dup
    where tazas::integer between 1 and 20
    group by bebida
)
select
    s.ticket,
    s.fecha::date                                              as fecha,
    upper(trim(s.barista))                                         as barista,
    s.cafetera,
    s.bebida,
    case when s.tazas::integer between 1 and 20 then s.tazas::integer
         else round(m.tazas_mediana)::integer end               as tazas,
    not (s.tazas::integer between 1 and 20)                   as tazas_corregido,
    s.gramos_cafe::double                                              as gramos_cafe,
    s.importe_eur::double                                      as importe_eur,
    s.incidencia,
    s.archivo,
    s.fecha_carga
from sin_dup s
join mediana_bebida m using (bebida)
