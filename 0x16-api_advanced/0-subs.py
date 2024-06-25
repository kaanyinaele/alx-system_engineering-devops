import requests

def number_of_subscribers(subreddit):
    try:
        # Construct the API URL
        url = f"https://www.reddit.com/r/{subreddit}/about.json"
        
        # Set a custom User-Agent header to avoid rate limiting
        headers = {"User-Agent": "my-app/0.0.1 (by /u/username)"}
        
        # Make the API request
        response = requests.get(url, headers=headers)
        
        # Check if the request was successful
        if response.status_code == 200:
            # Extract the subscriber count from the JSON response
            data = response.json()
            return data["data"]["subscribers"]
        else:
            # Return 0 if the subreddit is invalid
            return 0
    except:
        # Return 0 if there's any error
        return 0

