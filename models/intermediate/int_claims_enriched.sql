SELECT
    {{ dbt_utils.generate_surrogate_key(["c.claim_id",'c.patient_id']) }} as claim_sk,
    c.*,
    {{ clean_text('p.first_name') }} as first_name,
    {{ clean_text('p.last_name') }}  as last_name,
    p.dob,
    p.gender,
    e.encounter_type,
    e.provider_id
FROM {{ref('stg_claims')}} c
LEFT JOIN  {{ref("stg_patients")}} p using(patient_id) 
LEFT JOIN {{ref("stg_encounters")}} e using (encounter_id) 