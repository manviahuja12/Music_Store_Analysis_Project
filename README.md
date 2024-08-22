# Music_Store_Analysis_Project
Analyzing a music records database using SQL to uncover key insights into customer behavior, music genre popularity, and sales performance.

## Objective
The primary objective of this project was to analyze a music records database to derive key insights regarding customer behavior, music genre popularity, top-performing artists, and overall sales performance. By writing SQL queries, the goal was to generate actionable data that could support business decisions such as customer promotions, artist invitations, and understanding regional preferences.

## Technology Used
- **Database Management System**: PostgreSQL
- **Tool**: pgAdmin 4
- **Language**: SQL

## Project Overview
The project involved analyzing an 11-table database:
- `album`
- `artist`
- `customer`
- `employee`
- `genre`
- `invoice`
- `invoice_line`
- `media_type`
- `playlist`
- `playlist_track`
- `track`

The queries executed ranged from identifying the top-performing artists and genres to understanding customer behavior based on their purchases.

## Key Insights

### Employee Insights
- **Senior Most Employee**: Identified the senior-most employee based on their job title.

### Sales Insights
- **Country with the Most Invoices**: Determined the country with the highest number of invoices.
- **Best Customer City**: Found the city with the highest revenue from invoices.
- **Best Customer**: Identified the customer who spent the most on music.

### Customer Behavior
- **Top Customers**: Recognized the best customers by their spending patterns.
- **Popular Genres by Country**: Identified the most popular music genres by country, considering ties for the top genre.
- **Top Customer per Country**: Determined the top customer for each country by total spending.

### Artist Analysis
- **Top Rock Bands**: Discovered the most prolific rock bands by counting their tracks.
- **Spending on Best-Selling Artist**: Analyzed which customers spent the most on the top-grossing artist.

### Track Analysis
- **Longest Tracks**: Listed the longest tracks based on their duration compared to the average track length.

## Summary
This project focuses on analyzing music sales data to answer key questions related to customers, artists, genres, and sales trends. By using SQL queries, we identified top-performing artists, the most popular genres in different countries, and the best customers based on spending. The results provide valuable insights for decision-making, like targeting promotional events in specific cities or recognizing top customers. The project showcases how data can help us understand business performance and customer preferences in the music industry.

