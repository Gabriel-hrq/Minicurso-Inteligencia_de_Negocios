with source as (

    select * from {{ source('sistema_gerencial', 'fazenda') }}

),

renamed as (

    select
        id_fazenda,
        nome,
        endereco,
        cidade,
        estado,
        area_total_ha

    from source

)

select * from renamed