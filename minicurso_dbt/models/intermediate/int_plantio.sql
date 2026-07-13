with plantio as (

    select * from {{ ref('stg_plantio') }}

),

variedade as (

    select * from {{ ref('stg_variedade') }}

),

colheita_agregada as (

    select
        id_plantio,
        max(data_fim) as data_fim_colheita_real

    from {{ ref('stg_colheita') }}
    group by id_plantio

),

joined as (

    select
        plantio.id_plantio,
        plantio.id_talhao,
        plantio.id_variedade,
        variedade.id_cultura,
        plantio.id_safra,

        plantio.data_inicio_prevista,
        plantio.data_fim_prevista,
        plantio.data_inicio as data_inicio_real,
        plantio.data_fim as data_fim_real,

        plantio.area_planejada_ha,
        plantio.area_real_ha,

        colheita_agregada.data_fim_colheita_real,
        plantio.data_fim_prevista + variedade.ciclo_dias as data_fim_colheita_planejada,

        case
            when colheita_agregada.data_fim_colheita_real is not null then 'colhido'
            else 'em_andamento'
        end as status_cronograma

    from plantio
    left join variedade
        on plantio.id_variedade = variedade.id_variedade
    left join colheita_agregada
        on plantio.id_plantio = colheita_agregada.id_plantio

)

select * from joined