-- ORO · control de calidad del parte: una fila por entrega (fecha_carga), la más reciente primero.
-- Sirve para que el portal cite con marcas cuántas filas llegaron y cuántas hubo que corregir.
select
    fecha_carga,
    count(*)                                          as pedidos,
    min(fecha)                                        as primer_dia,
    max(fecha)                                        as ultimo_dia,
    count(*) filter (where importe_con_iva)           as filas_importe_con_iva,
    min(fecha) filter (where importe_con_iva)         as primer_dia_con_iva,
    count(*) filter (where tazas_corregido)           as filas_tazas_corregidas
from {{ ref('stg_parte') }}
group by fecha_carga
order by fecha_carga desc
