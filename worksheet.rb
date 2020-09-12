########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Which layers are nested in each other?
# Which layers of data "have" within it a different layer?
# Which layers are "next" to each other?

# Things: driver_id, driver, date, cost, rider_id, rider, rating, rides

# Relationships:
# driver_id belongs to a driver
# rides belong to the driver
# date, cost, rider_id, and rating belong to rides
# specific date, cost, rider_id, and rating belong to date, cost, rider, and rating

# Nesting
# dates, cost, rider_id, and rating are next to each other nested in rides
# rides are next to each other nested in driver_id
# driver_ids are next to each other nested inside drivers

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have

# Nesting
# dates, cost, rider_id, and rating are next to each other nested rides
# Use hash for key value pairs of date, cost, rider_id, and rating

# rides are next to each other nested inside driver_id
# Use array since it's a list of rides

# driver_ids nested inside drivers
# Use hash since driver_ids are unique for key value pair

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

# drivers = {
#     driver_id: [
#           # ride at index 0
#         {
#             date: sample_date,
#          cost: sample_cost,
#          rider_id: sample_rider,
#          rating: sample_rating
#         },
#           # ride at index 1
#         {
#             date: sample_date,
#             cost: sample_cost,
#             rider_id: sample_rider,
#             rating: sample_rating
#         },
#     ]
# }

drivers = {
    DR0001: [
        {
            date: "3rd Feb 2016",
            cost: 10,
            rider_id: :RD0003,
            rating: 3,
        },
        {
            date: "3rd Feb 2016",
            cost: 30,
            rider_id: :RD0015,
            rating: 4,
        },
        {
            date: "5th Feb 2016",
            cost: 45,
            rider_id: :RD0003,
            rating: 2,
        },
    ],

    DR0002: [
        {
            date: "3rd Feb 2016",
            cost: 25,
            rider_id: :RD0073,
            rating: 5,
        },
        {
            date: "4th Feb 2016",
            cost: 15,
            rider_id: :RD0013,
            rating: 1,
        },
        {
            date: "5th Feb 2016",
            cost: 35,
            rider_id: :RD0066,
            rating: 3,
        },
    ],

    DR0003: [
        {
            date: "4th Feb 2016",
            cost: 5,
            rider_id: :RD0066,
            rating: 5,
        },
        {
            date: "5th Feb 2016",
            cost: 50,
            rider_id: :RD0003,
            rating: 2,
        },
    ],

    DR0004: [
        {
            date: "3rd Feb 2016",
            cost: 5,
            rider_id: :RD0022,
            rating: 5,
        },
        {
            date: "4th Feb 2016",
            cost: 10,
            rider_id: :RD0022,
            rating: 4,
        },
        {
            date: "5th Feb 2016",
            cost: 20,
            rider_id: :RD0073,
            rating: 5,
        },
    ],

}

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# The number of rides each driver has given
# The total amount of money each driver has made
# The average rating for each driver
# Which driver made the most money?
# Which driver has the highest average rating?
# For each driver, on which day did they make the most money?


# Method gets number of rides a driver has given
# Returns an integer
def get_driver_total_rides(drivers, driver_id)
  num_of_rides = drivers[driver_id].length
end


# Method gets total amount of money a driver has made
# driver_id parameter is a symbol
# Returns an integer
def get_driver_earnings(drivers, driver_id)
  total_earnings = 0

  drivers[driver_id].each do |ride|
    earnings_per_ride = ride[:cost]
    total_earnings += earnings_per_ride
  end

  return total_earnings
end


# Method gets the average rating for a driver
# driver_id parameter is a symbol
# Returns a float
def get_driver_average_rating(drivers, driver_id)
  total_rating = 0.0

  drivers[driver_id].each do |ride|
    total_rating += ride[:rating]
  end

  num_of_rides = drivers[driver_id].length
  average_rating = total_rating / num_of_rides

  return '%.1f' % average_rating
end


# Method gets a driver's total earnings by date
# Returns a hash {date: earnings}
def get_driver_earnings_by_date(drivers, driver_id)
  driver_earnings_by_date = Hash.new(0)

  drivers[driver_id].each do |ride|
    ride_earnings = ride[:cost]
    ride_date = ride[:date]

    driver_earnings_by_date[ride_date] += ride_earnings
  end

  return driver_earnings_by_date
end


# Method gets a driver's top total earnings by date
# (i.e. which day did they made the most money and how much)
# Returns an array [date, earnings]
def get_driver_top_earnings_by_date(drivers, driver_id)
  driver_earnings_by_date = get_driver_earnings_by_date(drivers, driver_id)

  top_earnings_by_date = driver_earnings_by_date.max_by { |date, earnings| earnings}

  return top_earnings_by_date
end


# Method pairs driver_id to top stats (i.e. earnings, rating)
# Returns a hash (e.g. { :driver => driver_id, :earnings => 100 })
def  pair_driver_to_top_stats(drivers, method, stats_name)

  all_drivers_to_stats = drivers.map do |driver_id, rides|
    stats_value = method(method).call(drivers, driver_id)
    { :driver => driver_id, stats_name => stats_value }
  end

  top_driver_to_stats_pair = all_drivers_to_stats.max_by { |driver_to_stats| driver_to_stats[stats_name] }

  return top_driver_to_stats_pair
end


# Method prints which driver made the most money and prints how much
# Calls another method that returns a hash of driver and stats (e.g. { :driver => driver_id, :earnings => 100 } )
# Returns a string
def print_top_driver_to_earnings(drivers)
  top_driver_to_earnings = pair_driver_to_top_stats(drivers, :get_driver_earnings, :earnings)

  puts "Driver #{top_driver_to_earnings[:driver]} made the most money, raking in a whopping $#{'%.2f'%top_driver_to_earnings[:earnings]}. 💰Cha-ching!💰"
end


# Method prints which driver has the highest average rating and prints the rating
# Calls another method that returns a hash of driver and stats (e.g. { :driver => driver_id, :earnings => 100 } )
# Returns a string
def print_top_driver_to_average_rating(drivers)
  top_driver_to_average_rating = pair_driver_to_top_stats(drivers, :get_driver_average_rating, :average_rating)

  puts "Driver #{top_driver_to_average_rating[:driver]} has the highest average rating of #{top_driver_to_average_rating[:average_rating]} ⭐️'s. In-CAR-redible!"
end



# Iterates through drivers to print out each driver's:
# total rides, average rating, earnings, and highest earnings in a day and the date
puts "🚘 Drivers Summary 🚘"
drivers.each do |driver_id, rides|
  num_of_rides =  get_driver_total_rides(drivers, driver_id)
  average_rating = get_driver_average_rating(drivers, driver_id)
  earnings = get_driver_earnings(drivers, driver_id)

  top_earnings_by_date = get_driver_top_earnings_by_date(drivers, driver_id)
  top_earnings_date = top_earnings_by_date[0]
  top_earnings = top_earnings_by_date[1]

  puts "\nDriver: #{driver_id}"
  puts "Number of Rides:  #{"🚗" * num_of_rides} (#{num_of_rides})"
  puts "Average Rating: #{average_rating} ⭐️'s"
  puts "Total Earnings: $#{'%.2f'%earnings}   💰Cha-ching!💰"
  puts "Highest Earnings in a Day: $#{'%.2f'%top_earnings} on #{top_earnings_date}"
end

# Print drivers with top stats and print the stats including:
# highest total earnings and highest average rating
puts "\n\n🥇 🏆 🚘 Most Valuable Drivers 🚘 🏆 🥇\n\n"
print_top_driver_to_earnings(drivers)
print_top_driver_to_average_rating(drivers)
