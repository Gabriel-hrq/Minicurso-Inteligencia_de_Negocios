with safra as (

    select * from {{ ref('stg_safra') }}

)

select
    id_safra,
    nome,
    data_inicio,
    data_fim

from safra