with plantio as (

    select * from {{ ref('int_plantio') }}

)

select
    id_plantio,
    id_talhao,
    id_variedade,
    id_cultura,
    id_safra,
    data_inicio_prevista,
    data_fim_prevista,
    data_inicio_real,
    data_fim_real,
    area_planejada_ha,
    area_real_ha,
    data_fim_colheita_real,
    data_fim_colheita_planejada,
    status_cronograma

from plantio