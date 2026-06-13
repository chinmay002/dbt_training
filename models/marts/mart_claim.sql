{{ config(materialized = "table")}}


{% set metrics = ["billed_amount","allowed_amount","paid_amount"]%}




select
    claim_status,

    count(*) as claim_count,


    {% for col in metrics%}
        SUM({{col}}) as total_{{col}}
    {%if not loop.last%},{%endif%}

    {% endfor %},

    -- sum(billed_amount) as total_billed_amount,
    -- sum(allowed_amount) as total_allowed_amount,
    -- sum(paid_amount) as total_paid_amount,

    -- avg(paid_amount) as avg_paid_amount,

    sum(
        case
            when claim_status = 'Denied' then 1
            else 0
        end
    ) as denial_claim_count

from {{ ref('int_claims_enriched') }}

group by claim_status