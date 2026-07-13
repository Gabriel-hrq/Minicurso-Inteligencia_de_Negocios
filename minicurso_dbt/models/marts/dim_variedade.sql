with variedade as (

    select * from {{ ref('stg_variedade') }}

)

select
    id_variedade,
    id_cultura,
    nome,
    ciclo_dias,
    potencial_produtivo_kg_ha

from variedade