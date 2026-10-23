-- PLATA · la carta: el precio de cada bebida SIN IVA, tal y como lo manda la empresa.
-- Es la referencia contra la que comprobamos lo que cobra el TPV (test precio_cuadra_con_carta).
select
    trim(bebida)                 as bebida,
    precio_sin_iva_eur::double   as precio_sin_iva_eur
from {{ source('bronce', 'carta') }}
