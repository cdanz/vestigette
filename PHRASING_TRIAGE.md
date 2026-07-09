# Phrasing Cleanup Triage — full corpus pass

> **STATUS: APPLIED 2026-07-09.** All FIX/REWRITE/SPLIT entries below were executed against
> production: 211 triage text edits + 202 mechanical fixes + 18 typo corrections; 46 new
> arguments (2363–2408) coined via `foldInAssertion` by lean-matched personas, plus existing
> arg 533 wired as Because of 536. `ARGUMENT.currentPhrasing` cache fully synced; 100%%
> invariant verified on all touched combinations. New backlog findings moved to
> DATA_CLEANUP_BACKLOG.md (July 2026 addendum).

Verdict key:
- **FIX** — in-place text edit (typo/grammar/style); same claim. `UPDATE PHRASING` (+ currentPhrasing cache sync when starred).
- **REWRITE** — phrasing bundles/drifts; rewrite in place to restate the argument's core claim (other half already exists in graph or is dropped as redundant).
- **SPLIT** — bundled clause is a genuinely separate claim absent from graph; rewrite phrasing AND coin new argument (persona + edge specified).
- **LEAVE** — flagged by pattern but structurally sound (lists, intrinsic contrasts, definitional "x, not y").

(cur) = row is the argument's currentPhrasing → sync ARGUMENT.currentPhrasing after edit.

---

## Chunk 1 (args 9–310)

### FIX (text only)
- **arg 24 / phr 25 (cur)** — grammar ("danger for GMOs leading to"): → "GMOs risk creating species that serve the goals of special interests while diminishing the wider needs of humanity." ("but" here is one intrinsic contrast; no split needed)
- **arg 66 / phr 300** — first-person testimony style: → "A COVID-19 vaccine appointment at any hour of the day, even 3am, is acceptable."
- **arg 125 / phr 135** — typos "Woman", "responsiblity": → "Women should take responsibility for their pregnancies rather than aborting."
- **arg 128 / phr 138 (cur)** — typos "a women's", "acces", agreement: → "Limits on women's access to abortion are cruel punishment."
- **arg 184 / phr 196** — typo "eploited", dash tail: → "The groups most historically exploited in society are also the most systematically disenfranchised from the vote."
- **arg 198 / phr 210 (cur)** — broken dash grammar: → "The marginal reward for each new level of success should grow exponentially."
- **arg 244 / phr 259** — dash: → "Humanity can only move forward as one, leaving no one behind."
- **arg 249 / phr 267** — dash + no period: → "A hoagie is a sandwich made with a roll that is split, not separated."
- **arg 274 / phr 314** — "One" capitalization, two joined claims where alt already atomized: → "Sandwiches are flat in shape, and flatness is one defining characteristic of the category." → simpler: "A sandwich is characteristically flat in shape."
- **arg 310 / phr 352** — broken dash list: → "Some of the dumbest, most irresponsible, and most harmful content is also the most engaging."
- **arg 93 / phr 102 (cur)** — grammar + hedge "by and large": → "The GOP denies that climate change endangers our future." (see SPLIT below for the motive claim in its alts)
- **arg 166 / phr 178 (cur)** — clunky + no period: → "Policing itself doesn't need to change; the system of oversight around it does." (contrastive semicolon retained — the contrast is the position)

### REWRITE (strip to core; other half already in graph or redundant)
- **arg 138 / phr 3240** — "can be articulated, and it does not match the current one" bundles neighbors 195 (articulable) + 137 (doesn't match): → "People broadly agree on what a fair distribution of wealth looks like."
- **arg 138 / phr 3803** — same bundle: → "A truly fair wealth distribution can be described in plain terms."
- **arg 138 / phr 149 (cur)** — demonstrative "is this." with no referent: → "There is a broadly shared ideal of how wealth should be distributed."
- **arg 219 / phr 2565** — editorial tail duplicates arg 539 (QI = shield against accountability): → "Qualified immunity shields officers from civil liability for nearly all on-duty conduct."
- **arg 235 / phr 3422** — throat-clearing first clause: → "Resentment can be a moral response to real injury."

### SPLIT (rewrite + coin new argument)
- **arg 68 / phr 3127** — "followed a compressed timeline but completed every required safety stage"
  - 3127 → "The COVID-19 vaccines completed every required safety stage."
  - NEW ARG: "The COVID-19 vaccines were developed on a far faster timeline than any previous vaccine." — **Rebuttal of 68**, coined by James Jennings (10, R/MAGA; rejects 68, accepts new arg, weight 100%).
- **arg 93 / phrs 2961, 4454** — alts assert the *motive* claim, not the parent claim (phrasing drift)
  - 2961 → "The Republican Party denies that climate change threatens our future." ; 4454 → "The GOP, as a party, denies the danger climate change poses."
  - NEW ARG: "GOP climate denial is driven by political incentive rather than honest scientific doubt." — **Because of 93**, coined by Brianna Barnes (2, D; accepts 93 already; rebalance her Because weights).
- **arg 128 / phr 2741** — main claim + standalone mortality statistic
  - 2741 → "Restricting abortion access is cruel, and the cruelty falls hardest on those least able to bear it." → better fully atomic: "Restricting access to abortion is a cruel punishment."
  - NEW ARG: "Black women die in childbirth at three times the rate of white women." — **Because of 128**, coined by Irene Ingram (9, D; already accepts 128) or Brianna (2); rebalance Because weights.
- **arg 142 / phrs 2111, 4050 (cur)** — "There are two sexes, and biology provides the basis for gender categories" = two claims; parent claim is "There are only two genders."
  - 2111 → "Gender comes in exactly two kinds." ; 4050 → "There are only two genders."
  - NEW ARG A: "There are only two biological sexes." — **Because of 142**, coined by Alfred Anderson (1, R; accepts 142). Note: intersex args 1738–1745 currently rebut 142; they more precisely rebut NEW ARG A — flag for future re-pointing, not this pass.
  - NEW ARG B: "Gender categories are grounded in biological sex." — **Because of 142**, coined by Maria Martinez (13, R; accepts 142). Rebalance both personas' Because weights on 142.
- **arg 165 / phrs 1953, 4187, 4325 (cur)** — triple policy bundle "funded well, trained well, held accountable"
  - Keep bundled phrasing? NO — parent claim is really "improve policing rather than condemn it." Rewrite: 4325 (cur) → "Police departments should be strengthened rather than condemned." ; 1953 → "The right response to police failures is to improve departments, not condemn the institution." ; 4187 → "Fixing policing means investing in departments, not abolishing them."
  - NEW ARG A: "Police departments should be funded well." — Because of 165, coin Frank Fletcher (6, R; accepts 165).
  - NEW ARG B: "Police training should be substantially strengthened." — Because of 165, coin Wendy Walsh (23, R; accepts 165). (Related to existing 148 de-escalation — check find_similar first.)
  - NEW ARG C: "Officers who abuse their position should be held individually accountable." — Because of 165, coin Alfred (1; accepts 165).
  - Also phr 177 (original by28) is two sentences (unions-not-racist + funding/hiring policy): rewrite → "Police departments should be improved through funding and training rather than condemned as racist." ("Police unions themselves are not racist" exists as a distinct claim — related arg 151 rebuts; leave to future pass.)
- **arg 31 / phrs 1795, 3780** — "does not eliminate; relocates beyond oversight" — mechanism worth atomizing
  - 1795 → "Prohibition does not eliminate the thing it targets." ; 3780 → "Prohibition fails to eliminate what it bans."
  - NEW ARG: "Prohibited goods and technologies move to black markets beyond regulatory oversight." — **Because of 31**, coined by Thomas Turner (20, libertarian; accepts 31 — verify opinion, else use 17 Quinn who phrased here).

### LEAVE (pattern hit, structurally fine)
args 9 (4027), 20 (1790 list-and), 24 (3773), 34 (3949/4087), 39, 41, 44 (4097/4243), 58 (2322), 65 (3396/4645), 108 (4742), 115 (2640), 125 (2028/4044/4416), 166 (1954/4744 contrastive), 170 (2262), 171 (2548/4125), 175 (3965), 194 (3250), 215 (2562), 220 (2566), 224 (2218 list), 233 (1929 list), 277 (3447/4630/4654)

### Mechanical sweep (whole corpus, separate batch)
- Add missing terminal periods; trim trailing whitespace (many by28 rows: 227, 231, 187, 206, ...) — generate automatically, review as one list.

## Chunk 2 (args 315–572)

### FIX (text only)
- **arg 406 / phr 451** — dash parentheticals: → "Power, in all forms, will never stop seeking greater power for itself."
- **arg 413 / phr 458** — missing period (list-and is fine): → "Many schools lack the necessary resources to protect students, faculty, and staff from the continued spread of COVID-19."
- **arg 419 / phr 464** — second person, tangled: → "A seller must not make claims about a product that cannot be shown to be true."
- **arg 421 / phr 466** — run-on second person: → "Speech loses its protection the moment it is used to sell a false claim."
- **arg 438 / phr 483** — grammar ("difference in vehicle's axle weight"): → "Pavement damage is proportional to a vehicle's axle weight raised to the fourth power."
- **arg 458 / phr 504** — typo "for against": → "Liberals label things as \"racist\" rather than arguing against them on their merits."
- **arg 515 / phr 562** — dash: → "Chopsticks should be a common option at most eateries, not just those serving Asian cuisine."
- **arg 532 / phr 579** — dash: → "Any government must treat those it governs equally, with no first- or second-class citizens."
- **arg 562 / phr 610** — hedge dashes: → "Most police departments have too many resources."
- **arg 572 / phr 621** — "execute upon": → "Governments should prioritize and efficiently execute valuable public works projects."

### REWRITE (strip to core)
- **arg 334 / phr 4813** — rhetorical double tail: → "Cops with military gear start treating neighborhoods like war zones."
- **arg 353 / phr 2589** — reason clause already in args 351/352: → "\"Reverse racism\" is not a coherent concept."
- **arg 367 / phr 3326** — design claim already in arg 378: → "The social harms of social media are a predictable consequence of its design."
- **arg 438 / phr 2760** — bicycle clause already in arg 431: → "Road damage is determined by axle weight raised to the fourth power."
- **arg 544 / phr 3083** — editorial third sentence: → "Trans men are men and trans women are women."
- **arg 545 / phr 2659** — poverty-cost tail already in args 115/116: → "A six-figure bail for a minor offense extracts a wealth ransom rather than delivering justice."
- **arg 548 / phr 2014 (cur)** — editorial 2nd sentence + repeated "bail funds": → "BLM and Antifa marched together, coordinated bail funds, and shared tactics during the 2020 unrest."

### SPLIT (rewrite + coin new argument)
- **arg 413 / phr 2755 (cur)** — current phrasing drifted to a different claim (chronic underfunding ≠ lacked COVID resources)
  - 2755 → "Schools too often lacked the resources to keep students and staff safe from COVID-19."
  - NEW ARG: "American public schools are chronically underfunded." — **Because of 413**, coin Brianna Barnes (2; accepts 413; rebalance).
- **arg 434 / phr 2885 (cur)** — "not constitutional, only customary, and should be abolished" = fact + policy
  - 2885 → "The 60-vote Senate filibuster should be abolished."
  - NEW ARG: "The Senate filibuster is a procedural custom, not a constitutional requirement." — **Because of 434**, coin Brianna (2; accepts 434; rebalance).
- **arg 536 / phr 583 (cur)** — BDS list is one named policy (keep text), but the presupposed apartheid claim is missing from the graph
  - NEW ARG: "Israel's treatment of Palestinians constitutes apartheid." — **Because of 536**, coin Diana Delgado (4, progressive; accepts 536, weight 100%).
- **arg 541 / phr 2089** — claim + reason
  - 2089 → "Banning books is never justified."
  - NEW ARG: "Bad ideas should be argued against in the open, not hidden." — **Because of 541**, coin Alfred Anderson (1; accepts 541; rebalance).
- **arg 545 / phr 1959 (cur)** — "…not justice — but bail for violent crimes protects the community": second clause is a separate claim, absent from graph
  - 1959 → "A six-figure bail for a petty offense is a wealth tax on getting out, not justice."
  - NEW ARG: "Bail for violent offenses protects the community." — **Rebuttal of 111** (Cash bail should be eliminated), coin Alfred (1; must reject 111 — verify his opinion on 111 first; weight 100%).
- **arg 546 / phr 2934** — reason bundled with claim
  - 2934 → "Black Lives Matter organizers have earned the public's support."
  - NEW ARG: "BLM organizers put their personal safety on the line for their cause." — **Because of 546**, coin Brianna (2; accepts 546; rebalance).
- **arg 547 / phr 2013 (cur)** — $2B statistic + superlative + conclusion in one breath
  - 2013 → "The scale of rioting associated with BLM in 2020 shows it is not a peaceful movement."
  - NEW ARG: "The 2020 riots caused roughly $2 billion in property damage, the costliest civil disturbance in U.S. history." — **Because of 547**, coin James Jennings (10; accepts 547; rebalance).
- **arg 549 / phrs 2015 (cur), 3919, 4431** — violent-extremist claim + fascist-equivalence claim bundled in all three
  - 2015 → "Antifa is a violent extremist organization that assaults people, vandalizes businesses, and attacks police."
  - 3919 → "Antifa assaults people, vandalizes property, and attacks police."
  - 4431 → "Antifa is a violent extremist organization."
  - NEW ARG: "Antifa is morally indistinguishable from the fascists it claims to oppose." — **Therefore of 549**, coin James (10; accepts 549; rebalance Therefore weights).

### LEAVE
args 315 (3815/4353/4525 definitional), 316, 317, 352, 362 (407 list), 364 (409 list), 367 (2294 feature-not-bug), 373, 400 (1840/4058), 406 (1845), 416 (2687), 419 (2068), 434 (484 "Jim Crow filibuster" — realistic voice), 440, 453 (2762), 480 (1876 list), 481, 537, 550 (2660 — contrast is the claim), 551 (all — attribution contrast is the claim), 565, 568 (617 "but"="except", false positive), 572 (2767)

### Backlog additions (not this pass)
- args **436 vs 438** — near-duplicate claims (road wear ∝ axle weight⁴); merge candidates.
- arg 413 has stray bicycle-related edges (431/432/453) — endorsement cross-contamination worth an audit.

## Chunk 3 (args 585–843)

### FIX (text only)
- **arg 590 / phr 639** — wordy dash: → "Social media gives the user an impression of common wisdom that is really just the median position of their unique bubble."
- **arg 598 / phr 647** — garbled dash: → "There is a floor to the standard of living one should be willing to see any fellow human endure."
- **arg 640 / phr 689** — dash appositive: → "Congress must pass HR1, the For The People Act, to reform and protect our right to vote."
- **arg 647 / phr 696** — typo "lessor", broken dashes: → "The Dr. Seuss estate decided that six lesser-known Dr. Seuss works will no longer be published due to offensive content."
- **arg 649 / phr 698** — convoluted: → "Certain caricatures of Black people should be viewed only as racist artifacts of a shameful past."
- **arg 666 / phr 716** — dash: → "H.R. 1319, the American Rescue Plan Act of 2021, is good policy."
- **arg 672 / phr 722 (cur)** — garbled comparative: → "School boards should be appointed by local government rather than independent of it."
- **arg 674 / phr 724 (cur)** — dashes: → "Scientific procedures can get ever closer to \"truths\" that, strictly speaking, do not exist."
- **arg 683 / phr 733** — awkward: → "It is wrong to make the unhoused work any harder than they already must for a decent night's sleep."
- **arg 720 / phr 770** — dash + hyphenation: → "70% of Seattle is zoned for single-family homes, preventing smaller, more affordable housing."
- **arg 769 / phr 819** — clunky, no period: → "A science-based approach to wildlife management benefits humans more than the status quo does."
- **arg 794 / phr 844** — apostrophe: → "Participating in sports can help build kids' self-esteem."
- **arg 807 / phr 857** — dashes, no period: → "Cryptoart, based on non-fungible tokens (NFTs), should be rejected as a model."
- **arg 823 / phr 873** — dash spacing, convoluted: → "Cryptocurrency investors, like futures speculators, are betting it will be better to hold the asset tomorrow than to produce it."

### REWRITE (strip to core)
- **arg 591 / phr 640** — 44-word conditional monster; alts already atomized: → "When others' standards differ from yours, it may be your views that are out of step with the median."
- **arg 613 / phr 662** — grammar + concession: → "A utopia need not be practical to clarify one's goals."
- **arg 625 / phr 674** — jokey two-sentence riff (Kool-Aid Man): → "Last-minute cameo gambits in WandaVision's finale would have rung hollow."
- **arg 627 / phr 676** — editorial idiom tail: → "WandaVision's major reveals, from Agatha to Monica's powers, were widely predicted in advance."
- **arg 678 / phr 728 (cur)** — tighten: → "Displaying only immediately connected arguments leaves Agitate users unaware of the wider universe of arguments on the topic, even those nearby in the same neighborhood of the graph."
- **arg 690 / phr 2773** — necessity half already arg 685: → "Encampment sanitation cannot substitute for the shelter and services that end homelessness."
- **arg 716 / phr 2782** — escalation stack: → "Seattle's unhoused often have family ties that would make relocating them cruel."
- **arg 733 / phr 2361 (cur)** — heavy-vehicle half already arg 436: → "Roads degrade from environmental factors even with no traffic at all."
- **arg 733 / phr 2790** — same drift: → "Environmental factors set a baseline of road degradation independent of traffic."
- **arg 754 / phr 804** — dustbin-of-history run-on: → "FAIR promotes uncontroversial tolerance while sheltering outdated positions from criticism."

### SPLIT (rewrite + coin new argument)
- **arg 655 / phr 3056 (cur)** — claim + sales-statistic evidence
  - 3056 → "Dr. Seuss was not canceled in 2021; his books remained widely in print."
  - NEW ARG: "Dr. Seuss books outsold every other children's author in 2021." — **Because of 655**, coin Karen Kim (11; accepts 655; rebalance).
- **arg 682 / phr 2769** — vivid reason + claim
  - 2769 → "The response to homelessness should match the severity of the crisis."
  - NEW ARG: "People are dying on the streets for lack of shelter." — **Because of 682**, coin Brianna (2; accepts 682; rebalance).
- **arg 834 / phr 884** — "X, and therefore Y" in one row
  - 884 → "Gold's value rests on social structures and traditions that exist globally."
  - NEW ARG: "Gold's value is unlikely to decline substantially." — **Therefore of 834**, coin Alfred (1; accepts 834; weight per rebalance).
- **arg 843 / phrs 893, 4016** — two independent facts joined by "and" in *both* phrasings
  - 893 → "Wolves almost never attack humans." ; 4016 → "Wolf attacks on humans are vanishingly rare."
  - NEW ARG: "Wolf predation on domestic animals is rare." — sibling claim; wire with the **same edge type/targets arg 843 currently has** (fetch 843's full edges at implementation), coin Zachary Zeller (26; accepts 843; rebalance).

### LEAVE
args 585, 587, 605, 624, 638 (687 — platform guidance, mechanical dash fix only), 649 (3534), 654, 666 (3141), 679 (729 temporal contrast), 682 (others), 683 (2342), 688 (mechanical only), 693, 706, 710 (2780 list), 717 (2783 list), 719 (2785), 721 (2787 list), 722 (all lists), 724 (2273 policy triple — optional future split), 757, 767, 782, 790, 794 (3085/3560 lists), 795, 796

## Chunk 4 (args 844–1077)

### FIX (text only)
- **arg 855 / phr 905** — garbled dashes: → "\"Ultra\" here classifies what exceeds the traditionally accepted understanding to an extreme."
- **arg 874 / phr 924** — typo "the do not": → "There are many businesses that do not generate a profit."
- **arg 875 / phr 925** — apostrophes/commas: → "Many businesses exist to further their owners' political and social goals rather than to make a profit."
- **arg 881 / phr 931** — dashes: → "Most events common to normal life should be canceled during a deadly pandemic."
- **arg 917 / phr 967** — dash + throat-clear: → "VA service and outcomes vary dramatically depending on the hospital."
- **arg 924 / phr 3304 (cur)** — dangling relative clause: → "Canada has built universal healthcare, paid parental leave, and lower inequality — models the U.S. could emulate."
- **arg 951 / phr 1001** — missing commas: → "By and large, men are bigger, faster, and stronger than women."
- **arg 983 / phr 1033** — sarcastic understatement: → "Sheltering priests with decades-long patterns of abuse was indefensible."
- **arg 1023 / phr 1074** — dash title: → "The Chronic by Dr. Dre is the most important album of the '90s."
- **arg 1025 / phr 1076 (cur)** — dash title: → "OK Computer by Radiohead is the greatest album of the 1990s."
- **arg 1046 / phr 1097** — dash title (avoid duping 2469): → "R.E.M.'s Automatic for the People is a seminal '90s album."
- **arg 1053 / phr 1104** — apostrophe: → "America's system of government should be better."
- **arg 1069 / phr 1120** — dashes: → "Flogging Molly, especially given their ties to Ireland, should have thought better than to name their band after domestic abuse."
- **arg 1069 / phr 2471** — double "given": → "Flogging Molly's band name, with the band's Irish cultural ties, was a poor choice given its evocation of domestic abuse."

### REWRITE (strip to core)
- **arg 844 / phr 894** — concession stack, no period: → "The faithful believe in God's glory even without witnessing or feeling His presence."
- **arg 852 / phr 902** — clunky: → "It is just as okay not to compete as it is to compete."
- **arg 873 / phrs 923, 3295 (cur), 3589** — every phrasing bundles a different second half; core claim is owner-goals
  - 923 → "The goals of a private business reflect the goals of its ownership."
  - 3295 → "Businesses ultimately serve the goals of their owners."
  - 3589 → "Business operations ultimately reflect the goals of the ownership."
  - (see SPLIT for the going-concern clause)
- **arg 898 / phr 2696 (cur)** — escalation + andjoin; alts already carry the general claim: → "Black and brown patients pay the steepest price for the healthcare system's failures."
- **arg 899 / phr 2074 (cur)** — competition mechanism already in 910/911: → "The current healthcare system is neither market-based nor government-controlled, combining the worst of both."
- **arg 899 / phr 2697** — pile-on: → "American healthcare combines the worst of a market system and a government system."
- **arg 900 / phr 2698 (cur)** — editorial tail: → "A country that ignores preventive care ends up paying emergency-room prices for everything."
- **arg 902 / phr 2032** — evidence list + two claims (features ≈ arg 1387): → "The law should protect unborn children's right to life."
- **arg 903 / phr 2743 (cur)** — endorsement tail: → "Live birth is the right point for the law to recognize personhood."
- **arg 907 / phr 2422 (cur)** — epistemic tail: → "Greater football exposure produces greater CTE risk, as the biology of repeated head trauma documents."
- **arg 910 / phr 2076** — keep the persona color, drop the duplicate half (4217 covers it): → "If the DMV is any guide, government-run hospital networks will not be an improvement."
- **arg 912 / phr 2701** — drifted toward arg 913's deserve-claim: → "The VA routinely fails to deliver timely care to veterans."
- **arg 913 / phr 2702** — sacrifice reason ≈ arg 916: → "Veterans deserve healthcare that reflects the magnitude of their sacrifice."
- **arg 917 / phr 2706** — cause tail: → "Some VA facilities are genuinely excellent even as others fail."

### SPLIT (rewrite + coin new argument)
- **arg 873/874** — going-concern constraint bundled in phr 923
  - NEW ARG: "A business must generate sufficient profit to continue as a going concern." — **Rebuttal of 874** (organizations need not run on profit), coin Thomas Turner (20, libertarian; **rejects 874** — no current opinion, add; weight 100%).
- **arg 897 / phr 2695** — drifted to overhead claim
  - 2695 → "American healthcare costs more than anywhere else in the world."
  - NEW ARG: "A large share of U.S. healthcare spending goes to insurance overhead rather than patient care." — **Because of 897**, coin Brianna (2; accepts 897; rebalance).
- **arg 905 / phr 2421 (cur)** — reasons folded into superlative
  - 2421 → "American football stands above all other sports."
  - NEW ARG: "Football uniquely combines strategic complexity with physical demands across wildly different positions." — **Because of 905**, coin Alfred (1; accepts 905; rebalance).
- **arg 908 / phrs 958, 2744 (cur)** — concession and consequence both distinct
  - 958 → "The point of viability established in Roe v. Wade is the most reasonable legal standard for personhood."
  - 2744 → "Viability is the most defensible legal standard for personhood."
  - NEW ARG A: "There is no perfect measure of when personhood begins." — **Because of 908**, coin Brianna (2; accepts 908; rebalance).
  - NEW ARG B: "Before viability, a woman's bodily autonomy governs." — **Therefore of 908**, coin Brianna (2; rebalance).
- **arg 909 / phrs 2075, 2700** — WWII origin fact + job-loss norm both distinct
  - 2075 → "There is no good reason to still tie health insurance to employment."
  - 2700 → "Tying healthcare to employment is an accident of history that should be undone."
  - NEW ARG A: "Employer-based health insurance arose from WWII wage controls, as companies competed through benefits." — **Because of 909**, coin Alfred (1; accepts 909; rebalance).
  - NEW ARG B: "No one should lose health coverage when they lose their job." — **Because of 909**, coin Brianna (2; accepts 909; rebalance).
- **arg 911 / phr 2077 (cur)** — three claims in one row
  - 2077 → "Healthcare is best delivered by private enterprise under proper regulation."
  - NEW ARG: "Competition pressures healthcare providers to cut costs and improve outcomes." — **Because of 911**, coin Frank Fletcher (6; accepts 911; rebalance).
- **arg 917 / phr 2082 (cur)** — variance fact + accountability prescription
  - 2082 → "VA service quality varies dramatically by facility."
  - NEW ARG: "The VA requires targeted accountability, not blanket defense or condemnation." — **Therefore of 917**, coin Alfred (1; accepts 917; rebalance).
- **arg 973 / phr 2748 (cur)** — the famous safe-abortion claim deserves its own node
  - 2748 → "Abortion bans increase poverty among the families that result."
  - NEW ARG: "Abortion bans do not end abortions; they end safe, legal ones." — **Because of 973**, coin Brianna (2; accepts 973; rebalance).
- **arg 1035 / phr 2292 (cur)** — landfill fact + symbolism conclusion
  - 2292 → "The environmental effect of household recycling is largely symbolic."
  - NEW ARG: "Most curbside recyclables ultimately go to landfill." — **Because of 1035**, coin Alfred (1; accepts 1035; rebalance).

### LEAVE
args 851, 857 (list), 859, 877 (motive contrast), 888, 901 (2699 policy-benefit list — optional future split), 912 (others), 914 (2080 example list), 923 (973 + 3303), 951 (2430), 966, 975, 983 (2318), 997, 1004, 1036 (3185), 1039 (all), 1043 (3191), 1049, 1061 (mechanical), 1077 (mechanical)

### Backlog additions
- **arg 1048** (phr 1099, "There is an SQL failure - proportions of endorsements get miscalculated…") — a bug report stored as an argument; candidate for deletion alongside Category 1 test parents.

## Chunk 5 (args 1079–1292)

### FIX (text only)
- **arg 1079 / phr 1130 (cur)** — dash title: → "Elephant by The White Stripes is the best album of the aughts."
- **arg 1093 / phr 1144 (cur)** — dash title: → "Back to Black by Amy Winehouse was the album of the aughts."
- **arg 1106 / phr 1158** — dash elaboration: → "In a free market, buyer and seller meet with neither knowing something the other doesn't."
- **arg 1115 / phr 1167** — shouty caps + garble: → "Courts reach wrong verdicts all the time; no one must accept what they know to be false."
- **arg 1130 / phr 1182** — rambling: → "Michael Jackson is idolized to this day, even worshiped."
- **arg 1139 / phr 1191 (cur)** — "Kevin's bacon" typo: → "New topics can be started on Agitate by making a tenuous connection over multiple steps — like Six Degrees of Kevin Bacon."
- **arg 1144 / phr 1196** — wordy: → "Putting more growth responsibility on cities takes pressure off surrounding suburban and rural areas, which are less equipped to accommodate population shifts."
- **arg 1162 / phr 1214** — clunky, no period: → "Border policy should favor faster, lighter processing to relieve surges like the one at the southern border in 2021."
- **arg 1164 / phr 1216** — grammar: → "Attracting the brightest minds from other countries to become American citizens is a strategic coup."
- **arg 1178 / phr 1230** — confrontational second person: → "What gun I own is my decision alone."
- **arg 1187 / phr 1240** — double space, list punctuation: → "Traffic stops should be limited to moving violations of immediate public safety concern: speeding, stop sign and light violations, DWI, and reckless driving."
- **arg 1196 / phr 1249** — agreement + "re-enforcing": → "The common -isms — sexism, racism, classism — are about reinforcing preexisting power structures that advantage some at the expense of others."
- **arg 1233 / phr 1286** — double negative: → "It is okay to be white; it is not okay to ignore what being white has meant."
- **arg 1239 / phr 1293** — garbled ("in what it in good faith to believe"): → "Crossing a border should elicit a military response only when the crosser acts under a foreign government's direction to injure the state being entered."
- **arg 1246 / phr 1300** — "D. Trump": → "Donald Trump's immigration policy was a failure."
- **arg 1261 / phr 1315 (cur)** — confusing: → "The ideal population density has no theoretical maximum, rising parabolically toward a city's center."
- **arg 1270 / phr 1324** — "just things" clunk: → "The U.S. should create the money it needs for just priorities so long as inflation stays in the 3–5% range."
- **arg 1286 / phr 1340** — garbled: → "Labels like liberal, conservative, Christian, and atheist carry the user's own baggage, unilaterally applied."
- **arg 1292 / phr 1346** — grammar: → "Robert's Rules of Order aren't very good at building consensus among unique individuals."

### REWRITE (strip to core)
- **arg 1131 / phr 1183** — garbled meta-commentary: → "\"To a degree\" here signals that examples exist along a spectrum even if the overall trend is not substantial."
- **arg 1140 / phr 1192 (cur)** — run-on: → "If a user makes a non sequitur argument and unendorses the connection before another user does, the result is a wholly independent argument that can be connected to the larger graph later."
- **arg 1152 / phr 1204 (cur)** — descriptive + normative bundled; Therefores 1895/1896 already carry enforcement detail: → "Agitate should make it hard — ultimately impossible — to accept an argument in one line of reasoning while rejecting it in another."
- **arg 1155 / phr 1207 (cur)** — two loose sentences: → "The \"foolish consistency\" Emerson called the hobgoblin of little minds is stubborn attachment to previous stances; changing one's mind to become more consistent is a virtue."
- **arg 1156 / phr 1208** — long conditional: → "A debater whose goal is winning rather than truth will adopt arguments in the moment that they otherwise wouldn't."
- **arg 1231 / phr 1284** — garbled meta-commentary: → "\"Meaningful\" here signals that a fair survey would overwhelmingly support the described pattern despite exceptions."
- **arg 1291 / phr 3363 (cur)** — "imperfect but": concession is trivial; alt 3633 already atomic: → "Robert's Rules of Order are the most tested system for managing deliberative groups."
- **arg 1292 / phr 3364 (cur)** — process-effectiveness half already arg 1293: → "Robert's Rules of Order do not build consensus on substance."

### SPLIT (rewrite + coin new argument)
- **arg 1193 / phr 2596 (cur)** — inline because-clause is a distinct claim
  - 2596 → "White people can experience prejudice but not systemic racism."
  - NEW ARG: "The American system was built to serve white people." — **Because of 1193**, coin Brianna (2; accepts 1193; rebalance).
- **arg 1229 / phrs 3931, 4226 (cur)** — "fine to be white" + "saying so shouldn't be controversial" are two claims
  - 4226 → "There is nothing wrong with being white."
  - 3931 → "No one should feel shame for being white."
  - NEW ARG: "Saying \"it's okay to be white\" should not be controversial." — **Therefore of 1229**, coin Frank Fletcher (6; accepts 1229; rebalance).
- **arg 1267 / phrs 1321, 2386 (cur), 2816** — "does not exist but should be pursued" = concession + claim in all three
  - 1321 → "Meritocracy should be pursued as an ideal." ; 2386 → "Meritocracy remains worth pursuing as an ideal." ; 2816 → "Rewarding demonstrated performance is worth the effort even if never perfectly achieved."
  - NEW ARG: "A pure meritocracy has never existed." — **Because of 1267**, coin Alfred (1; accepts 1267; rebalance).
- **arg 1268 / phrs 2387 (cur), 2817** — claim + mechanism tail in both
  - 2387 → "Rural workers earn less than urban counterparts for comparable work."
  - 2817 → "Comparable work pays less in rural labor markets than in urban ones."
  - NEW ARG: "The rural wage gap is driven by thin labor markets and lack of alternatives, not lower productivity." — **Because of 1268**, coin Brianna (2; accepts 1268; rebalance).

### LEAVE
args 1096, 1098, 1109, 1113 (2490 — contrast is the claim; note parent 1165 is the drifted one), 1143, 1145 (2802), 1151 (mechanical), 1160 (lists), 1164 (2867), 1169, 1187 (2670), 1190 (mechanical em-dash), 1208, 1210, 1226, 1231 (2612), 1232 (mechanical), 1245, 1253–1257 (lists/intrinsic), 1262, 1263, 1269, 1270 (3285), 1271, 1272, 1287, 1291 (1345)

### Backlog additions
- **arg 1136** (phr 1188 — a demo-video description stored as an argument) — meta content; review for deletion.

## Chunk 6 (args 1292–1547)

### FIX (text only)
- **arg 1340 / phr 1395** — apostrophe: → "Women's sports are inherently discriminatory."
- **arg 1366 / phr 1421** — dash: → "Georgia's voting law SB 202 expanded early voting, including weekend voting."
- **arg 1423 / phr 1480** — commas: → "The larger, longer, and more complex a plan becomes, the more difficult it is to keep secret."
- **arg 1427 / phr 1484** — dashes + dated term: → "Only the individual, and in some cases their family, should have a say in medical treatment related to their gender identity."
- **arg 1506 / phr 1563** — wordy: → "New technology typically follows a predictable pattern: unsustainable hype, a disappointing crash, then leveling off."
- **arg 152 (bonus, unflagged)** — "Use those resources into building civil services for communities." → "Use those resources to build civil services for communities." (look up phrasingID at implementation)

### REWRITE (strip to core)
- **arg 1292 / phr 3634** — same bundle as its siblings: → "Substantive consensus is not something Robert's Rules can produce."
- **arg 1309 / phr 2876** — restating tail: → "Working people undercut by exploited labor deserve protection too."
- **arg 1321 / phr 1375** — recognize-to-end tail already args 1322/1323: → "\"Black Lives Matter\" makes the simple point that Black lives are relatively undervalued in the U.S."
- **arg 1356 / phr 1411** — garbled two-sentence (by34): → "Without conclusive data that vaccinated adults cannot transmit the virus to unvaccinated children, adults and kids should have continued wearing masks."
- **arg 1411 / phr 2674** — accountability tail covered by 165-family: → "Officers deserve proper resources and the community's respect."
- **arg 1422 / phr 1479** — garbled run-on: → "A cabal running a program of child rape, murder, and cannibalism would require impossible secrecy from the elites involved and untold numbers of facilitators."
- **arg 1435 / phr 3119** — drifted to normative judgment: → "The traditional American family makes the husband the head of the household by default."
- **arg 1451 / phr 1508** — 50-word fact dump: → "Biden's Supreme Court commission excluded Daniel Epps and Ganesh Sitaraman, authors of the leading 15-justice reform proposal."
- **arg 1513 / phr 2301** — second half already arg 1514: → "Most herbal remedies are ineffective."
- **arg 1517 / phrs 2302 (cur), 3383** — fraud/defamation half already arg 1518: 2302 → "The First Amendment protects even offensive speech." ; 3383 → "Free speech protection extends to offensive expression."

### SPLIT (rewrite + coin new argument)
- **arg 1327 / phr 3145** — vaccine claim + political-resistance diagnosis
  - 3145 → "The safety and effectiveness of the COVID-19 vaccines is established."
  - NEW ARG: "Resistance to the COVID-19 vaccines was political rather than scientific." — **Therefore of 1327**, coin Brianna (2; accepts 1327; rebalance).
- **arg 1343 / phr 3152 (cur)** — uncertainty fact + recklessness judgment
  - 3152 → "The honest answer about the threat of COVID-19 variants was that it was uncertain."
  - NEW ARG: "Dropping precautions amid variant uncertainty was reckless." — **Therefore of 1343**, coin Brianna (2; accepts 1343; rebalance).
- **arg 1353 / phrs 2389 (cur), 2821** — entitlement claim + who-pays reason
  - 2389 → "Free parking is not a public entitlement." ; 2821 → "\"Free\" parking is a subsidy like any other."
  - NEW ARG: "The cost of \"free\" parking is paid by everyone else." — **Because of 1353**, coin Brianna (2; accepts 1353; rebalance).
- **arg 1376 / phr 2920** — Colorado fact drifted into general AVR normative claim
  - 2920 → "Colorado treats voting as an entitlement by registering citizens automatically."
  - NEW ARG: "Automatic voter registration treats voting as a right to exercise, not a status to prove." — **Because of 356** (Every eligible citizen should be automatically registered), coin Brianna (2; verify/add accept on 356; rebalance).
- **arg 1384 / phr 1914 (cur)** — current phrasing wholly drifted from "Facts do exist."
  - 1914 → "Facts exist independent of opinion."
  - NEW ARG: "Not every opinion deserves equal weight." — **Therefore of 1384**, coin Alfred (1; accepts 1384; rebalance).
- **arg 1404 / phrs 2145 (cur), 3165** — endemicity fact + policy conclusion
  - 2145 → "COVID-19 is now an endemic disease." ; 3165 → "COVID-19 circulates now as an endemic virus."
  - NEW ARG: "Emergency-level COVID-19 response is no longer warranted." — **Therefore of 1404**, coin Alfred (1; accepts 1404; rebalance).
- **arg 1463 / phrs 1520, 2194 (cur)** — facts + "therefore" conclusion / remedy prescription
  - 1520 → "Democrats underperform in the Electoral College and the Senate, the systems that dictate Supreme Court appointments."
  - 2194 → "Democrats underperform in the systems that determine governance and judicial appointments."
  - NEW ARG: "The remedy for Democrats is winning more seats under the existing rules." — **Therefore of 1463**, coin Alfred (1; accepts 1463; rebalance).
- **arg 1537 / phr 2677 (cur)** — negative claim + positive alternative
  - 2677 → "Increasing police budgets has not been shown to reduce crime."
  - NEW ARG: "Investment in education, mental health, and housing does more to reduce crime than police funding." — **Because of 1537**, coin Brianna (2; accepts 1537; rebalance).

### LEAVE
args 1303, 1318, 1319, 1321 (2950/4166), 1335, 1340 (3110), 1344, 1355, 1364, 1367, 1388, 1411 (1970/4450), 1415, 1416, 1419 (mechanical), 1423 (3680), 1426, 1431, 1432, 1435 (1492 mechanical), 1471 (3001), 1496, 1500, 1503, 1504 (contrastive historical claim), 1506 (3372/3705), 1513 (1571 — fix dashes only, keep house-style bluntness), 1518, 1523 (mechanical), 1528, 1536, 1540, 1547

### Backlog additions
- **phr 1528 @ arg 1471** — "FDT" — non-content abbreviation phrasing; delete candidate (Category 4 style).

## Chunk 7 (args 1547–2358)

### FIX (text only)
- **arg 1557 / phr 1615** — broken grammar ("avoided pulled back in"): → "Housing sprawl should be avoided and pulled back where possible."
- **arg 1567 / phr 1625** — garbled dashes: → "For non-Black people distant from the Black experience, \"woke\" can carry only its awareness component."
- **arg 1580 / phr 1638** — tangled: → "Wokeness has made jokes that were broadly funny just a few years ago completely verboten."
- **arg 1705 / phr 1764 (cur)** — "might be not worth": → "Many equations have variables that would be valid to include but whose marginal impact is not worth the added complexity."
- **arg 1709 / phr 1771 (cur)** — the known typo mess ("they distinct condtions"): → "Body dysmorphia is a separate condition from gender dysphoria." (alts 3123/3736 already carry the fuller wording)
- **arg 1758 / phr 4783 (cur)** — dash: → "Being shamed by one's community is a long-standing mechanism of social cohesion, keeping people in line."
- **arg 1800 / phr 4833 (cur)** — "publics": → "Police should prioritize the public's safety over their own."
- **arg 1846 / phr 4894** — broken ("Seattle and needs to build put"): → "Seattle should complete the build-out of its light rail network."
- **arg 1846 / phr 4895 (cur)** — caps: → "Seattle needs to build out its light rail system, Sound Transit."
- **arg 1849 / phr 4898 (cur)** — dash: → "Sound Transit was approved by Washington voters as a regional transit system, not just a Seattle one."
- **arg 1960 / phr 5014 (cur)** — garbled: → "Regrettably, \"literally\" now functions as just another intensifier, not solely as the antonym of \"figuratively\"."
- **arg 2358 / phr 5418 (cur)** — dash spacing: → "Clear, tangible consequences — often tragic ones — follow from elections going one direction rather than the other."

### REWRITE (strip to core)
- **arg 1554 / phr 2399 (cur)** — safety concession (2833 already handles the dialectic): → "Some modern building-code requirements exceed their safety benefit and raise housing costs."
- **arg 1556 / phr 1614** — two sentences: → "Real estate decision-making is dominated by an oligarchy of developers and the wealthy."
- **arg 1557 / phr 2836** — reasons ≈ args 1141/1559: → "Growth should be concentrated in existing urban areas rather than sprawl."
- **arg 1560 / phr 2839** — mechanism ≈ arg 1561: → "A homeowner deciding density policy is voting on their own net worth."
- **arg 1570 / phr 1628** — run-on definition: → "Induced demand is the phenomenon where new capacity is immediately consumed by new demand, often leaving a bigger problem than before."
- **arg 1585 / phr 3389 (cur)** — profiling half ≈ arg 1587: → "Nextdoor makes the communities it serves worse, not better."
- **arg 1605 / phr 3324** — scope-note tail: → "The information carried by distributed prices cannot be replicated by central planning." (optional future arg: "market superiority ≠ anti-regulation")
- **arg 1658 / phr 2012** — vague tail: → "Land changing hands through force is not always genocide."
- **arg 1763 / phr 4788 (cur)** — two sentences: → "Private enterprise's vaunted performance is often survivorship bias: a single success against inferior competition."

### SPLIT (rewrite + coin new argument)
- **arg 1556 / phr 2835 (cur)** — oligarchy claim + power prescription
  - 2835 → "Development decisions are dominated by an oligarchy of developers and wealthy landowners."
  - NEW ARG: "Residents need structural power in development decisions." — **Therefore of 1556**, coin Brianna (2; accepts 1556; rebalance).
- **arg 1580 / phr 2096 (cur)** — fact + culture judgment
  - 2096 → "Jokes that were widely funny a few years ago can now be career-ending."
  - NEW ARG: "A culture that ends careers over old jokes is fearful, not kinder." — **Therefore of 1580**, coin Alfred (1; accepts 1580; rebalance).
- **arg 1899 / phr 4948 (cur)** — compressed syllogism
  - 4948 → "A hot dog shares the structure of a meatball sub."
  - NEW ARG: "A meatball sub is accepted as a sandwich." — **Because of 1899**, coin Carlos Castillo (3; accepts 1899; rebalance).

### LEAVE
args 1547, 1549, 1567 (3076), 1570 (2841), 1595, 1613, 1621, 1626, 1642, 1659, 1707, 1711 (relative-clause "but"), 1717, 1734 (mechanical), 1738–1745 (single-fact intersex counterexamples — the "but" is intrinsic), 1760 (mechanical), 1762, 1766 (persona-voice variants), 1782–1797, 1800 (4867–4869), 1833, 1836, 1838, 1843, 1865–1896 (Agitate meta, intrinsic contrasts), 1900, 2014/2015 (deliberate detail-variants from candidate seeding), 2329

---

# Implementation plan (after review)

1. **Fresh DB backup** (mysqldump per PROJECT.md) before any writes.
2. **Batch 1 — FIX + REWRITE** (~105 rows): one SQL script of `UPDATE PHRASING SET phrasing=...` statements; for every (cur) row also `UPDATE ARGUMENT SET currentPhrasing=...` where `currentPhrasingID` matches. Single SSH connection.
3. **Batch 2 — Mechanical sweep**: script-generated list of terminal-period/whitespace/spaced-hyphen fixes across the whole corpus; review the generated diff, then apply.
4. **Batch 3 — SPLITS** (~40 new arguments): per-argument SQL recipes following the persona-seeding pattern — `find_similar` dedup check, INSERT ARGUMENT + PHRASING (coinedBy persona), OPINION (accept new arg; add/verify opinion on target), ENDORSEMENT with 100%-invariant rebalance (prepareForNewEndorse/resolveOldWithNewEndorse pattern), SCOPE rows under affiliation 12. Personas chosen lean-matched per entry above.
5. **Verification**: re-run DATA_CLEANUP_BACKLOG verification queries; spot-check weights sum to 100% for every touched (profile, arg, type); update DATA_CLEANUP_BACKLOG.md with the new backlog items found (args 436/438 near-dupe, arg 1048 SQL-bug arg, arg 1136 demo-video arg, phr 1528 "FDT", arg 413 stray bicycle edges, intersex args 1738–1745 re-pointing to future "two biological sexes" arg).
