-- ORO · dimensión barista: una fila por cada valor distinto de barista en el parte limpio.
select distinct barista
from {{ ref('stg_parte') }}
order by barista
