# Write your MySQL query statement below
select *,CASE when dna_sequence like "ATG%" THEN 1 ELSE 0 END AS has_start,
    case when dna_sequence like "%TAA" or dna_sequence like "%TAG" or dna_sequence like "%TGA" THEN 1 ELSE 0 END AS has_stop,
    case when dna_sequence like "%ATAT%" THEN 1 ELSE 0 END AS has_atat,
    CASE WHEN dna_sequence like "%GGG" OR  dna_sequence like "%GGG%" OR  dna_sequence like "GGG%" THEN 1 ELSE 0 END AS has_ggg 
from Samples
    