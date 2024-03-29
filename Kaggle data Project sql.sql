Q1) How many olympics games have been held?

    select count(distinct games) as total_olympic_games
    from olympics_history;
	
Q2) List down all Olympics games held so far.

    select distinct oh.year,oh.season,oh.city
    from olympics_history oh
    order by year;
	
Q3)Identify the sport which was played in all summer olympics.
     
	 with t1 as
          	(select count(distinct games) as total_games
          	from olympics_history where season = 'Summer'),
          t2 as
          	(select distinct games, sport
          	from olympics_history where season = 'Summer'),
          t3 as
          	(select sport, count(1) as no_of_games
          	from t2
          	group by sport)
      select *
      from t3
      join t1 on t1.total_games = t3.no_of_games;
 
Q4) Fetch the total no. of sports played in each olympic games.
    
	with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;
	  
Q5)Write SQL query to fetch the top 5 athletes who won the most Olympics gold medal.

   with t1 as
            (select name, team, count(1) as total_gold_medals
            from olympics_history
            where medal = 'Gold'
            group by name, team
            order by total_gold_medals desc),
        t2 as
            (select *, dense_rank() over (order by total_gold_medals desc) as rnk
            from t1)
    select name, team, total_gold_medals
    from t2
    where rnk <= 5;


