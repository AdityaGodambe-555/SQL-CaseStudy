/*Perform Exploratory Data Analysis on 'Indian Premiere League'*/
/* write a querey to find Number of Matches played in each IPL season*/
select season,count(team1) as NoOfMatches 
from matches 
group by season 
order by NoOfMatches desc;

/*Number of teams participated each season */
select season,count(distinct(team1)) 
from matches 
group by season 
order by season;

/*Numbers of matches won by each team */
select team1,count(winner) as NoOfWins
from matches 
group by team1
order by NoOfWins desc;

/* Top 10 Venue which has hosted most number of IPL matches */
select venue,count(venue) NoOfMatches
from matches
group by venue
order by 2 desc  /* Here '2' is 2nd column in select ie. NoOfMatches */
limit 10;

/* Does teams choose to bat or field first, after winning toss ?*/
select toss_decision,count(toss_decision) as Number 
from matches 
group by toss_decision
order by 1 desc;

/*How toss decision affects match results ? */
select toss_decision,count(toss_decision) NoOfWins
from matches 
where toss_winner=winner
group by toss_decision
order by 2 desc;

/* Number of Toss won by individual team */
select toss_winner,count(toss_winner) as NoOfTossWins
from matches 
group by toss_winner
order by 2 desc;

/* Which top 10 player's performance has mostly led team's win  */
select player_of_match,count(player_of_match) as NoOfPOM 
from matches 
group by player_of_match
order by 2 desc
limit 10;

/*Teams total scoring runs over the years means total runs scored by season wise */
select m.season,sum(total_runs)
from matches m 
join deliveries_all d
on(m.id=d.match_id)
group by m.season
order by 2 desc;

/*Finding the individual batsman: total runs, no of balls palyed, no of matches played, No. of times outs, average_runs and strikeRate*/
select batsman, 
sum(batsman_runs) as TotalRuns, 
count(ball) as NoOfBallsPlayed,
count(distinct(match_id)) as NoOfMatches,
sum(batsman_runs)/count(distinct(match_id)) as Average,
(sum(batsman_runs)/count(ball))*100 as StrikeRate
from deliveries_all
group by batsman
order by 2 desc; 
/*  No. of times outs */
select batsman, count(player_dismissed) as NoOfOUTS
from deliveries_all
where player_dismissed <> 'NA'
group by batsman
order by 2 desc; 

/*Batsmen with the best strike rates with runs more then 3000 */
select batsman from most_runs_average_strikerate 
where total_runs > 3000 order by StrikeRate desc limit 1;

/* Top Wicket Takers of IPL */
select bowler,count(player_dismissed) from deliveries_all
where player_dismissed <> 'NA'
group by bowler
order by 2 desc;

/* Most dot ball balled by bowlers */
select bowler,count(total_runs) as NoOfDotBalls from deliveries_all
where total_runs = 0
group by bowler
order by 2 desc;


