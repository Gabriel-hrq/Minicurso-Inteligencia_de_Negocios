with source as (

    select * from {{ source('sistema_gerencial', 'safra') }}

),

renamed as (

    select
        id_safra,
        nome,
        data_inicio,
        data_fim

    from source

)

select * from renamed