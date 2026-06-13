select * from {{ref("stg_claims")}}
where paid_amount < 0