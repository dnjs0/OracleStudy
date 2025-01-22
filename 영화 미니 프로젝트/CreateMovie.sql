--DELETE FROM tblMovie WHERE seqM = 1;    --테이블 데이터 라인 1줄 지우기
DELETE FROM tblcountrymade;   --테이블 내용 전체지우기
DELETE FROM tblcountry;   --테이블 내용 전체지우기
DELETE FROM tblMovie;   --테이블 내용 전체지우기
DELETE FROM tblAgeGrade;

SELECT * FROM tblMovie;
select * from tblcountry;
select * from tblagegrade;
select * from tblcountrymade;


--tblCountry 인서트
insert into tblCountry(seqcountry, countryname) values (1, '한국');
insert into tblCountry(seqcountry, countryname) values (2, '미국');
insert into tblCountry(seqcountry, countryname) values (3, '영국');
insert into tblCountry(seqcountry, countryname) values (4, '프랑스');
insert into tblCountry(seqcountry, countryname) values (5, '일본');
insert into tblCountry(seqcountry, countryname) values (6, '캐나다');
insert into tblCountry(seqcountry, countryname) values (7, '영국');
insert into tblCountry(seqcountry, countryname) values (8, '독일');
insert into tblCountry(seqcountry, countryname) values (9, '뉴질랜드');
insert into tblCountry(seqcountry, countryname) values (10, '폴란드');
insert into tblCountry(seqcountry, countryname) values (11, '이탈리아');
insert into tblCountry(seqcountry, countryname) values (12, '스웨덴');
insert into tblCountry(seqcountry, countryname) values (13, '대만');
insert into tblCountry(seqcountry, countryname) values (14, '네덜란드');
insert into tblCountry(seqcountry, countryname) values (15, '핀란드');
insert into tblCountry(seqcountry, countryname) values (16, '아일랜드');
insert into tblCountry(seqcountry, countryname) values (17, '덴마크');

insert into tblAgeGrade(seqAgeGrade, age) values (0, '등급 정보가 없습니다');
insert into tblAgeGrade(seqAgeGrade, age) values (1, '청소년 관람불가');
insert into tblAgeGrade(seqAgeGrade, age) values (2, '15세 이하 관람불가');
insert into tblAgeGrade(seqAgeGrade, age) values (3, '12세 이하 관람불가');
insert into tblAgeGrade(seqAgeGrade, age) values (4, '전체 관람가');




insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('1',q'[하얼빈]',q'[HARBIN]','113','267132','4515610',to_date('20241224','yyyy-mm-dd'),q'[1908년 함경북도 신아산에서 안중근이 이끄는 독립군들은 
일본군과의 전투에서 큰 승리를 거둔다. 
대한의군 참모중장 안중근은 만국공법에 따라 
전쟁포로인 일본인들을 풀어주게 되고, 
이 사건으로 인해 독립군 사이에서는 
안중근에 대한 의심과 함께 균열이 일기 시작한다. 

1년 후, 블라디보스토크에는 안중근을 비롯해 
우덕순, 김상현, 공부인, 최재형, 이창섭 등 
빼앗긴 나라를 되찾기 위해 마음을 함께하는 이들이 모이게 된다. 
이토 히로부미가 러시아와 협상을 위해 
하얼빈으로 향한다는 소식을 접한 
안중근과 독립군들은 하얼빈으로 향하고, 
내부에서 새어 나간 이들의 작전 내용을 입수한 
일본군들의 추격이 시작되는데… 

하얼빈을 향한 단 하나의 목표, 
늙은 늑대를 처단하라]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('2',q'[소방관]',q'[FIREFIGHTERS]','106','88246','3733868',to_date('20241204','yyyy-mm-dd'),q'[살리기 위해, 살아남기 위해 
하루하루가 마지막 현장인 소방관 팀은 
열악한 환경 속에서도 화재 진압과 전원 구조라는 
단 하나의 목표로 의기투합한다. 
어느 날, 다급하게 119 신고 전화로 
홍제동에 화재가 발생했다는 긴급 상황이 접수되자 
팀원들은 위기를 직감하는데… 

누군가의 가족, 친구, 사랑하는 사람 
우리가 기억해야 할 그 이름 
<소방관> 
 2001년 가장 빛났던 그들의 이야기를 기억하겠습니다.]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('3',q'[서브스턴스]',q'[The Substance]','141','48621','253894',to_date('20241211','yyyy-mm-dd'),q'[더 나은 당신을 꿈꿔본 적 있는가? 

한때 아카데미상을 수상하고 
명예의 거리까지 입성한 대스타였지만, 
지금은 TV 에어로빅 쇼 진행자로 전락한 엘리자베스(데미 무어). 
50살이 되던 날, 프로듀서 하비(데니스 퀘이드)에게서 
“어리고 섹시하지 않다”는 이유로 해고를 당한다. 
돌아가던 길에 차 사고로 병원에 실려간 엘리자베스는 
매력적인 남성 간호사로부터 ‘서브스턴스’라는 약물을 권유 받는다. 
한 번의 주사로 “젊고 아름답고 완벽한” 
수(마가렛 퀄리)가 탄생하는데... 

단 한 가지 규칙, 당신에게 주어진 시간을 지킬 것. 
각각 7일간의 완벽한 밸런스를 유지한다면 무엇이 잘못되겠는가? 
‘기억하라, 당신은 하나다!’]','1');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('4',q'[동화지만 청불입니다]',q'[FORBIDDEN FAIRYTALE]','109','44484','161703',to_date('20250108','yyyy-mm-dd'),q'[동화 작가가 꿈이지만 현실은 불법 음란물 단속팀 새내기인 ‘단비’는 
스타 작가를 찾던 성인 웹소설계 대부 ‘황대표’와 
우연한 사고로 노예 계약을 맺게 되면서 
하루아침에 19금 소설을 쓰게 된다. 

생전 접한 적 없는 장르를 집필하는 데 난항을 겪던 ‘단비’는 
음란물 단속을 하다 권태기에 빠진 선배 ‘정석’의 응원과, 
친구들의 생생한 경험담에 힘입어 
어느새 자신도 알지 못했던 성스러운 재능을 발견하게 되는데…]','1');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('5',q'[뽀로로 극장판 바닷속 대모험]',q'[Pororo Movie Underwater Adventure]','72','42200','328000',to_date('20250101','yyyy-mm-dd'),q'[“대장님 같은 영웅이 되고 싶어요!” 

바다의 수호자 ‘레드헌터스’를 이끄는 ‘머록’ 대장을 따라 
바다를 지키는 영웅이 되기 위해 
바닷속 모험을 떠난 뽀로로와 친구들. 

하지만 거대한 괴물 ‘시터스’가 
뽀로로와 친구들의 잠수함을 통째로 삼켜버리고, 
‘머록’ 대장의 도움으로 가까스로 구출된 ‘뽀로로’와 ‘크롱’은 
‘시터스’에게 잡혀간 친구들을 구하기 위해 
‘최후의 시터스’ 사냥에 나선 ‘레드헌터스’의 
마지막 작전에 함께하기로 한다. 

그러나, 비밀스러운 소녀 ‘마린’이 나타나 
그들의 작전을 방해하기 시작하고 
바닷속에 숨겨진 진짜 비밀이 드러나게 되는데… 

과연, 뽀로로와 친구들은 신비한 비밀을 풀고 
진정한 ‘씨 가디언즈’가 될 수 있을까?]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('6',q'[수퍼 소닉3]',q'[Sonic the Hedgehog 3]','110','40016','324028',to_date('20250101','yyyy-mm-dd'),q'[더 빠르고 더 강해야만 한다! 

초특급 히어로 소닉 VS 사상 최강의 라이벌 섀도우의 수퍼 빅 매치! 

너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 
연구 시설에 50년간 잠들어 있던 
사상 최강의 비밀 병기 "섀도우"가 탈주하자, 
세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 
소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 
소닉의 초고속 스피드와 너클즈의 최강 펀치를 단숨에 제압해버린다. 
세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 
섀도우의 엄청난 힘 카오스 에너지를 이용해 
인류를 정복하려고 하는데… 

초특급 히어로 소닉 VS 사상 최강의 라이벌 섀도우! 
전 세계를 파괴하려는 섀도우를 막기 위한 
파워업 액션 어드벤처가 시작된다!]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('7',q'[극장판 짱구는 못말려: 우리들의 공룡일기]',q'[映画クレヨンしんちゃん オラたちの恐竜日記 Crayon Shinchan the Movie: Our Dinosaur Diary]','105','36516','744283',to_date('20241218','yyyy-mm-dd'),q'[다이노스 아일랜드에 어서 오세요! 

멸종된 공룡을 현대에 부활시킨 테마파크 다이노스 아일랜드 오픈! 
떡잎마을은 물론, 전국이 공룡 열풍에 빠져든다! 

그 무렵, 흰둥이는 어디선가 작은 공룡 나나를 발견한다. 
나나는 짱구네 집의 새로운 가족이자 
떡잎마을 방범대의 친구가 되어 아주 특별한 방학을 보내게 된다. 

한편, 자신이 나나의 주인이라는 빌리가 나타나 
나나를 데려가겠다 하고 
다이노스 아일랜드 창립자 버블 어마무시와 그의 수하들도 
수단과 방법을 가리지 않고 나나와 짱구를 쫓는다. 
설상가상으로 다이노스 아일랜드의 공룡들이 탈출해 
떡잎마을은 물론 도시 전역을 쑥대밭으로 만들어버리는데…! 

나나를 지키기 위한 짱구, 흰둥이, 
떡잎마을 방범대의 사투가 시작된다! 

지킬 거야, 나의 소중한 인연! 
초거대 공룡들과 맞서는 지구에서 가장 다이노믹한 짱구가 온다!]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('8',q'[위키드]',q'[Wicked: Part I]','160','27674','2180346',to_date('20241120','yyyy-mm-dd'),q'[자신의 진정한 힘을 미처 발견하지 못한 ‘엘파바’(신시아 에리보) 
자신의 진정한 본성을 아직 발견하지 못한 
‘글린다’(아리아나 그란데). 

전혀 다른 두 사람은 마법 같은 우정을 쌓아간다. 
그러던 어느 날, ‘마법사’의 초대를 받아 에메랄드 시티로 가게 되고 
운명은 예상치 못한 위기와 모험으로 두 사람을 이끄는데… 

마법 같은 운명의 시작, 누구나 세상을 날아오를 수 있어]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('9',q'[무파사: 라이온 킹]',q'[Mufasa: The Lion King]','117','23309','835135',to_date('20241218','yyyy-mm-dd'),q'[‘라이온 킹’ 탄생 30주년 기념작 
외로운 고아에서 전설적인 왕으로 거듭난 
‘무파사’의 숨겨진 이야기가 베일을 벗는다! 

길을 잃고 혼자가 된 새끼 사자 ‘무파사’는 
광활한 야생을 떠돌던 중 왕의 혈통이자 
예정된 후계자 ‘타카(스카)’와 우연히 만나게 된다. 
마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 ‘무파사’와 ‘타카’는 
운명을 개척하기 위해 거대한 여정을 함께 떠난다. 
한 치 앞을 알 수 없는 적들의 위협 속에서 
두 형제의 끈끈했던 유대에 금이 가기 시작하고 
예상치 못한 위기까지 맞닥뜨리게 되는데…]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('10',q'[모아나 2]',q'[MOANA 2]','99','23108','3499568',to_date('20241127','yyyy-mm-dd'),q'[<모아나 2>는 선조들로부터 예기치 못한 부름을 받은 ‘모아나’가 
부족의 파괴를 막기 위해 전설 속 영웅 ‘마우이’와 
새로운 선원들과 함께 숨겨진 고대 섬의 저주를 깨러 떠나는 
위험천만한 모험을 담은 스펙터클 오션 어드벤처]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('11',q'[폭락]',q'[Crypto Man]','101','18728','19502',to_date('20250115','yyyy-mm-dd'),q'[“기대에 부응해야지?”

엄마 옥자의 열성과 본인의 타고난 욕심으로
교육 1번지 서울 대치동으로 위장 전입한 도현.
벤츠 타고 다니는 부자이면서 장애 혜택을 받아먹던 친구에게
교환학생의 기회마저 뺏기고,
그 친구가 진짜 장애인이 아니었단 걸 알게 된 그 때부터
정부 지원금의 맹점에 눈을 뜬다.
대학교 창업동아리에서 만난 동기 지우와 함께
청년·여성·장애 등의 가산점을 악용해 청년 창업 지원금을 수급하고,
“창업 지원금은 나랏돈으로 망해 보라고 주는 눈 먼 돈”임을 간파해
의도적으로 고의부도와 폐업을 전전한다.
투자자 케빈에게 억대 후원을 받는 암호화폐 벤처를 창업한 도현은
야망에 이끌려 ‘MOMMY’ 코인을 개발해
역대 최고치의 실적을 내지만, 알고리즘과 불완전 이자 수익 등
금융기관으로부터 모니터가 들어오게 되는데…]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('12',q'[해리 포터와 죽음의 성물2]',q'[Harry Potter and the Deathly Hallows: Part II]','131','17179','4417765',to_date('20250115','yyyy-mm-dd'),q'[모든 것을 끝낼 최후의 전투! 
판타지의 아름다운 역사가 드디어 마침표를 찍는다! 

덤블도어 교장이 남긴 ‘죽음의 성물’의 단서를 쫓던 해리 포터는 
볼드모트가 그토록 찾아 다닌 
절대적인 힘을 가진 지팡이의 비밀을 통해 
드디어 마지막 퍼즐을 완성한다. 
볼드모트의 영혼이 담긴 다섯 번째 ‘호크룩스’를 찾기 위해 
마법학교 호그와트로 돌아온 해리와 친구들은 
그들을 잡으려는 보안마법에 걸려 위기를 맞지만 
덤블도어의 동생인 에버포스의 도움으로 벗어난다. 
그리고 그에게서 덤블도어와 어둠의 마법사 그린델왈드에 관한 
놀라운 과거에 대해 알게 된다. 
한편, 볼드모트는 해리에 의해 
호크룩스들이 파괴되었음을 느끼고 호그와트로 향한다. 
해리를 주축으로 한 불사조 기사단과 
죽음을 먹는 자들 간의 마법전투가 벌어지고 
여기에 거대거미 아크로맨투라와 거인족 등 
마법 생물들이 볼드모트 편으로 가세하면서 
호그와트는 거대한 전쟁터로 변한다. 
전쟁의 틈에서 해리는 덤블도어를 죽인 스네이프의 엄청난 비밀과 
볼드모트를 죽일 마지막 호크룩스에 대한 단서를 알게 되는데...]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('13',q'[노스페라투]',q'[Nosferatu]','132','17008','18134',to_date('20250115','yyyy-mm-dd'),q'[오랜 시간 통제할 수 없는 강력한 힘에 이끌려 
악몽과 괴로움에 시달려 온 ‘엘렌’ 
남편 ‘토마스’가 거액의 부동산 계약을 위해 
머나먼 ‘올록성’으로 떠난 후부터 
엘렌은 불안 증세가 심해지고 알 수 없는 말을 되뇌인다. 

“그가 오고 있어…” 

기이한 현상들이 일어나며 마을로 점점 짙게 번져오는 그림자. 
영원한 어둠 속에서 깨어난 올록 백작이 찾아오는데…]','1');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('14',q'[러브레터]',q'[When I Close My Eyes Love Letter]','117','15862','730666',to_date('20250101','yyyy-mm-dd'),q'[중학교 시절, 같은 반에 같은 이름을 가진 남자애가 있었습니다. 
그로부터 10년이 지난 어느 날, 
잊고 살았던 그 남자애의 연인에게서 편지가 왔습니다. 
“잘 지내고 있나요? 저는 잘 지내고 있습니다.” 
무심코 편지에 답장을 쓸 때만 해도 저는 몰랐습니다. 
가려졌던 제 기억 속 첫사랑이 누구였는지 깨닫게 될 줄은... 
2025년 1월, <러브레터>를 기억하는 모든 이들에게 묻습니다. 
“아직도 마음속 그리움이 남아 있습니까?”]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('15',q'[보고타: 마지막 기회의 땅]',q'[Bogota: City of the Lost]','106','15254','420078',to_date('20241231','yyyy-mm-dd'),q'[희망 없는 인생, 
기회는 바로 그 곳에 있었다. 

1997년 IMF의 후폭풍을 피하지 못한 국희(송중기)와 가족들은 
지구 반대편 콜롬비아 보고타로 향한다. 
낯선 땅에서 살아남기 위해, 
한인 상인회의 권력을 쥔 박병장(권해효) 밑에서 일을 시작한 국희. 
성실함으로 박병장의 눈에 띈 국희는 
박병장의 테스트로 의류 밀수 현장에 가담하게 되고, 
콜롬비아 세관에게 걸릴 위기 상황 속에서 
목숨 걸고 박병장의 물건을 지켜내며 
박병장은 물론 통관 브로커 수영(이희준)에게도 
강렬하게 존재감을 각인시킨다. 
곧 수영이 국희에게 위험한 제안을 하고, 
이를 눈치 챈 박병장 또한 새로운 계획을 세우며 
국희를 시험에 들게 한다. 
본인의 선택으로 보고타 한인 사회의 판도를 
바꿀 수 있음을 체감한 국희는 점점 더 큰 성공을 열망하게 되는데…]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('16',q'[슈퍼 엘프: 빨간모자 비밀요정]',q'[Die Heinzels 2: Neue Mützen, Neue Mission The Super Elfkins]','76','14897','14897',to_date('20250115','yyyy-mm-dd'),q'[세상이 잠들면, 우리가 깨어난다! 
서로 다른 쪼꼬미 요정들의 시크릿 미션! 

남몰래 인간세상에서 살아가는 엘프족들. 
어느 날, 쾰른족의 말괄량이 ‘엘피’는 
비엔나족의 소심이 ‘보’를 만나게 된다. 

퀼른족과 달리, 
첨단 기술로 무장한 비엔나족에 반한 ‘엘피’는 
‘보’를 따라 도시로 떠난다. 

하지만 엘프의 존재를 알게 된 인간 경찰이 
그들을 쫒기 시작하고, 
‘엘피’와 ‘보’는 가족들을 구하기 위해 손을 잡는데…! 

서로 전혀 달라도 우리는 함께 살아갈 수 있어! 
작지만 큰 그들이 온다!]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('17',q'[반지의 제왕: 두 개의 탑]',q'[The Lord of the Rings: The Two Towers]','179','10293','5193293',to_date('20250115','yyyy-mm-dd'),q'[2002년 12월, 운명을 건 최후의 전쟁이 시작된다! 

9명의 반지원정대는 사우론의 사악한 세력에 맞서 
반지를 지켜냈지만 반지 원정대는 뿔뿔이 흩어지게 된다. 
호빗족으로 절대반지에 유일한 내성을 보이는 ‘프로도’는 
일행과 떨어져 ‘샘’과 함께 불의 산으로 모험을 감행하지만 
새로운 위협을 맞이하고 
사루만의 우르쿠하이 군대에게 잡혀간 ‘메리’와 ‘피핀’은 
엔트 족의 영역에서 ‘트리비어드’라는 엔트 족에게 구출 받게 된다. 
한편 ‘메리’와 ‘피핀’을 구하기 위해 
우루쿠하이 군대를 추격하던 ‘아라곤’과 ‘레골라스’, ‘김리’는 
유령 숲에서 백색의 마법사로 부활한 마법사 ‘간달프’를 만나게 되고 
악의 군주 ‘사우론’이 암흑세계의 두 개의 탑 
‘오르상크’와 ‘바랏두르’를 통합하여 
점점 그 세력을 넓혀가고 있다는 사실을 듣게 된다. 
이에 ‘아라곤’과 나머지 원정대는 
중간계의 선한 무리의 통합을 이뤄 
‘사우론’의 강력한 세력을 견제해야하는 큰 임무를 맡게 된다. 
하지만 동맹관계가 깨져 ‘곤도르’ 왕국과 
‘로한’왕국으로 나뉜 인간 종족의 통합은 쉽지 않고 
게다가 ‘로한’의 왕마저 ‘사루만’에게 동화되는데.. 
결국 ‘사우론’은 서서히 중간계를 거대한 전쟁의 
소용돌이로 몰고 가고 ‘아라곤’ 또한 
인간과 엘프, 난쟁이족, 그리고 엔트족 등을 통합하여 
이에 맞설 준비를 한다. 
결코 피할 수 없는 거대한 전쟁이 시작된 것이다.]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('18',q'[더 폴: 디렉터스 컷]',q'[The Fall]','119','10187','69437',to_date('20241225','yyyy-mm-dd'),q'[무성영화 시대의 할리우드를 배경으로, 
스턴트맨 ‘로이’는 같은 병원에 입원한 
호기심 많은 어린 소녀 ‘알렉산드리아’와 친구가 되고, 
매일 다섯 무법자의 환상적인 모험 이야기를 해준다. 
이야기는 현실과 상상이 뒤섞이면서 
‘알렉산드리아’를 신비의 세계로 데려간다. 

4년에 걸쳐 전 세계 24개국, 
NO CGI로 촬영한 믿을 수 없는 황홀경 
18년 만에 4K로 부활한 영상미학의 궁극]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('19',q'[리얼 페인]',q'[A REAL PAIN]','90','9898','10446',to_date('20250115','yyyy-mm-dd'),q'[달라도 너무 다른 정반대 사촌과의 여행, 괜찮을까? 

생김새부터 성격, 취향까지 모든 것이 다른 두 사촌 
‘데이비드’(제시 아이젠버그)와 ‘벤지’(키에란 컬킨). 
돌아가신 할머니를 기리기 위해 오랜만에 재회한다. 
한때는 형제처럼 친밀했지만 
각자의 삶과 가족 등의 이유로 멀어졌던 둘의 관계는 
할머니의 고향인 폴란드를 방문해 투어를 떠나게 되면서 
새로운 국면을 맞이한다. 
둘의 극과 극 성격은 투어에서도 균열을 만들고, 
예상치 못한 일들이 생기면서, 
미묘한 감정의 골 또한 더욱 커져만 가는데… 

2025년 새해, 
당신을 위한 웰메이드 로드 무비가 온다!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('20',q'[검은 수녀들]',default,default,'8738','8738',to_date('','yyyy-mm-dd'),default,default);
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('21',q'[데드데드 데몬즈 디디디디 디스트럭션: 파트1]',q'[デッドデッドデーモンズデデデデデストラクション DEAD DEAD DEMONS DEDEDEDE DESTRUCTION]','120','8737','28117',to_date('20250108','yyyy-mm-dd'),q'[정체불명 초거대 우주 모함 도쿄 상공 출현! 
내일 지구가 폭망해도 오늘을 즐기는 
하이텐션 고교 라이프! 

3년 전 그날 이후 조용하지만 착실히 멸망은 진행 중… 
아이도 어른도 아닌 우리, 일상도 비일상도 아닌 그때. 
모든 게 불확실했지만, 이것 하나만큼은 선명했습니다. 

나는 너에게, 너는 나에게 ‘절대적’이란 것!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('22',q'[시빌 워: 분열의 시대]',q'[Civil War]','109','7087','111562',to_date('20241231','yyyy-mm-dd'),q'[세상이 둘로 갈라졌다. 당신은 어느 편인가? 

극단적 분열로 역사상 최악의 내전이 벌어진 미국. 
연방 정부의 무차별 폭격과 서로를 향한 총탄이 빗발치는 상황 속에서 
기자 ‘리(커스틴 던스트)’와 ‘조엘(와그너 모라)’, 
‘새미(스티븐 핸더슨)’, 그리고 ‘제시(케일리 스페니)’는 
대통령을 인터뷰하기 위해 워싱턴으로 향한다. 

내 편이 아니라면 바로 적이 되는 숨 막히는 현실, 
이들은 전쟁의 순간을 누구보다 생생하게 마주하게 된다. 

이것은 영화가 아니다. 
진짜 공포다!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('23',q'[인터스텔라]',q'[Interstellar]','169','4345','10313029',to_date('20141106','yyyy-mm-dd'),q'[“우린 답을 찾을 거야, 늘 그랬듯이” 

세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다. 
지난 20세기에 범한 잘못이 전 세계적인 식량 부족을 불러왔고, 
NASA도 해체되었다. 
이때 시공간에 불가사의한 틈이 열리고, 
남은 자들에게는 이 곳을 탐험해 인류를 구해야 하는 임무가 지워진다. 
사랑하는 가족들을 뒤로 한 채 인류라는 더 큰 가족을 위해, 
그들은 이제 희망을 찾아 우주로 간다. 
그리고 우린 답을 찾을 것이다. 늘 그랬듯이…]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('24',q'[페라리]',q'[FERRARI]','130','4278','41255',to_date('20250108','yyyy-mm-dd'),q'[1957년, 전세계를 뒤흔든 
‘페라리’의 충격 실화가 드러난다! 

파산 위기에 놓인 '엔초 페라리'. 
회사 존폐의 기로에서 사사건건 충돌하는 아내 라우라. 
아들 피에로를 페라리 가로 인정하라고 압박하는 또다른 여인 리나. 

평생 쌓아온 모든 것이 무너지기 직전인 1957년 여름, 
이탈리아 전역 공도를 가로지르는 
광기의 1,000마일 레이스 ‘밀레 밀리아’에서 
엔초 페라리는 판도를 뒤집을 마지막 승부수를 던지는데...]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('25',q'[렛 미 인]',q'[Låt den rätte komma in Let the Right One in]','114','3696','91774',to_date('20250115','yyyy-mm-dd'),q'[내가 평범한 여자애가 아니라도… 
나를 좋아해줄래? 

눈이 내리던 어느 밤, 외톨이 ‘오스칼’은 
옆집에 이사 온 소녀 ‘이엘리’를 만난다 

신비로운 매력의 ‘이엘리’에게 첫눈에 반한 ‘오스칼’은 
12살 하고도 8개월 9일이 되던 그날, 
운명적인 첫사랑을 시작한다 

한편 마을에서는 기이한 살인 사건이 이어지고, 
‘오스칼’은 ‘이엘리’가 
의문의 사건과 이어져 있다는 사실을 알게 되는데… 

사랑을 모르는 소년과 뱀파이어 소녀 
영원한 첫사랑이 다시 시작된다!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('26',q'[히트맨2]',q'[HITMAN2]','118','3121','3368',to_date('20250122','yyyy-mm-dd'),q'[‘HITMAN IS BACK!’ 

대한민국을 포복절도하게 만든 암살요원, 
이번엔 ‘암살요인 준’으로 돌아왔다! 

욱해서 그린 웹툰 ‘암살요원 준’의 성공으로 
잠깐 흥행 작가가 된 ‘준’은 
시즌2 연재 시작과 동시에 ‘뇌절작가’로 전락하고, 
망작이 된 시즌2는 되려 ‘준’을 노리는 
글로벌한 악당들의 내한 열풍을 일으킨다. 

아무것도 모른 채, 다시 한번 대히트를 꿈꾸며 
신작 웹툰 연재에 돌입한 ‘준’. 
그러나 그의 웹툰을 모방한 테러가 발생하고, 
국정원은 다름 아닌 ‘준’을 범인으로 지목하는데… 

과연 ‘준’은 예언자인가, 테러리스트인가. 
2025년 더욱 강렬해진 그의 대히트를 기대하라!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('27',q'[이처럼 사소한 것들]',q'[Small Things Like These]','98','2709','51095',to_date('20241211','yyyy-mm-dd'),q'[1985년 아일랜드의 소도시, 빌 펄롱은 석탄을 팔며 
아내, 다섯 딸과 함께 소박하게 살아가고 있다. 
크리스마스를 앞둔 어느 날, 
지역 수녀원에 석탄을 배달하러 간 빌 펄롱은 
숨겨져 있던 어떤 진실을 마주하게 된다.]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('28',q'[파문]',q'[波紋 Ripples]','120','2445','2996',to_date('20250115','yyyy-mm-dd'),q'[남편이 집을 나간 후, 
생명수를 숭배하는 사이비 종교에 빠진 ‘요리코’. 

매일 생명수에 기도를 올리고 정원을 정리하며 
평온한 일상을 보내던 어느 날, 
집을 나갔던 남편이 암에 걸려 돌아오며 
잔잔했던 ‘요리코’의 마음에 커다란 파문이 일기 시작하는데…]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('29',q'[더 엑소시즘]',q'[The Exorcism]','95','2293','2293',to_date('20250115','yyyy-mm-dd'),q'[공포 영화 ‘조지타운 프로젝트’를 촬영하던 중 
끔찍한 사고로 사제를 연기한 배우가 사망하고, 
한물간 배우 ‘앤서니’(러셀 크로우)가 그 자리를 맡게 된다. 
하지만 사제 역할에 몰입하게 될수록 
악마가 그의 주변을 맴돌기 시작하는데… 

저주받은 작품인가, 저주를 부르는 캐릭터인가! 
올해를 압도할 첫 오컬트 공포작!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('30',q'[코넬의 상자]',q'[Cornell's Box]','101','2064','7508',to_date('20250108','yyyy-mm-dd'),q'[줄거리가 없습니다.]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('31',q'[타오르는 여인의 초상]',q'[Portrait de la jeune fille en feu Portrait of a Lady on Fire]','120','1929','155688',to_date('20200116','yyyy-mm-dd'),q'[“후회하지 말고 기억해” 

초상화를 그리는 화가 마리안느(노에미 멜랑)는 
원치 않는 결혼을 앞둔 귀족 아가씨 엘로이즈(아델 에넬)의 결혼 초상화 의뢰를 받는다. 
엘로이즈 모르게 그림을 완성해야 하는 마리안느는 비밀스럽게 그녀를 관찰하며 
알 수 없는 묘한 감정의 기류에 휩싸이게 된다. 

잊을 수 없는, 잊혀지지 않을 사랑의 기억을 마주하게 할 걸작을 만난다!]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('32',q'[쇼잉 업]',q'[SHOWING UP]','108','1802','7182',to_date('20250108','yyyy-mm-dd'),q'[조각가 리지 카르는 
경력의 전환점이 될지도 모르는 전시회를 준비하고 있다. 
준비하는 동안 리지는 사적으로 공적으로 다양한 일들에 휘말리고, 
그 경험이 작업에 영감을 준다는 걸 깨닫게 된다.]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('33',q'[극장판 주술회전 0]',q'[劇場版 呪術廻戦 ０ Jujutsu Kaisen: Zero]','105','1732','728054',to_date('20241211','yyyy-mm-dd'),q'[어릴 적 소꿉친구인 오리모토 리카를 
교통사고로 눈앞에서 잃은 옷코츠 유타. 

“약속해, 리카와 유타는 어른이 되면 결혼하기로” 
옷코츠는 원령으로 변한 리카의 저주에 괴로워한 나머지, 
자신도 죽기를 바라지만 
최강의 주술사인 고죠 사토루에 의해 주술고전에 들어가게 된다. 
그리고 동급생인 젠인 마키, 이누마키 토게, 
판다를 만나면서 굳은 결심을 한다. 

“살아도 된다는 자신감이 필요해” 
“나는 주술고전에서 리카의 저주를 풀겠습니다” 
한편, 옷코츠와 친구들 앞에 
과거에 일반인을 대량으로 학살해서 고전에서 추방된 
최악의 주저사인 게토 스구루가 나타난다. 

“12월 24일, 우리는 백귀야행을 결행한다” 
주술사만의 낙원을 만들려는 게토는 비술사를 섬멸하겠다면서, 
신주쿠와 교토에 천의 저주를 내리는데……. 
과연 옷코츠는 게토를 막을 수 있을까? 
그리고 리카의 저주를 풀 수 있을까?]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('34',q'[대가족]',q'[About Family]','106','1287','304259',to_date('20241211','yyyy-mm-dd'),q'[줄이 끊이지 않는 맛집 사장 무옥 
승려 선언한 외아들 문석 때문에 대가 끊기다? 
마지막 함씨 가문! 세울 것인가, 무너질 것인가! 

자수성가 맛집의 근본, SNS 없던 시절부터 
줄 서 먹던 노포 맛집 평만옥의 사장 무옥(김윤석)은 
대를 이을 줄 알았던 외아들 문석이 
승려가 되어 출가한 이후 근심이 깊어 간다. 
자신의 대에서 끊겨버릴 예정인 가문을 걱정하던 가운데 
어느 날, 평만옥에 문석이 자신의 아빠라며 방문한 어린 손님들! 
끊길 줄 알았던 가문의 대를 잇게 생긴 무옥은 
난생 처음 맛보는 행복을 느끼고 
문석은 승려가 되기 이전의 과거를 되짚다 
그만 충격적인 사실을 알게 되는데…]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('35',q'[(여자)아이들 월드투어 [아이돌] 인 시네마]',q'[(G)I-DLE WORLD TOUR [iDOL] IN CINEMAS]','102','1241','5196',to_date('20240108','yyyy-mm-dd'),q'[“진짜 제대로 즐길 준비 됐죠?” 

2024년 전 세계 14개 도시의 관객을 사로잡은 
(여자)아이들의 세 번째 월드투어 
‘2024 (G)I-DLE WORLD TOUR [iDOL]’ 
그 뜨거웠던 축제의 시작, 서울 콘서트의 현장이 스크린에 펼쳐진다! 

전율을 선사한 ‘Super Lady’를 시작으로 ‘LATATA’, 
‘퀸카(Queencard)’, ‘TOMBOY’ 무대는 물론 
화려한 퍼포먼스와 완벽한 라이브로 꽉 채워진 셋 리스트까지! 

모두에게 꿈같았던 그날의 감동을 
2025년 1월 SCREENX, 4DX, ULTRA 4DX로 
더 크게, 더 생생하게 다시 만난다!]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('36',q'[성 베드로 대성당과 로마의 교황청 대성당들]',q'[ST. PETER’S AND THE PAPAL BASILICAS OF ROME]','95','1210','1217',to_date('20250115','yyyy-mm-dd'),q'[줄거리가 없습니다.]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('37',q'[리틀 포레스트]',q'[LITTLE FOREST]','103','1113','1507157',to_date('20180228','yyyy-mm-dd'),q'[“잠시 쉬어가도, 달라도, 평범해도 괜찮아! 모든 것이 괜찮은 청춘들의 아주 특별한 사계절 이야기” 

시험, 연애, 취업… 뭐하나 뜻대로 되지 않는 일상을 잠시 멈추고 
고향으로 돌아온 혜원은 오랜 친구인 재하와 은숙을 만난다 

남들과는 다른, 자신만의 삶을 살기 위해 고향으로 돌아온 ‘재하’, 
평범한 일상에서의 일탈을 꿈꾸는 ‘은숙’과 함께 
직접 키운 농작물로 한끼 한끼를 만들어 먹으며 
겨울에서 봄, 그리고 여름, 가을을 보내고 
다시 겨울을 맞이하게 된 혜원. 

그렇게 특별한 사계절을 보내며 
고향으로 돌아온 진짜 이유를 깨닫게 된 혜원은 
새로운 봄을 맞이하기 위한 첫 발을 내딛는데…]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('38',q'[스즈메의 문단속]',q'[すずめの戸締まり Suzume]','121','1019','5557458',to_date('20230308','yyyy-mm-dd'),q'[“이 근처에 폐허 없니? 문을 찾고 있어” 

규슈의 한적한 마을에 살고 있는 소녀 ‘스즈메’는 
문을 찾아 여행 중인 청년 ‘소타’를 만난다. 

그의 뒤를 쫓아 산속 폐허에서 발견한 낡은 문. 
‘스즈메’가 무언가에 이끌리듯 문을 열자 마을에 재난의 위기가 닥쳐오고 
가문 대대로 문 너머의 재난을 봉인하는 ‘소타’를 도와 간신히 문을 닫는다. 

“닫아야만 하잖아요, 여기를!” 
재난을 막았다는 안도감도 잠시, 
수수께끼의 고양이 ‘다이진’이 나타나 ‘소타’를 의자로 바꿔 버리고 
일본 각지의 폐허에 재난을 부르는 문이 열리기 시작하자 
‘스즈메’는 의자가 된 ‘소타’와 함께 재난을 막기 위한 여정에 나선다. 

“꿈이 아니었어” 
규슈, 시코쿠, 고베, 도쿄 
재난을 막기 위해 일본 전역을 돌며 필사적으로 문을 닫아가던 중 
어릴 적 고향에 닿은 ‘스즈메’는 잊고 있던 진실과 마주하게 되는데…]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('39',q'[김재중 20주년 기념 콘서트: 플라워 가든]',q'[Kim Jae Joong The 20th Anniversary Concert: Flower Garden]','104','973','4498',to_date('20250109','yyyy-mm-dd'),q'[지난 2024년 7월 21일 개최된 김재중 데뷔 20주년 기념 콘서트, 
‘20TH ANNIVERSARY 
2024 KIM JAE JOONG ASIA TOUR CONCERT 
“FLOWER GARDEN” in SEOUL’의 공연 실황 영화. 

새 앨범 FLOWER GARDEN의 타이틀 곡 ‘Glorious Day’는 물론, 
도파민 터지는 무대 ‘Devotion’, ‘Dopamine’과 
본격적으로 관객과 함께 즐기는 ‘Summer J’ ‘소년에게’ 등 
눈으로 보고 귀로 듣는 명품 무대를 통해 
장르가 김재중임을 다시 한번 입증한다. 

또한 콘서트 리허설 및 연습 과정과 
데뷔 20주년을 맞은 그의 솔직한 인터뷰, 
여기에 팬들에게 보내는 ‘직접 쓴 음성 편지’까지 만날 수 있다. 

김재중과 그의 정원에 가득한 꽃들이 만들어 낸 
아름다운 순간이 스크린에 펼쳐진다.]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('40',q'[퍼스트레이디]',q'[THE FIRST LADY]','105','972','79106',to_date('20241212','yyyy-mm-dd'),q'[돋보이고 싶은 욕심에 학력과 경력을 부풀리고 
논문 표절 의혹에 휩싸인 대한민국 대통령 영부인. 
숱한 무속인 관련설, 대통령실과 공관 이전 논란, 
국정개입을 넘어선 공동정권설, 과거 저지른 사문서 위조와 
주가조작 연루 사건, 고가의 디올백 수수, 
양평고속도로 노선 변경, 민간인 국정 개입 의혹 등 
다이내믹한 대한민국의 영부인의 실체적 이야기를 다룬 
용산 VIP를 둘러싼 문제적 다큐멘터리 영화]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('41',q'[고스트캣 앙주]',q'[化け猫あんずちゃん Ghost Cat Anzu]','95','921','1876',to_date('20240122','yyyy-mm-dd'),q'[꾹꾹이 알바하는 고양이 실존?! 
귀여운 동안 외모지만 37세다냥~ 

한적한 시골 마을에 위치한 ‘소세지절’ 
아빠 ‘테츠야’는 엄마 기일 전까지 돌아온다는 말을 
남기고 떠나고, 11세 소녀 ‘카린’만 혼자 남는다. 
그런 ‘카린’의 무료한 일상에 37살 고양이 요괴 ‘앙주’가 등장한다. 

귀차니즘 아재 고양이 ‘앙주’와 
한집살이를 시작한 까칠한 소녀 ‘카린’. 

투닥거리는 사이 미운 정, 고운 정 다 들어버린 둘은 
‘카린’이 그리워하는 엄마를 만나기 위해 
저승으로 함께 떠나게 되는데… 

37살 아재 고양이 요괴 ‘앙주’와 시니컬한 11살 젠지 소녀 ‘카린’의 
아주 특별한 저세상 여행이 시작된다!]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('42',q'[투 브라더스]',default,default,'834','834',to_date('','yyyy-mm-dd'),default,default);
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('43',q'[색, 계]',q'[色,戒 Lust, Caution]','157','820','1876117',to_date('20250101','yyyy-mm-dd'),q'[1938년 홍콩. 
대학에서 연극에 매료된 왕 치아즈(탕웨이)는 
친일파 핵심인물이자 정보부 대장인 이(양조위)를 암살하기 위해 
막 부인으로 신분을 위장해 그에게 접근한다. 
서로에게 강하게 이끌리는 두 사람, 
그러나 이의 상하이 발령으로 암살 계획은 무산된다. 

1941년 상하이. 
다시 만나게 된 이와 왕 치아즈는 
겉잡을 수 없이 서로에게 빠져들고 
욕망과 의심을 넘나드는 사랑을 시작하는데…]','1');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('44',q'[꼬마 판다 팡의 아프리카 대모험]',q'[Panda Bear in Africa]','89','789','789',to_date('20250122','yyyy-mm-dd'),q'[겁 없는 꼬마 판다의 아프리카 대모험이 시작된다! 

어리지만 용감한 꼬마 판다 ‘팡’은 
아프리카 사자 왕자의 생일 선물로 납치된 
꼬마 용 ‘지에롱’을 구하기 위해 
머나먼 아프리카로 모험을 떠난다. 

사막과 정글로 이루어진 아프리카에서 
원숭이 ‘조조’, 하이에나 ‘니알라’, 사자 왕자 ‘아데’를 만나며 
절친 ‘지에롱’을 구하기 위한 우정의 모험을 펼쳐나가는데… 

꼬마 판다 팡은 지에롱을 구하고 집으로 돌아갈 수 있을까?]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('45',q'[코만치 영역]',default,default,'708','1168',to_date('','yyyy-mm-dd'),default,default);
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('46',q'[은빛살구]',q'[Silver Apricot]','122','687','2340',to_date('20250115','yyyy-mm-dd'),q'[퇴근 후 뱀파이어 웹툰을 그리는 웹툰 작가이자 
비정규직 웹디자이너 ‘정서’(나애진). 
남자 친구 ‘경현’(강봉성)과의 결혼을 앞두고 
서울의 아파트 청약에 당첨되지만 계약금 준비가 쉽지 않다. 
이에 엄마 ‘미영’(박현숙)은 이혼할 때 
‘영주’(안석환)에게 받은 차용증이 붙은 색소폰을 건네주고, 
‘정서’는 아버지 ‘영주’가 있는 
강원도 동해시의 묵호항 벌교횟집으로 향한다. 
그곳에서 가깝지만 먼, 낯선 가족들의 욕망에 휘말리게 되는데…]','3');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('47',q'[사일런트 러브]',q'[サイレントラブ Silent Love]','115','663','5671',to_date('20250108','yyyy-mm-dd'),q'[“그가 어떤 사람이든 상관없어, 그 손으로 나를 구해줬어” 
방황하던 시절 한순간의 실수로 목소리를 잃은 ‘아오이’는 
학교 청소부로 일하며 무미건조한 삶을 이어간다. 

촉망받는 피아니스트이지만 교통사고로 시력을 잃은 ‘미카’는 
절망 끝에 대학 옥상에서 투신을 시도한다. 

“네가 꿈을 이뤘으면 좋겠어. 나한테는 없으니까” 
마침 그곳에서 작업을 하던 ‘아오이’가 ‘미카’를 말리게 되고 
흐느껴 우는 ‘미카’에게서 눈을 떼지 못한다. 

며칠 후 ‘아오이’는 폐강당에서 피아노를 치는 ‘미카’를 발견하고 
그녀가 빛을 되찾을 때까지 
자신의 모든 것을 걸고 지키기로 마음먹는다.]','2');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('48',q'[니코: 오로라 원정대의 모험]',q'[Niko - Beyond the Northern Lights]','85','662','59534',to_date('20241225','yyyy-mm-dd'),q'[크리스마스 이브에 산타클로스의 썰매가 사라졌다고?! 

산타비행단이 되어 전세계에 크리스마스를 선물하는 꿈을 
키워나가는 사고뭉치 꼬마 사슴 ‘니코’ 

비행 스킬 만렙의 사슴 ‘스텔라’가 나타나 
치열한 경쟁 속에서도 서서히 친구가 되어가던 어느 날, 
돌연 ‘스텔라’와 산타의 썰매가 자취를 감춰버리는 사건이 발생한다! 
크리스마스가 사라져버릴 지도 모르는 절체절명의 위기 속에서 
‘니코’는 썰매를 되찾기 위해 날다람쥐 ‘줄리어스’, 
흰족제비 ‘윌마’와 함께 꽁꽁 얼어붙은 북쪽 땅으로 향하는데... 

과연, ‘니코’와 친구들은 신비한 오로라 속 비밀을 밝혀내고 
무사히 크리스마스를 지켜낼 수 있을까?]','4');
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('49',q'[극장판 포켓몬스터]',default,default,'641','641',to_date('','yyyy-mm-dd'),default,default);
insert into tblMovie (seqM, korName, engName, movieTime, pplCount, pplTotalCount, openDate, content, movieAge) values ('50',q'[히든페이스]',q'[HIDDEN FACE]','115','583','1009815',to_date('20241120','yyyy-mm-dd'),q'[‘갇혔다 지켜봤다 벗겨졌다’ 

지휘자 ‘성진’(송승헌)이 이끄는 오케스트라의 
첼리스트이자 약혼녀 ‘수연’(조여정)이 
어느 날 영상 편지만을 남겨둔 채 자취를 감춘다. 
‘성진’은 ‘수연’을 잃은 상실감에 고통스러워하지만, 
그녀를 대신한 첼리스트 ‘미주’(박지현)에게 강한 끌림을 느낀다. 
비 오는 밤, 서로의 욕망에 휩쓸린 ‘성진’과 ‘미주’는 
‘수연’의 집에서 용서받지 못할 짓을 저지른다. 

한편 사라진 줄 알았던 ‘수연’은 
혼자서는 절대 나올 수 없는 집 안 밀실에 갇혀 
숨겨진 민낯을 지켜보는데...]','1');








--tblCountrymade 인서트
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),1,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),2,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),3,4);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),3,3);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),3,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),4,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),5,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),6,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),6,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),7,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),8,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),9,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),10,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),10,6);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),11,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),12,7);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),12,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),13,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),14,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),15,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),16,8);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),17,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),17,8);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),17,9);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),18,3);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),19,10);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),19,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),20,default);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),21,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),22,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),23,3);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),23,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),24,11);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),24,3);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),24,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),25,3);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),25,12);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),25,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),26,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),27,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),28,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),29,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),30,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),31,4);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),32,2);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),33,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),34,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),35,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),36,11);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),37,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),38,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),39,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),40,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),41,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),42,default);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),43,13);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),44,14);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),45,default);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),46,1);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),47,5);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),48,15);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),48,16);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),48,17);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),48,8);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),49,default);
insert into tblCountryMade (seqmadecountry,seqm,seqcountrynum) values ((SELECT NVL(MAX(seqmadecountry), 0) + 1 FROM tblCountryMade),50,1);
