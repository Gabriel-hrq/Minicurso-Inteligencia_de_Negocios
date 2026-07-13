with colheita as (

    select * from {{ ref('stg_colheita') }}

),

plantio as (

    select * from {{ ref('stg_plantio') }}

),

variedade as (

    select * from {{ ref('stg_variedade') }}

),

joined as (

    select
        colheita.id_colheita,
        plantio.id_talhao,
        plantio.id_variedade,
        variedade.id_cultura,
        plantio.id_safra,

        colheita.data_inicio as data_inicio_colheita,
        colheita.data_fim as data_fim_colheita,

        {{ unidade_produtividade('variedade.id_cultura') }} as unidade_produtividade,

        colheita.quantidade_colhida_kg,
        colheita.quantidade_colhida_kg / {{ fator_conversao_kg('variedade.id_cultura') }}
            as quantidade_colhida_unidade_padrao,

        colheita.area_colhida_ha,
        plantio.area_real_ha as area_plantada_ha,

        colheita.quantidade_colhida_kg / nullif(colheita.area_colhida_ha, 0)
            as produtividade_kg_ha,

        (colheita.quantidade_colhida_kg / {{ fator_conversao_kg('variedade.id_cultura') }})
            / nullif(colheita.area_colhida_ha, 0)
            as produtividade_unidade_padrao_ha,

        colheita.area_colhida_ha / nullif(plantio.area_real_ha, 0)
            as pct_area_colhida

    from colheita
    left join plantio on colheita.id_plantio = plantio.id_plantio
    left join variedade on plantio.id_variedade = variedade.id_variedade

)

select * from joined