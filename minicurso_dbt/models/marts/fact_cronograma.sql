with plantio as (

    select * from {{ ref('int_plantio') }}

)

select
    id_plantio,
    id_talhao,
    id_variedade,
    id_cultura,
    id_safra

from plantio