with talhao as (

    select * from {{ ref('int_talhao') }}

),

fazenda as (

    select * from {{ ref('stg_fazenda') }}

),

joined as (

    select
        talhao.id_talhao,
        talhao.id_fazenda,
        talhao.fazenda,
        talhao.talhao as nome_talhao,
        talhao.area_ha,
        talhao.irrigado,
        talhao.tipo_irrigacao,
        fazenda.endereco,
        fazenda.cidade,
        fazenda.estado,
        fazenda.area_total_ha as area_total_fazenda_ha

    from talhao
    left join fazenda
        on talhao.id_fazenda = fazenda.id_fazenda

)

select * from joined