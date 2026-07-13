with cultura as (

    select * from {{ ref('stg_cultura') }}

)

select
    id_cultura,
    nome,
    ciclo_medio_dias,
    {{ unidade_produtividade('id_cultura') }} as unidade_produtividade,
    {{ fator_conversao_kg('id_cultura') }} as fator_conversao_kg

from cultura