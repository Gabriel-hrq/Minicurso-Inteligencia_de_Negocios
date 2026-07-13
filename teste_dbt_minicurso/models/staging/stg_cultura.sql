with source as (

    select * from {{ source('sistema_gerencial', 'cultura') }}

),

renamed as (

    select
        id_cultura,
        nome,
        ciclo_medio_dias

    from source

)

select * from renamed