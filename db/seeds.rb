# Create a user
user = User.create(
  name: "John Doe",
  email: "admin@example.com",
  role: "admin",
  password: "123456",
)

# Create multiple trades associated with the user
trades = [
  {
    name: "Trade 1",
    description: "Description for Trade 1",
    image: "trade1.jpg",
    location: "Location 1",
    price: 100.00,
    duration: "1 hour",
    trade_type: "Type 1",
    user: user # Associate the trade with the user
  },
  {
    name: "Trade 2",
    description: "Description for Trade 2",
    image: "trade2.jpg",
    location: "Location 2",
    price: 150.00,
    duration: "2 hours",
    trade_type: "Type 2",
    user: user # Associate the trade with the user
  }
]

Trade.create(trades)
