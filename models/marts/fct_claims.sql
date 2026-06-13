{{ config(
    materialized='incremental',
    unique_key= "claim_id"
) }}

SELECT *
FROM {{ ref('int_claims_enriched') }}

{% if is_incremental()%}
where submitted_date >
    (
        select max(submitted_date) 
        from {{this}}
    )
{% endif %}

