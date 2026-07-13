with source as (

    select * from {{ source('sistema_gerencial', 'colheita') }}

),

renamed as (

    select
        id_colheita,
        id_plantio,
        data_inicio,
        data_fim,
        quantidade_colhida_kg,
        area_colhida_ha

    from source

)

select * from renamed