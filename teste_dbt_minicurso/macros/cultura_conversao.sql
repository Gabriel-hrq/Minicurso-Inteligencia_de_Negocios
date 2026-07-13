{% macro fator_conversao_kg(id_cultura_column) %}
    case {{ id_cultura_column }}
        when 1 then 60   -- Soja (sc/ha)
        when 2 then 60   -- Milho (sc/ha)
        when 3 then 15   -- Algodão (@/ha)
        when 4 then 60   -- Feijão (sc/ha)
        when 5 then 30   -- Trigo (bu/ha)
        when 6 then 60   -- Arroz (sc/ha)
        when 7 then 1    -- Sorgo (kg/ha)
    end
{% endmacro %}

{% macro unidade_produtividade(id_cultura_column) %}
    case {{ id_cultura_column }}
        when 1 then 'sc/ha'
        when 2 then 'sc/ha'
        when 3 then '@/ha'
        when 4 then 'sc/ha'
        when 5 then 'bu/ha'
        when 6 then 'sc/ha'
        when 7 then 'kg/ha'
    end
{% endmacro %}