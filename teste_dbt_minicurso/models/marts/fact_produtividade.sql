with colheita as (

    select * from {{ ref('int_colheita') }}

)

select
    id_colheita,
    id_talhao,
    id_variedade,
    id_cultura,
    id_safra

from colheita