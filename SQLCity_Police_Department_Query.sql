SELECT COUNT(*) FROM person;                  
SELECT COUNT(*) FROM facebook_event_checkin;
SELECT COUNT(*) FROM get_fit_now_check_in;
SELECT * FROM drivers_license
SELECT * FROM interview

-- Question 1: Who hired Jeremy Bowers?
SELECT p.id, p.name, i.transcript
FROM person p
JOIN interview i ON i.person_id = p.id
WHERE p.name = 'Jeremy Bowers';

-- Interview transcript: I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
-- She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

-- Investigating further with these details:

SELECT p.id, p.name
FROM person p
JOIN drivers_license d ON p.license_id = d.id
JOIN facebook_event_checkin f ON f.person_id = p.id
WHERE d.gender = 'female'
  AND d.hair_color = 'red'
  AND d.car_make = 'Tesla' AND d.car_model = 'Model S'
  AND d.height BETWEEN 65 AND 67
  AND f.event_name = 'SQL Symphony Concert'
  AND f.date BETWEEN 20171201 AND 20171231      -- dates are integers like 20171201
GROUP BY p.id, p.name
HAVING COUNT(*) = 3;

SELECT * FROM person
SELECT * FROM income
SELECT * FROM get_fit_now_check_in

-- Miranda Priestly with the ID 99716 hired Jeremy Bowers.

-- Question 2: Who are the top 20 earners in the city?

SELECT p.name AS "Name",
       p.address_number || ' ' || p.address_street_name AS "Address",
       d.age AS "Age",
       d.gender AS "Gender",
       d.car_make AS "Car Type"
FROM person p
JOIN drivers_license d ON d.id = p.license_id
JOIN income i ON i.ssn = p.ssn
ORDER BY i.annual_income DESC
LIMIT 20;

-- Question 3: What is the daily gym attendance?

SELECT TO_DATE(check_in_date::text, 'YYYYMMDD') AS "Date",
       COUNT(DISTINCT membership_id) AS "Number of people in gym"
FROM get_fit_now_check_in
GROUP BY check_in_date
ORDER BY check_in_date;