-- alfred_weight_normalize_seed.sql
-- Normalizes all ENDORSEMENT weights for profileID=1, args 1-54
-- so each (targArgID, endorseType) group sums to exactly 100.
-- Generated programmatically; last row in each group absorbs rounding remainder.

-- arg 1 Because: 2 entries, old sum=140.0
UPDATE ENDORSEMENT SET weight=57.1429 WHERE targArgID=1 AND profileID=1 AND endorseType='Because' AND supportingArgID=8 AND active=1;
UPDATE ENDORSEMENT SET weight=42.8571 WHERE targArgID=1 AND profileID=1 AND endorseType='Because' AND supportingArgID=11 AND active=1;

-- arg 1 Therefore: 3 entries, old sum=190.0
UPDATE ENDORSEMENT SET weight=28.9474 WHERE targArgID=1 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=36.8421 WHERE targArgID=1 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=34.2105 WHERE targArgID=1 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=11 AND active=1;

-- arg 2 Because: 4 entries, old sum=205.0
UPDATE ENDORSEMENT SET weight=26.8293 WHERE targArgID=2 AND profileID=1 AND endorseType='Because' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=24.3902 WHERE targArgID=2 AND profileID=1 AND endorseType='Because' AND supportingArgID=6 AND active=1;
UPDATE ENDORSEMENT SET weight=24.3902 WHERE targArgID=2 AND profileID=1 AND endorseType='Because' AND supportingArgID=11 AND active=1;
UPDATE ENDORSEMENT SET weight=24.3903 WHERE targArgID=2 AND profileID=1 AND endorseType='Because' AND supportingArgID=40 AND active=1;

-- arg 2 Therefore: 2 entries, old sum=135.0
UPDATE ENDORSEMENT SET weight=55.5556 WHERE targArgID=2 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=44.4444 WHERE targArgID=2 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=40 AND active=1;

-- arg 3 Because: 1 entries, old sum=45.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=3 AND profileID=1 AND endorseType='Because' AND supportingArgID=16 AND active=1;

-- arg 3 Therefore: 3 entries, old sum=195.0
UPDATE ENDORSEMENT SET weight=35.8974 WHERE targArgID=3 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=30.7692 WHERE targArgID=3 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=7 AND active=1;
UPDATE ENDORSEMENT SET weight=33.3334 WHERE targArgID=3 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;

-- arg 4 Rebuttal: 3 entries, old sum=185.0
UPDATE ENDORSEMENT SET weight=37.8378 WHERE targArgID=4 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=35.1351 WHERE targArgID=4 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=27.0271 WHERE targArgID=4 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=8 AND active=1;

-- arg 5 Because: 2 entries, old sum=125.0
UPDATE ENDORSEMENT SET weight=56.0 WHERE targArgID=5 AND profileID=1 AND endorseType='Because' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=44.0 WHERE targArgID=5 AND profileID=1 AND endorseType='Because' AND supportingArgID=20 AND active=1;

-- arg 5 Therefore: 3 entries, old sum=200.0
UPDATE ENDORSEMENT SET weight=32.5 WHERE targArgID=5 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=7 AND active=1;
UPDATE ENDORSEMENT SET weight=40.0 WHERE targArgID=5 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=27.5 WHERE targArgID=5 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 6 Therefore: 2 entries, old sum=120.0
UPDATE ENDORSEMENT SET weight=41.6667 WHERE targArgID=6 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=58.3333 WHERE targArgID=6 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=47 AND active=1;

-- arg 7 Because: 3 entries, old sum=180.0
UPDATE ENDORSEMENT SET weight=33.3333 WHERE targArgID=7 AND profileID=1 AND endorseType='Because' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=36.1111 WHERE targArgID=7 AND profileID=1 AND endorseType='Because' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=30.5556 WHERE targArgID=7 AND profileID=1 AND endorseType='Because' AND supportingArgID=9 AND active=1;

-- arg 7 Therefore: 2 entries, old sum=125.0
UPDATE ENDORSEMENT SET weight=48.0 WHERE targArgID=7 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=52.0 WHERE targArgID=7 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 8 Therefore: 2 entries, old sum=145.0
UPDATE ENDORSEMENT SET weight=55.1724 WHERE targArgID=8 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=44.8276 WHERE targArgID=8 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=11 AND active=1;

-- arg 9 Because: 11 entries, old sum=700.0
UPDATE ENDORSEMENT SET weight=10.0 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=10.7143 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=9.2857 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=11.4286 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=8.5714 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=7 AND active=1;
UPDATE ENDORSEMENT SET weight=8.5714 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=10 AND active=1;
UPDATE ENDORSEMENT SET weight=8.5714 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=20 AND active=1;
UPDATE ENDORSEMENT SET weight=7.8571 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=37 AND active=1;
UPDATE ENDORSEMENT SET weight=7.8571 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=43 AND active=1;
UPDATE ENDORSEMENT SET weight=9.2857 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=46 AND active=1;
UPDATE ENDORSEMENT SET weight=7.8573 WHERE targArgID=9 AND profileID=1 AND endorseType='Because' AND supportingArgID=47 AND active=1;

-- arg 9 Therefore: 2 entries, old sum=115.0
UPDATE ENDORSEMENT SET weight=47.8261 WHERE targArgID=9 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=7 AND active=1;
UPDATE ENDORSEMENT SET weight=52.1739 WHERE targArgID=9 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=43 AND active=1;

-- arg 10 Because: 1 entries, old sum=60.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=10 AND profileID=1 AND endorseType='Because' AND supportingArgID=46 AND active=1;

-- arg 10 Therefore: 1 entries, old sum=60.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=10 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;

-- arg 11 Because: 2 entries, old sum=130.0
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=11 AND profileID=1 AND endorseType='Because' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=11 AND profileID=1 AND endorseType='Because' AND supportingArgID=8 AND active=1;

-- arg 11 Therefore: 3 entries, old sum=170.0
UPDATE ENDORSEMENT SET weight=35.2941 WHERE targArgID=11 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=29.4118 WHERE targArgID=11 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=35.2941 WHERE targArgID=11 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 12 Rebuttal: 4 entries, old sum=255.0
UPDATE ENDORSEMENT SET weight=27.451 WHERE targArgID=12 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=17.6471 WHERE targArgID=12 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=31.3725 WHERE targArgID=12 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=23.5294 WHERE targArgID=12 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=36 AND active=1;

-- arg 13 Rebuttal: 5 entries, old sum=340.0
UPDATE ENDORSEMENT SET weight=19.1176 WHERE targArgID=13 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=26.4706 WHERE targArgID=13 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=16.1765 WHERE targArgID=13 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=20 AND active=1;
UPDATE ENDORSEMENT SET weight=17.6471 WHERE targArgID=13 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=36 AND active=1;
UPDATE ENDORSEMENT SET weight=20.5882 WHERE targArgID=13 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=37 AND active=1;

-- arg 14 Rebuttal: 3 entries, old sum=215.0
UPDATE ENDORSEMENT SET weight=25.5814 WHERE targArgID=14 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=32.5581 WHERE targArgID=14 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=41.8605 WHERE targArgID=14 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=20 AND active=1;

-- arg 15 Rebuttal: 3 entries, old sum=200.0
UPDATE ENDORSEMENT SET weight=40.0 WHERE targArgID=15 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=25.0 WHERE targArgID=15 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=35.0 WHERE targArgID=15 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=20 AND active=1;

-- arg 16 Because: 1 entries, old sum=55.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=16 AND profileID=1 AND endorseType='Because' AND supportingArgID=18 AND active=1;

-- arg 16 Therefore: 2 entries, old sum=120.0
UPDATE ENDORSEMENT SET weight=37.5 WHERE targArgID=16 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=62.5 WHERE targArgID=16 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=17 AND active=1;

-- arg 17 Because: 2 entries, old sum=140.0
UPDATE ENDORSEMENT SET weight=53.5714 WHERE targArgID=17 AND profileID=1 AND endorseType='Because' AND supportingArgID=16 AND active=1;
UPDATE ENDORSEMENT SET weight=46.4286 WHERE targArgID=17 AND profileID=1 AND endorseType='Because' AND supportingArgID=18 AND active=1;

-- arg 17 Therefore: 2 entries, old sum=120.0
UPDATE ENDORSEMENT SET weight=54.1667 WHERE targArgID=17 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=18 AND active=1;
UPDATE ENDORSEMENT SET weight=45.8333 WHERE targArgID=17 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=40 AND active=1;

-- arg 18 Because: 1 entries, old sum=65.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=18 AND profileID=1 AND endorseType='Because' AND supportingArgID=17 AND active=1;

-- arg 18 Therefore: 3 entries, old sum=200.0
UPDATE ENDORSEMENT SET weight=27.5 WHERE targArgID=18 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=16 AND active=1;
UPDATE ENDORSEMENT SET weight=32.5 WHERE targArgID=18 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=17 AND active=1;
UPDATE ENDORSEMENT SET weight=40.0 WHERE targArgID=18 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=19 AND active=1;

-- arg 19 Because: 1 entries, old sum=80.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=19 AND profileID=1 AND endorseType='Because' AND supportingArgID=18 AND active=1;

-- arg 19 Therefore: 2 entries, old sum=140.0
UPDATE ENDORSEMENT SET weight=53.5714 WHERE targArgID=19 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=25 AND active=1;
UPDATE ENDORSEMENT SET weight=46.4286 WHERE targArgID=19 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=28 AND active=1;

-- arg 20 Therefore: 3 entries, old sum=165.0
UPDATE ENDORSEMENT SET weight=33.3333 WHERE targArgID=20 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=36.3636 WHERE targArgID=20 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=30.3031 WHERE targArgID=20 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 21 Rebuttal: 3 entries, old sum=205.0
UPDATE ENDORSEMENT SET weight=34.1463 WHERE targArgID=21 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=39.0244 WHERE targArgID=21 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=26.8293 WHERE targArgID=21 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=37 AND active=1;

-- arg 22 Rebuttal: 3 entries, old sum=195.0
UPDATE ENDORSEMENT SET weight=38.4615 WHERE targArgID=22 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=33.3333 WHERE targArgID=22 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=37 AND active=1;
UPDATE ENDORSEMENT SET weight=28.2052 WHERE targArgID=22 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=47 AND active=1;

-- arg 23 Rebuttal: 3 entries, old sum=190.0
UPDATE ENDORSEMENT SET weight=42.1053 WHERE targArgID=23 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=23.6842 WHERE targArgID=23 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=34.2105 WHERE targArgID=23 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=37 AND active=1;

-- arg 24 Rebuttal: 3 entries, old sum=190.0
UPDATE ENDORSEMENT SET weight=28.9474 WHERE targArgID=24 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=36.8421 WHERE targArgID=24 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=37 AND active=1;
UPDATE ENDORSEMENT SET weight=34.2105 WHERE targArgID=24 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=47 AND active=1;

-- arg 25 Because: 1 entries, old sum=75.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=25 AND profileID=1 AND endorseType='Because' AND supportingArgID=19 AND active=1;

-- arg 25 Therefore: 2 entries, old sum=160.0
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=25 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=28 AND active=1;
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=25 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=29 AND active=1;

-- arg 26 Rebuttal: 3 entries, old sum=215.0
UPDATE ENDORSEMENT SET weight=37.2093 WHERE targArgID=26 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=31 AND active=1;
UPDATE ENDORSEMENT SET weight=32.5581 WHERE targArgID=26 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=36 AND active=1;
UPDATE ENDORSEMENT SET weight=30.2326 WHERE targArgID=26 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=37 AND active=1;

-- arg 27 Rebuttal: 3 entries, old sum=215.0
UPDATE ENDORSEMENT SET weight=39.5349 WHERE targArgID=27 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=32.5581 WHERE targArgID=27 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=27.907 WHERE targArgID=27 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=31 AND active=1;

-- arg 28 Because: 2 entries, old sum=145.0
UPDATE ENDORSEMENT SET weight=44.8276 WHERE targArgID=28 AND profileID=1 AND endorseType='Because' AND supportingArgID=19 AND active=1;
UPDATE ENDORSEMENT SET weight=55.1724 WHERE targArgID=28 AND profileID=1 AND endorseType='Because' AND supportingArgID=25 AND active=1;

-- arg 28 Therefore: 1 entries, old sum=75.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=28 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=29 AND active=1;

-- arg 29 Because: 2 entries, old sum=155.0
UPDATE ENDORSEMENT SET weight=51.6129 WHERE targArgID=29 AND profileID=1 AND endorseType='Because' AND supportingArgID=25 AND active=1;
UPDATE ENDORSEMENT SET weight=48.3871 WHERE targArgID=29 AND profileID=1 AND endorseType='Because' AND supportingArgID=28 AND active=1;

-- arg 30 Because: 1 entries, old sum=65.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=30 AND profileID=1 AND endorseType='Because' AND supportingArgID=31 AND active=1;

-- arg 30 Therefore: 1 entries, old sum=65.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=30 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 31 Therefore: 2 entries, old sum=135.0
UPDATE ENDORSEMENT SET weight=48.1481 WHERE targArgID=31 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=30 AND active=1;
UPDATE ENDORSEMENT SET weight=51.8519 WHERE targArgID=31 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 32 Rebuttal: 3 entries, old sum=210.0
UPDATE ENDORSEMENT SET weight=38.0952 WHERE targArgID=32 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=28.5714 WHERE targArgID=32 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=33.3334 WHERE targArgID=32 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=20 AND active=1;

-- arg 33 Rebuttal: 3 entries, old sum=205.0
UPDATE ENDORSEMENT SET weight=26.8293 WHERE targArgID=33 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=30 AND active=1;
UPDATE ENDORSEMENT SET weight=34.1463 WHERE targArgID=33 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=31 AND active=1;
UPDATE ENDORSEMENT SET weight=39.0244 WHERE targArgID=33 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=36 AND active=1;

-- arg 34 Rebuttal: 2 entries, old sum=135.0
UPDATE ENDORSEMENT SET weight=51.8519 WHERE targArgID=34 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=18 AND active=1;
UPDATE ENDORSEMENT SET weight=48.1481 WHERE targArgID=34 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=19 AND active=1;

-- arg 35 Rebuttal: 3 entries, old sum=200.0
UPDATE ENDORSEMENT SET weight=32.5 WHERE targArgID=35 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=40.0 WHERE targArgID=35 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=3 AND active=1;
UPDATE ENDORSEMENT SET weight=27.5 WHERE targArgID=35 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;

-- arg 36 Because: 9 entries, old sum=545.0
UPDATE ENDORSEMENT SET weight=10.0917 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=11.9266 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=7 AND active=1;
UPDATE ENDORSEMENT SET weight=11.0092 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=11 AND active=1;
UPDATE ENDORSEMENT SET weight=9.1743 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=20 AND active=1;
UPDATE ENDORSEMENT SET weight=11.9266 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=30 AND active=1;
UPDATE ENDORSEMENT SET weight=12.844 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=31 AND active=1;
UPDATE ENDORSEMENT SET weight=11.0092 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=37 AND active=1;
UPDATE ENDORSEMENT SET weight=10.0917 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=46 AND active=1;
UPDATE ENDORSEMENT SET weight=11.9267 WHERE targArgID=36 AND profileID=1 AND endorseType='Because' AND supportingArgID=47 AND active=1;

-- arg 36 Therefore: 1 entries, old sum=60.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=36 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=37 AND active=1;

-- arg 37 Because: 1 entries, old sum=60.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=37 AND profileID=1 AND endorseType='Because' AND supportingArgID=36 AND active=1;

-- arg 37 Therefore: 2 entries, old sum=115.0
UPDATE ENDORSEMENT SET weight=47.8261 WHERE targArgID=37 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=52.1739 WHERE targArgID=37 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 38 Rebuttal: 3 entries, old sum=210.0
UPDATE ENDORSEMENT SET weight=38.0952 WHERE targArgID=38 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=33.3333 WHERE targArgID=38 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=28.5715 WHERE targArgID=38 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=11 AND active=1;

-- arg 39 Rebuttal: 3 entries, old sum=200.0
UPDATE ENDORSEMENT SET weight=40.0 WHERE targArgID=39 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=27.5 WHERE targArgID=39 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=32.5 WHERE targArgID=39 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=36 AND active=1;

-- arg 40 Because: 2 entries, old sum=115.0
UPDATE ENDORSEMENT SET weight=52.1739 WHERE targArgID=40 AND profileID=1 AND endorseType='Because' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=47.8261 WHERE targArgID=40 AND profileID=1 AND endorseType='Because' AND supportingArgID=17 AND active=1;

-- arg 40 Therefore: 1 entries, old sum=50.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=40 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=2 AND active=1;

-- arg 41 Rebuttal: 3 entries, old sum=215.0
UPDATE ENDORSEMENT SET weight=25.5814 WHERE targArgID=41 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=2 AND active=1;
UPDATE ENDORSEMENT SET weight=32.5581 WHERE targArgID=41 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=18 AND active=1;
UPDATE ENDORSEMENT SET weight=41.8605 WHERE targArgID=41 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=40 AND active=1;

-- arg 42 Rebuttal: 3 entries, old sum=155.0
UPDATE ENDORSEMENT SET weight=32.2581 WHERE targArgID=42 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=5 AND active=1;
UPDATE ENDORSEMENT SET weight=38.7097 WHERE targArgID=42 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=43 AND active=1;
UPDATE ENDORSEMENT SET weight=29.0322 WHERE targArgID=42 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=47 AND active=1;

-- arg 43 Because: 2 entries, old sum=120.0
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=43 AND profileID=1 AND endorseType='Because' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=50.0 WHERE targArgID=43 AND profileID=1 AND endorseType='Because' AND supportingArgID=45 AND active=1;

-- arg 43 Therefore: 2 entries, old sum=120.0
UPDATE ENDORSEMENT SET weight=45.8333 WHERE targArgID=43 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=54.1667 WHERE targArgID=43 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=45 AND active=1;

-- arg 44 Rebuttal: 3 entries, old sum=220.0
UPDATE ENDORSEMENT SET weight=31.8182 WHERE targArgID=44 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=27.2727 WHERE targArgID=44 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=36 AND active=1;
UPDATE ENDORSEMENT SET weight=40.9091 WHERE targArgID=44 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=46 AND active=1;

-- arg 45 Because: 1 entries, old sum=65.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=45 AND profileID=1 AND endorseType='Because' AND supportingArgID=43 AND active=1;

-- arg 45 Therefore: 1 entries, old sum=60.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=45 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=43 AND active=1;

-- arg 46 Therefore: 3 entries, old sum=180.0
UPDATE ENDORSEMENT SET weight=36.1111 WHERE targArgID=46 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=33.3333 WHERE targArgID=46 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=10 AND active=1;
UPDATE ENDORSEMENT SET weight=30.5556 WHERE targArgID=46 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 47 Because: 1 entries, old sum=70.0
UPDATE ENDORSEMENT SET weight=100.0 WHERE targArgID=47 AND profileID=1 AND endorseType='Because' AND supportingArgID=6 AND active=1;

-- arg 47 Therefore: 2 entries, old sum=120.0
UPDATE ENDORSEMENT SET weight=45.8333 WHERE targArgID=47 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=54.1667 WHERE targArgID=47 AND profileID=1 AND endorseType='Therefore' AND supportingArgID=36 AND active=1;

-- arg 50 Rebuttal: 3 entries, old sum=165.0
UPDATE ENDORSEMENT SET weight=36.3636 WHERE targArgID=50 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=33.3333 WHERE targArgID=50 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=9 AND active=1;
UPDATE ENDORSEMENT SET weight=30.3031 WHERE targArgID=50 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=40 AND active=1;

-- arg 51 Rebuttal: 4 entries, old sum=280.0
UPDATE ENDORSEMENT SET weight=21.4286 WHERE targArgID=51 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1 AND active=1;
UPDATE ENDORSEMENT SET weight=19.6429 WHERE targArgID=51 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=226 AND active=1;
UPDATE ENDORSEMENT SET weight=30.3571 WHERE targArgID=51 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1396 AND active=1;
UPDATE ENDORSEMENT SET weight=28.5714 WHERE targArgID=51 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=1397 AND active=1;

-- arg 54 Rebuttal: 4 entries, old sum=295.0
UPDATE ENDORSEMENT SET weight=20.339 WHERE targArgID=54 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=193 AND active=1;
UPDATE ENDORSEMENT SET weight=23.7288 WHERE targArgID=54 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=227 AND active=1;
UPDATE ENDORSEMENT SET weight=28.8136 WHERE targArgID=54 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=265 AND active=1;
UPDATE ENDORSEMENT SET weight=27.1186 WHERE targArgID=54 AND profileID=1 AND endorseType='Rebuttal' AND supportingArgID=266 AND active=1;

