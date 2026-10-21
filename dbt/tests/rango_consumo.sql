-- gramos_cafe tiene que estar en un rango creíble para este negocio (7.4 a 140.8).
select ticket, gramos_cafe from {{ ref('stg_parte') }}
where gramos_cafe not between 7.4 and 140.8
