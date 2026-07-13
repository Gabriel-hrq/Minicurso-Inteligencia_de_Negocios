with colheita as (

    select * from {{ ref('int_colheita') }}

)

select
    id_colheita,
    id_talhao,
    id_variedade,
    id_cultura,
    id_safra,
    data_inicio_colheita,
    data_fim_colheita,
    unidade_produtividade,
    quantidade_colhida_kg,
    quantidade_colhida_unidade_padrao,
    area_colhida_ha,
    area_plantada_ha,
    produtividade_kg_ha,
    produtividade_unidade_padrao_ha,
    pct_area_colhida

from colheita