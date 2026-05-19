# Context for Claude Code

## What We're Working On
Implementing weighted phrasing endorsement UI (like Because/Therefore/Rebuttal weighting)

## Key Files Being Modified
- `/Users/Razzmatazz/localHost/root/index.php` - lines 453-484 (phrasing modal)
- `/Users/Razzmatazz/localHost/root/script_vestigette.js` - added bumpPhrasing() function
- `/Users/Razzmatazz/localHost/root/functions.php` - added weighPhrasing case
- Database: getAltPhrasing stored procedure needs updating

## Current Problem
getAltPhrasing(50) returns 0 results even though 5 phrasings exist because:
- All PHRASE_ENDORSE records for arg 50 have active=0
- Current procedure only shows phrasings with active endorsements
- Need to show ALL phrasings, with endorsement data if it exists

## Solution Needed
Modify getAltPhrasing to:
```sql
SELECT 
    COALESCE(SUM(E.weight), 0) as totalWeight, 
    COUNT(E.profileID) as endorsementCount,
    P.phrasing, 
    P.phrasingID
FROM PHRASING P
LEFT JOIN PHRASE_ENDORSE E ON P.phrasingID = E.phrasingID 
    AND E.argumentID = argID AND E.active = TRUE
WHERE P.argumentID = argID
GROUP BY P.phrasingID, P.phrasing
ORDER BY totalWeight DESC, endorsementCount DESC;
```

## Test Case
- Go to http://localhost/index.php?arg=50
- Login as profileID 28
- Click Accept
- Click pencil icon (phrasing modal)
- Should see 5 phrasings
- Click "Weigh In"
- Click circles to weight
- Click "Endorse"
- Verify weights saved to PHRASE_ENDORSE

## Database State
- MAMP MySQL on localhost:3306
- Database: vestigette
- 1,701 arguments, 1,762 phrasings
- Weighted system implemented for arguments (working)
- Weighted system for phrasings (in progress)
