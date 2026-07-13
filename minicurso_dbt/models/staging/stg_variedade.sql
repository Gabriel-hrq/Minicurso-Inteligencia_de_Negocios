with source as (

    select * from {{ source('sistema_gerencial', 'variedade') }}

),

renamed as (

    select
        id_variedade,
        id_cultura,
        nome,
        ciclo_dias,
        potencial_produtivo_kg_ha

    from source

)

select * from renamed