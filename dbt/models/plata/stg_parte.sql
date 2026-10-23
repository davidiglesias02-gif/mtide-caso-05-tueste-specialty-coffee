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
    -- ARREGLO REMESA 2026-03-31: a mitad de la remesa se cambió el TPV y, desde el 2026-03-26,
    -- importe_eur llega CON IVA (21 %): el importe por taza sale un 21 % por encima de la carta, que
    -- va sin IVA, mientras que hasta el 25 cuadraba. Ningún test básico lo veía (el número es válido),
    -- lo destapó el test precio_cuadra_con_carta. Lo pasamos a sin IVA dividiendo entre 1,21 para que
    -- todo el parte use el mismo criterio que la carta. Se arregla aquí y no en bronce, que guarda lo
    -- que llegó; importe_con_iva marca las filas que hemos recalculado.
    round(case when s.fecha::date >= date '2026-03-26' then s.importe_eur::double / 1.21
               else s.importe_eur::double end, 2)              as importe_eur,
    s.fecha::date >= date '2026-03-26'                         as importe_con_iva,
    s.incidencia,
    s.archivo,
    s.fecha_carga
from sin_dup s
join mediana_bebida m using (bebida)
