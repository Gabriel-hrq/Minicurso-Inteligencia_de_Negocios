with source as (

    select * from {{ source('sistema_gerencial', 'talhao') }}

),

renamed as (

    select
        id_talhao,
        id_fazenda,
        codigo,
        area_ha,
        irrigado,
        tipo_irrigacao

    from source

)

select * from renamed