with fazenda as (

    select * from {{ ref('stg_fazenda') }}

)

select
    id_fazenda,
    nome,
    endereco,
    cidade,
    estado,
    area_total_ha

from fazenda