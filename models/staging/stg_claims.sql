select
 *
from {{ source('healthcare', 'claims') }}