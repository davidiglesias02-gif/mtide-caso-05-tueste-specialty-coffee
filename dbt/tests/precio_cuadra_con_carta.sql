-- TEST PROTAGONISTA · regla de negocio: el precio medio por taza de cada bebida tiene que
-- cuadrar con la carta (precio sin IVA) con un margen de ±2 %.
-- Devuelve las bebidas que se salen del margen: si devuelve alguna fila, el test falla.
with cobrado as (
    select bebida,
           sum(importe_eur) / sum(tazas) as precio_medio_taza
    from {{ ref('stg_parte') }}
    group by bebida
)
select
    c.bebida,
    round(c.precio_medio_taza, 3)                                  as precio_medio_taza,
    k.precio_sin_iva_eur,
    round(100 * (c.precio_medio_taza / k.precio_sin_iva_eur - 1), 1) as desvio_pct
from cobrado c
join {{ ref('stg_carta') }} k using (bebida)
where abs(c.precio_medio_taza / k.precio_sin_iva_eur - 1) > 0.02
