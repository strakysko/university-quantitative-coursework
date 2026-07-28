import pandas as pd
import matplotlib.pyplot as plt
import datetime as dt
from mpl_toolkits import mplot3d
import yfinance as yf
import pandas_datareader.data as web

# Get options data
ticker = yf.Ticker('SAP')

# This will fetch the available expiration dates for options
options_dates = ticker.options


# Loop through the available dates and fetch options data
df = pd.DataFrame()
today = dt.datetime.now()

for date in options_dates:
    # Fetching call and put options data for the given expiration date
    options_data = ticker.option_chain(date)

    # options_data is a namedtuple containing two dataframes: calls and puts
    calls = options_data.calls

    calls['timetomaturity'] = (pd.to_datetime(date) - today) / dt.timedelta(days=1)

    df = pd.concat([df, calls], ignore_index=True)

x = df["timetomaturity"]
y = df["strike"]
z = df["impliedVolatility"]
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

ax.set_xlabel('time to maturity')
ax.set_ylabel('strike')
ax.set_zlabel('Implied vol')
ax.scatter(x, y, z, c='red', marker='o')

plt.show()
