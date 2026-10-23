-- ORO · dimensión bebida: una fila por cada valor distinto de bebida en el parte limpio.
select distinct bebida
from {{ ref('stg_parte') }}
order by bebida
