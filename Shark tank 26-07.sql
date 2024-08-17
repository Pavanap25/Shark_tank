SELECT * FROM st.st_1;
select count(distinct ep_no) from st_1;
-- total successful pitches
select amount_invested_asked, case when amount_invested_asked >0 then 1 else 0 end as Funding from st_1 ;
-- total successful pitches in total counts
Select sum(a.funding) funding_received, count(*) total_pitches from
(select amount_invested_asked, case when amount_invested_asked >0 then 1 else 0 end as Funding from st_1) a ;
-- percentage of total pitches converted

Select Sum(a.Funding)*100/ count(*)  from(
select amount_invested_asked, case when amount_invested_asked >0 then 1 else 0 end as Funding from st_1) a ;

Select cast(Sum(a.Funding)as float) *100/ cast(count(*) as float)  from(
select amount_invested_asked, case when amount_invested_asked >0 then 1 else 0 end as Funding from st_1) a ;
-- total number of Male Participants

select sum(male) from st_1;
-- total number of FeMale Participants

select sum(Female) from st_1;

Select sum(female)/ Sum(Female+ Male) from st_1;
-- Total invested amount
Select sum(amout_asked) invested_in_lakh from st_1;
-- average equity taken

select avg(a.equity_taken) from
(select * from st_1 where equity_taken > 0) a ;

-- highest deal taken
Select max(amount_invested_asked) from st_1;
-- female proportion
select sum(f.total_female) Totals_female from 
(Select female, case when female>1 then 1 else 0 end as total_female from st_1) f;
select sum(female) from st_1;

-- startup having atleast 1 women
select sum(s.shaw) start_ups  from
(select idea, female, case when female>=1 then  1 else 0 end as shaw from st_1) s;

Select sum(s.female) from
(select idea, female from st_1 where female>=1  ) s;
-- pitches converted having atleast one women
Select sum(b.female_count) from
(Select  case when a.female>0 then 1 else 0 end as female_count from
(select * from st_1 where deal <> 'No Deal') a )b;

-- avg team members
Select avg(team_members) from st_1;
-- amount invested per deal
Select avg(a.amount_invested_asked) from
(select * from st_1 where deal <>'No deal') a;

-- avg age group of contestent
Select avg_age, count(avg_age) from st_1 group by avg_age order by avg_age desc ;

-- Location group of contestent

Select location, count(location) from st_1 group by location order by location desc;

-- Number of Deals in which all the sharks were present
select partners, count(partners) from st_1 where partners<> '-' group by partners order by partners desc;
select max(a.partners) from
(select partners, count(partners) from st_1 where partners<> '-' group by partners order by partners desc) a;

Select count(ashneer_amount_invested)  from st_1 where ashneer_amount_invested is not null AND ashneer_amount_invested <> 0 ;
select a.keyy, a.total_deal_present, b.total_deals from
(select 'Ashneer' as keyy, count(ashneer_amount_invested) total_deal_present from st_1 where ashneer_amount_invested is not  null) a
inner join(
select 'Ashneer' as keyy, count(ashneer_amount_invested) total_deals from st_1 where ashneer_amount_invested is not  null 
AND ashneer_amount_invested<> 0 ) b
on a.keyy=b.keyy;

-- rank wise categorisation
Select brand, amount_invested_asked, sector, rank() over(partition by sector order by amount_invested_asked desc) pavan from st_1;
 