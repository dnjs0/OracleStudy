-- 요구사항] 씨네 21 집계기간(일주일) 영화 순위 50위까지 데이터를 기반으로 합니다.


-- 1. 누적 관객수 순서대로 가져오시오.
select pplTotalCount
    from tblMovie
        order by pplTotalCount; 

-- 2. '송중기' 배우가 출연한 영화를 가져오시오.
SELECT m.korName
    FROM tblMovie m
        JOIN tblMovieActor ma ON m.seqM = ma.seqM
            JOIN tblActor a ON ma.seqActor = a.seqActor
                WHERE a.actorName = '송중기';


-- 3. '곽경택' 감독이 제작한 영화를 가져오시오.
select m.korName
    from tblMovie m
        join tblDirector dr on m.seqM=dr.seqM
            join Masterpiece mp on dr.seqMasterpiece = mp.seqMasterpiece
                where dr.directorName = '곽경택';

-- 4. 씨네 21 전문가 평점 6.0 이상 + 네티즌 평점 6.0 이상  받은 영화를 가져오시오.
SELECT m.korName
    FROM tblMovie m
        JOIN tblexpertScore es ON m.seqM = es.seqM
            JOIN tblpplScore ps ON m.seqM = ps.seqM
                WHERE es.expertStar >= 6.0 AND ps.pplStar >= 6.0;

-- 5. 등록된 50개의 영화 중 가장 많은 영화에 참여한 배우와 그 배우가 출연한 영화를 가져오시오.
select a.seqActor, ma.korName
    from (select ma.*,
        rank() over(partition by seqActor order by count(seqActor) desc) as rnum
            from tblMovieActor ma)
                join tblActor a on ma.seqActor = a.seqActor
                    join tblMovie m on ma.seqM = a.seqM;


-- 6. '드라마'와 '범죄' 장르에 동시에 속한 영화를 가져오시오.
SELECT m.korName
    FROM tblMovie m
        JOIN tblMovieCategory mc ON m.seqM = mc.seqM
            JOIN tblCategory cg ON cg.seqCategory = mc.seqCategory
                WHERE cg.categoryName = '드라마' AND cg.categoryName = '범죄';

-- 7. 상영시간이 120분 미만인 영화를 가져오시오.
select m.korName
    from tblMovie m
         where moveTime < 120;

-- 8. 15세 이상 관람가 영화를 가져오시오.
SELECT m.korName
    FROM tblMovie m
        join tblAgeGrade ag on ag.seqAgeGrade=m.movieage
            where age='15세 이상 관람가';

-- 9. 네티즌 리뷰가 가장 많이 달린 순으로 가져오시오.
select *
    from tblMovie m
        join tblpplScore ps on ps.seqM = m.seqM
            ;--where

-- 10. 네티즌 리뷰를 가장 많이 작성한 네티즌의 아이디(이름)를 가져오시오.
select   pplname
     from (select p.pplname,count(p.pplname) 
        from tblpplScore ps 
            join tblppl p on ps.seqppl = p.seqppl 
                group by p.pplname 
                    order by count(p.pplname) desc )
                        where rownum = 1;
-- 11. 전문가 별점에 가장 많이 참여한 전문가의 이름을 가져오시오.

