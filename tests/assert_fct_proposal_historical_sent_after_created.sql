SELECT
    id,
    proposal_sent_date,
    created_date
FROM {{ ref('fct_proposals_historical') }}
WHERE proposal_sent_date IS NOT NULL
  AND proposal_sent_date < created_date
