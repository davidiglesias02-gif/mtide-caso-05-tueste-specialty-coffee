-- ORO · dimensión cafetera: una fila por cada valor distinto de cafetera en el parte limpio.
select distinct cafetera
from {{ ref('stg_parte') }}
order by cafetera
