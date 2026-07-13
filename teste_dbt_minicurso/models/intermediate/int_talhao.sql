with talhao as (

    select * from {{ ref('stg_talhao') }}

),

split_codigo as (

    select
        id_talhao,
        id_fazenda,
        trim(split_part(codigo, ' - ', 1)) as fazenda,
        trim(split_part(codigo, ' - ', 2)) as talhao,
        area_ha,
        irrigado,
        tipo_irrigacao

    from talhao

)

select * from split_codigo