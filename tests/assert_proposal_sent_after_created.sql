SELECT
    id,
    proposal_sent_date,
    created_date
FROM {{ ref('stg_proposals') }}
WHERE proposal_sent_date IS NOT NULL
  AND proposal_sent_date < created_date
