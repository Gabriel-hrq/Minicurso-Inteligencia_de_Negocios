with source as (

    select * from {{ source('sistema_gerencial', 'plantio') }}

),

renamed as (

    select
        id_plantio,
        id_talhao,
        id_variedade,
        id_safra,
        data_inicio_prevista,
        data_fim_prevista,
        data_inicio,
        data_fim,
        area_planejada_ha,
        area_real_ha,
        finalizado

    from source

)

select * from renamed